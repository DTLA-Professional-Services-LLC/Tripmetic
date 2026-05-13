import 'package:firebase_auth/firebase_auth.dart';

import '../../../l10n/l10n_helpers.dart';

String firebaseAuthErrorMessage(FirebaseAuthException e, AppLocalizations l10n) {
  switch (e.code) {
    case 'user-not-found':
      return l10n.bucketListAuthErrUserNotFound;
    case 'wrong-password':
    case 'invalid-credential':
      return l10n.bucketListAuthErrWrongPassword;
    case 'email-already-in-use':
      return l10n.bucketListAuthErrEmailInUse;
    case 'invalid-email':
      return l10n.bucketListAuthErrInvalidEmail;
    case 'weak-password':
      return l10n.bucketListAuthErrWeakPassword;
    case 'user-disabled':
      return l10n.bucketListAuthErrUserDisabled;
    case 'too-many-requests':
      return l10n.bucketListAuthErrTooManyRequests;
    case 'operation-not-allowed':
      return l10n.bucketListAuthErrOperationNotAllowed;
    default:
      return l10n.bucketListAuthErrDetail(e.message ?? e.code);
  }
}
