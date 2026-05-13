import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../../shared/widgets/tripmetic_app_bar_title.dart';
import '../application/post_auth_sync.dart';

/// Full-screen registration: display name, email, password — then cloud sync
/// for bucket list and group-trip data tied to the new account.
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _displayName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _busy = false;
  String? _emailError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (FirebaseAuth.instance.currentUser != null) {
        context.pop();
      }
    });
  }

  @override
  void dispose() {
    _displayName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  bool _isValidEmail(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return false;
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }

  void _showError(String message, {SnackBarAction? action}) {
    final cs = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: cs.error,
        content: Text(message, style: TextStyle(color: cs.onError)),
        action: action,
      ),
    );
  }

  void _handleAuthException(FirebaseAuthException e) {
    final l10n = context.l10n;
    switch (e.code) {
      case 'email-already-in-use':
        setState(() => _emailError = l10n.signUpErrorEmailInUse);
        _showError(
          l10n.signUpErrorEmailInUse,
          action: SnackBarAction(
            label: l10n.signUpErrorEmailInUseAction,
            textColor: Theme.of(context).colorScheme.onError,
            onPressed: () {
              if (!mounted) return;
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              context.pushReplacement('/sign-in');
            },
          ),
        );
        return;
      case 'invalid-email':
        setState(() => _emailError = l10n.signUpErrorInvalidEmail);
        _showError(l10n.signUpErrorInvalidEmail);
        return;
      case 'weak-password':
        _showError(l10n.signUpErrorWeakPassword);
        return;
      default:
        _showError(l10n.signUpErrorGeneric(e.message ?? e.code));
        return;
    }
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final email = _email.text.trim();
    final password = _password.text;
    final confirm = _confirmPassword.text;
    final displayName = _displayName.text.trim();

    setState(() => _emailError = null);

    if (displayName.isEmpty) {
      _showError(l10n.bucketListAuthFailed(l10n.bucketListAuthValidationDisplayName));
      return;
    }
    if (!_isValidEmail(email)) {
      setState(() => _emailError = l10n.signUpErrorInvalidEmail);
      _showError(l10n.signUpErrorInvalidEmail);
      return;
    }
    if (password.length < 6) {
      _showError(l10n.signUpErrorWeakPassword);
      return;
    }
    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.bucketListAuthPasswordMismatch)),
      );
      return;
    }

    setState(() => _busy = true);
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(displayName);
      await credential.user?.reload();
      await syncUserCloudDataAfterLogin(ref);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF2E7D32),
          content: Text(
            l10n.signUpSuccessMessage,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
      context.pop();
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      _handleAuthException(e);
    } catch (e) {
      if (!mounted) return;
      _showError(l10n.signUpErrorGeneric(e.toString()));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: TripmeticAppBarTitle(subtitle: l10n.authSignUpScreenTitle),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.authSignUpScreenSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _BulletRow(icon: Icons.star_border_rounded, text: l10n.authBackupBulletBucketList),
                  _BulletRow(icon: Icons.groups_outlined, text: l10n.authBackupBulletGroupTrips),
                  _BulletRow(icon: Icons.devices_outlined, text: l10n.authBackupBulletMultiDevice),
                  const SizedBox(height: 22),
                  TextField(
                    controller: _displayName,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: l10n.bucketListDisplayNameLabel,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    onChanged: (_) {
                      if (_emailError != null) {
                        setState(() => _emailError = null);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: l10n.bucketListBackupEmail,
                      border: const OutlineInputBorder(),
                      errorText: _emailError,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: l10n.bucketListBackupPassword,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _confirmPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: l10n.bucketListBackupConfirmPassword,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 22),
                  if (_busy)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    FilledButton(
                      onPressed: _submit,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.onAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(l10n.bucketListRegister),
                    ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: _busy ? null : () => context.pushReplacement('/sign-in'),
                    child: Text(l10n.authLinkAlreadyHaveAccount),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
