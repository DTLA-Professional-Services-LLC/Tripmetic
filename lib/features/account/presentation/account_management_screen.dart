import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../auth/application/auth_session.dart';
import '../../bucket_list/application/bucket_list_auth_providers.dart';

/// Screen for editing the Firebase Auth profile of the signed-in user.
///
/// - Display name: [User.updateDisplayName].
/// - Email: [User.verifyBeforeUpdateEmail] (sends a verification link).
/// - Password: [User.updatePassword] (requires recent sign-in).
class AccountManagementScreen extends ConsumerStatefulWidget {
  const AccountManagementScreen({super.key});

  @override
  ConsumerState<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState
    extends ConsumerState<AccountManagementScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _newPasswordCtrl;

  final _nameFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  bool _savingName = false;
  bool _savingEmail = false;
  bool _savingPassword = false;

  @override
  void initState() {
    super.initState();
    final u = FirebaseAuth.instance.currentUser;
    _nameCtrl = TextEditingController(text: u?.displayName ?? '');
    _emailCtrl = TextEditingController(text: u?.email ?? '');
    _newPasswordCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _newPasswordCtrl.dispose();
    super.dispose();
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _saveName(AppLocalizations l10n) async {
    if (!_nameFormKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showSnack(l10n.accountSignedOutMessage);
      return;
    }
    setState(() => _savingName = true);
    try {
      await user.updateDisplayName(_nameCtrl.text.trim());
      await user.reload();
      // Belt & braces: [firebaseAuthUserProvider] is backed by
      // [FirebaseAuth.userChanges] which already fires on display-name
      // updates, so this invalidate is usually redundant. We still issue it
      // to guarantee every consumer (dashboard greeting, bucket-list share
      // overlay) re-evaluates immediately after this `await`.
      ref.invalidate(firebaseAuthUserProvider);
      if (!mounted) return;
      _showSnack(l10n.accountNameSaved);
      setState(() {});
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      _showSnack(
        l10n.accountErrorGeneric(l10n.accountFieldDisplayName, e.message ?? e.code),
      );
    } catch (e) {
      if (!mounted) return;
      _showSnack(
        l10n.accountErrorGeneric(l10n.accountFieldDisplayName, '$e'),
      );
    } finally {
      if (mounted) setState(() => _savingName = false);
    }
  }

  Future<void> _changeEmail(AppLocalizations l10n) async {
    if (!_emailFormKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showSnack(l10n.accountSignedOutMessage);
      return;
    }
    final newEmail = _emailCtrl.text.trim();
    setState(() => _savingEmail = true);
    try {
      await user.verifyBeforeUpdateEmail(newEmail);
      if (!mounted) return;
      _showSnack(l10n.accountEmailVerificationSent(newEmail));
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      if (e.code == 'requires-recent-login') {
        await _showReauthDialog(l10n, l10n.accountFieldLabelEmail);
      } else {
        _showSnack(
          l10n.accountErrorGeneric(l10n.accountFieldEmail, e.message ?? e.code),
        );
      }
    } catch (e) {
      if (!mounted) return;
      _showSnack(l10n.accountErrorGeneric(l10n.accountFieldEmail, '$e'));
    } finally {
      if (mounted) setState(() => _savingEmail = false);
    }
  }

  Future<void> _changePassword(AppLocalizations l10n) async {
    if (!_passwordFormKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showSnack(l10n.accountSignedOutMessage);
      return;
    }
    setState(() => _savingPassword = true);
    try {
      await user.updatePassword(_newPasswordCtrl.text);
      if (!mounted) return;
      _newPasswordCtrl.clear();
      _showSnack(l10n.accountPasswordChanged);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      if (e.code == 'requires-recent-login') {
        await _showReauthDialog(l10n, l10n.accountFieldLabelPassword);
      } else {
        _showSnack(
          l10n.accountErrorGeneric(
            l10n.accountFieldNewPassword,
            e.message ?? e.code,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      _showSnack(
        l10n.accountErrorGeneric(l10n.accountFieldNewPassword, '$e'),
      );
    } finally {
      if (mounted) setState(() => _savingPassword = false);
    }
  }

  Future<void> _showReauthDialog(
    AppLocalizations l10n,
    String fieldLabel,
  ) async {
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.accountReauthAction),
        content: Text(l10n.accountReauthRequired(fieldLabel)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await signOutTripmeticSession(ref);
              if (!mounted) return;
              context.go('/sign-in');
            },
            child: Text(l10n.accountSignInCta),
          ),
        ],
      ),
    );
  }

  bool _isLikelyEmail(String value) {
    final email = value.trim();
    if (email.isEmpty || !email.contains('@')) return false;
    final parts = email.split('@');
    if (parts.length != 2) return false;
    return parts[0].isNotEmpty && parts[1].contains('.');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.accountSignedOutMessage,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go('/sign-in'),
                child: Text(l10n.accountSignInCta),
              ),
            ],
          ),
        ),
      );
    }

    final sectionLabel = theme.textTheme.labelSmall?.copyWith(
      color: cs.onSurfaceVariant,
      letterSpacing: 0.8,
    );

    Card sectionCard({required Widget child}) => Card(
          elevation: 0,
          color: cs.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: cs.primary.withValues(alpha: 0.28)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: child,
          ),
        );

    return SafeArea(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.accountSectionProfile, style: sectionLabel),
            const SizedBox(height: 8),
            sectionCard(
              child: Form(
                key: _nameFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameCtrl,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: l10n.accountFieldDisplayName,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return l10n.accountValidationNameRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: _savingName ? null : () => _saveName(l10n),
                      icon: _savingName
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.save_outlined),
                      label: Text(l10n.accountSaveName),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(l10n.accountSectionSignIn, style: sectionLabel),
            const SizedBox(height: 8),
            sectionCard(
              child: Form(
                key: _emailFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if ((user.email ?? '').isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          l10n.accountCurrentEmailLabel(user.email ?? ''),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ),
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: l10n.accountFieldEmail,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) {
                        final value = (v ?? '').trim();
                        if (value.isEmpty) {
                          return l10n.accountValidationEmailRequired;
                        }
                        if (!_isLikelyEmail(value)) {
                          return l10n.accountValidationEmailInvalid;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: _savingEmail ? null : () => _changeEmail(l10n),
                      icon: _savingEmail
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.alternate_email_rounded),
                      label: Text(l10n.accountChangeEmail),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            sectionCard(
              child: Form(
                key: _passwordFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _newPasswordCtrl,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: l10n.accountFieldNewPassword,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v == null || v.length < 8) {
                          return l10n.accountValidationPasswordTooShort;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed:
                          _savingPassword ? null : () => _changePassword(l10n),
                      icon: _savingPassword
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.lock_reset_rounded),
                      label: Text(l10n.accountChangePassword),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: TextButton.icon(
                onPressed: () => context.go('/sign-in'),
                icon: Icon(Icons.login_rounded, color: AppColors.accent),
                label: Text(l10n.accountReauthAction),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
