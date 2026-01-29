import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  SupabaseServices._();

  static SupabaseClient get client => Supabase.instance.client;
}
