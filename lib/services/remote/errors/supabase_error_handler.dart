import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_error.dart';
import 'supabase_error_type.dart';

class SupabaseErrorHandler {
  static SupabaseError handle(dynamic error, {SupabaseErrorType? action}) {
    if (error is AuthException) {
      return _handleAuth(error);
    }

    if (error is PostgrestException) {
      return _handlePostgrest(error, action);
    }

    return SupabaseError(
      type: SupabaseErrorType.unknown,
      code: 'unknown_error',
      message: 'Something went wrong, pls try again',
      details: error.toString(),
    );
  }

  // ================= AUTH =================
  static SupabaseError _handleAuth(AuthException e) {
    late String message;

    switch (e.message) {
      case 'Invalid login credentials':
        message = 'Wrong email or password';
        break;
      case 'User already registered':
        message = 'This email already been used';
        break;
      case 'Email not confirmed':
        message = 'Email not confirmed';
        break;
      default:
        message = e.message;
    }

    return SupabaseError(
      type: SupabaseErrorType.auth,
      code: e.statusCode ?? 'auth_error',
      message: message,
      details: e.message,
    );
  }

  // ================= QUERY / CRUD =================
  static SupabaseError _handlePostgrest(
      PostgrestException e,
      SupabaseErrorType? action,
      ) {
    String message = _mapPostgrestMessage(e, action);

    return SupabaseError(
      type: action ?? SupabaseErrorType.query,
      code: e.code ?? 'db_error',
      message: message,
      fixhint: e.hint,
      details: e.details.toString(),
    );
  }

  static String _mapPostgrestMessage(
      PostgrestException e,
      SupabaseErrorType? action,
      ) {
    switch (action) {
      case SupabaseErrorType.insert:
        return 'Cant Insert, pls try again';
      case SupabaseErrorType.update:
        return 'Cant Update, pls try again';
      case SupabaseErrorType.delete:
        return 'Cant Delete, pls try again';
      case SupabaseErrorType.query:
        return 'Cant Query, pls try again';
      default:
        return e.message;
    }
  }
}
