import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../../shared/widgets/tripmetic_app_bar_title.dart';
import '../../../shared/widgets/tripmetic_hub_app_bar_actions.dart';
import '../application/firebase_auth_error_message.dart';
import '../application/post_auth_sync.dart';

/// Full-screen email sign-in with cloud sync for bucket list and group trips.
///
/// Closes immediately if the user is already signed in. Account is optional
/// for using Tripmetic elsewhere.
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _busy = false;
  bool _resetBusy = false;

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
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  bool _isValidEmail(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return false;
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }

  void _showError(String message) {
    final cs = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: cs.error,
        content: Text(message, style: TextStyle(color: cs.onError)),
      ),
    );
  }

  Future<void> _sendPasswordReset() async {
    final l10n = context.l10n;
    final email = _email.text.trim();
    if (!_isValidEmail(email)) {
      _showError(l10n.bucketListAuthFailed(l10n.bucketListAuthValidationInvalidEmail));
      return;
    }

    setState(() => _resetBusy = true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.authPasswordResetConfirmation)),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      if (e.code == 'invalid-email') {
        _showError(l10n.bucketListAuthFailed(l10n.bucketListAuthErrInvalidEmail));
      } else if (e.code == 'user-not-found') {
        // Do not reveal whether the email is registered (enumeration).
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.authPasswordResetConfirmation)),
        );
      } else {
        _showError(l10n.bucketListAuthFailed(firebaseAuthErrorMessage(e, l10n)));
      }
    } catch (_) {
      if (!mounted) return;
      _showError(l10n.authUnexpectedError);
    } finally {
      if (mounted) setState(() => _resetBusy = false);
    }
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final email = _email.text.trim();
    final password = _password.text;

    if (!_isValidEmail(email)) {
      _showError(l10n.bucketListAuthFailed(l10n.bucketListAuthValidationInvalidEmail));
      return;
    }
    if (password.isEmpty) {
      _showError(l10n.bucketListAuthFailed(l10n.bucketListAuthValidationPasswordRequired));
      return;
    }

    setState(() => _busy = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      _showError(l10n.bucketListAuthFailed(firebaseAuthErrorMessage(e, l10n)));
      return;
    } catch (_) {
      if (!mounted) return;
      _showError(l10n.authUnexpectedError);
      return;
    } finally {
      if (mounted) setState(() => _busy = false);
    }

    if (!mounted) return;
    final container = ProviderScope.containerOf(context);
    unawaited(syncUserCloudDataAfterLogin(container));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF2E7D32),
        content: Text(
          l10n.bucketListAuthSuccessSignIn,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final anyBusy = _busy || _resetBusy;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: TripmeticAppBarTitle(subtitle: l10n.authSignInScreenTitle),
        actions: tripmeticHubAppBarActions(context, ref),
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
                    l10n.authSignInScreenSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 22),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: l10n.bucketListBackupEmail,
                      border: const OutlineInputBorder(),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: anyBusy ? null : _sendPasswordReset,
                      child: Text(l10n.authForgotPassword),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_busy)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    FilledButton(
                      onPressed: anyBusy ? null : _submit,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.onAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(l10n.bucketListSignIn),
                    ),
                  if (_resetBusy) ...[
                    const SizedBox(height: 8),
                    const Center(
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: anyBusy ? null : () => context.pushReplacement('/sign-up'),
                    child: Text(l10n.authLinkNeedAccount),
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
