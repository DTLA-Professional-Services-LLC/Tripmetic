import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../auth/application/firebase_auth_error_message.dart';
import '../../auth/application/post_auth_sync.dart';
import '../application/bucket_list_auth_providers.dart';

Future<void> showBucketListBackupSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) => const _BucketListBackupContent(),
  );
}

enum _GuestAuthMode { login, signUp }

class _BucketListBackupContent extends ConsumerStatefulWidget {
  const _BucketListBackupContent();

  @override
  ConsumerState<_BucketListBackupContent> createState() =>
      _BucketListBackupContentState();
}

class _BucketListBackupContentState extends ConsumerState<_BucketListBackupContent> {
  final _email = TextEditingController();
  final _displayName = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _GuestAuthMode _guestMode = _GuestAuthMode.login;
  bool _busy = false;

  bool _isValidEmail(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return false;
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }

  @override
  void dispose() {
    _email.dispose();
    _displayName.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _showAuthErrorSnack(String message) {
    final cs = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: cs.error,
        content: Text(
          message,
          style: TextStyle(color: cs.onError),
        ),
      ),
    );
  }

  void _showAuthSuccessSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF2E7D32),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _signUpAndBackup() async {
    final l10n = context.l10n;
    final email = _email.text.trim();
    final password = _password.text;
    final confirm = _confirmPassword.text;

    if (!_isValidEmail(email)) {
      _showAuthErrorSnack(
        l10n.bucketListAuthFailed(l10n.bucketListAuthValidationInvalidEmail),
      );
      return;
    }
    if (password.length < 6) {
      _showAuthErrorSnack(
        l10n.bucketListAuthFailed(l10n.bucketListAuthValidationPasswordShort),
      );
      return;
    }
    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.bucketListAuthPasswordMismatch)),
      );
      return;
    }

    final displayName = _displayName.text.trim();
    if (displayName.isEmpty) {
      _showAuthErrorSnack(
        l10n.bucketListAuthFailed(l10n.bucketListAuthValidationDisplayName),
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
      _showAuthSuccessSnack(l10n.bucketListAuthSuccessSignUp);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      _showAuthErrorSnack(
        l10n.bucketListAuthFailed(firebaseAuthErrorMessage(e, l10n)),
      );
    } catch (e) {
      if (!mounted) return;
      _showAuthErrorSnack(l10n.bucketListAuthFailed('$e'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signInAndBackup() async {
    final l10n = context.l10n;
    final email = _email.text.trim();
    final password = _password.text;

    if (!_isValidEmail(email)) {
      _showAuthErrorSnack(
        l10n.bucketListAuthFailed(l10n.bucketListAuthValidationInvalidEmail),
      );
      return;
    }
    if (password.isEmpty) {
      _showAuthErrorSnack(
        l10n.bucketListAuthFailed(l10n.bucketListAuthValidationPasswordRequired),
      );
      return;
    }

    setState(() => _busy = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await syncUserCloudDataAfterLogin(ref);
      if (!mounted) return;
      _showAuthSuccessSnack(l10n.bucketListAuthSuccessSignIn);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      _showAuthErrorSnack(
        l10n.bucketListAuthFailed(firebaseAuthErrorMessage(e, l10n)),
      );
    } catch (e) {
      if (!mounted) return;
      _showAuthErrorSnack(l10n.bucketListAuthFailed('$e'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signOut() async {
    setState(() => _busy = true);
    try {
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.bucketListAuthFailed('$e'))),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final authAsync = ref.watch(firebaseAuthUserProvider);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderSubtle,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                l10n.bucketListBackupTitle,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              authAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.accent),
                  ),
                ),
                error: (_, _) => Text(
                  l10n.bucketListBackupGuestIntro,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                data: (user) {
                  if (user != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          l10n.bucketListSignedInAs(user.email ?? user.uid),
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: _busy ? null : _signOut,
                          child: Text(l10n.bucketListSignOut),
                        ),
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.bucketListBackupGuestIntro,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SegmentedButton<_GuestAuthMode>(
                        segments: [
                          ButtonSegment<_GuestAuthMode>(
                            value: _GuestAuthMode.login,
                            label: Text(l10n.bucketListSignIn),
                            icon: const Icon(Icons.login_rounded, size: 18),
                          ),
                          ButtonSegment<_GuestAuthMode>(
                            value: _GuestAuthMode.signUp,
                            label: Text(l10n.bucketListAuthTabSignUp),
                            icon: const Icon(Icons.person_add_outlined, size: 18),
                          ),
                        ],
                        selected: <_GuestAuthMode>{_guestMode},
                        onSelectionChanged: (Set<_GuestAuthMode> next) {
                          setState(() {
                            _guestMode = next.single;
                            _confirmPassword.clear();
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: l10n.bucketListBackupEmail,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      if (_guestMode == _GuestAuthMode.signUp) ...[
                        const SizedBox(height: 12),
                        TextField(
                          controller: _displayName,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: l10n.bucketListDisplayNameLabel,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: l10n.bucketListBackupPassword,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      if (_guestMode == _GuestAuthMode.signUp) ...[
                        const SizedBox(height: 12),
                        TextField(
                          controller: _confirmPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: l10n.bucketListBackupConfirmPassword,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      if (_busy)
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.accent,
                            ),
                          ),
                        )
                      else if (_guestMode == _GuestAuthMode.login)
                        FilledButton(
                          onPressed: _signInAndBackup,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: AppColors.onAccent,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(l10n.bucketListSignIn),
                        )
                      else
                        FilledButton(
                          onPressed: _signUpAndBackup,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: AppColors.onAccent,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(l10n.bucketListRegister),
                        ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _busy
                            ? null
                            : () {
                                final router = GoRouter.of(context);
                                Navigator.of(context).pop();
                                router.push('/sign-up');
                              },
                        child: Text(l10n.authFullSignUpCta),
                      ),
                      TextButton(
                        onPressed: _busy
                            ? null
                            : () {
                                final router = GoRouter.of(context);
                                Navigator.of(context).pop();
                                router.push('/sign-in');
                              },
                        child: Text(l10n.authFullSignInCta),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
