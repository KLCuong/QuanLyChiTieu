import 'supabase_error_type.dart';

class SupabaseError {
  final SupabaseErrorType type;
  final String code;
  final String message;
  final String? fixhint;
  final String? details;

  SupabaseError({
    required this.type,
    required this.code,
    required this.message,
    this.fixhint,
    this.details,
  });

  @override
  String toString() {
    return '''
    [SupabaseError]
    type: $type
    code: $code
    message: $message
    details: $details
    hint: $fixhint
    ''';
  }
}
