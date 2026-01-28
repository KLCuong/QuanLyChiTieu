import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quanlychitieu/configs/supabase_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'routes/app_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //local data init
  await Hive.initFlutter();
  //supabase init
  await Supabase.initialize(
      url: SupabaseKeys.supa_url,
      anonKey: SupabaseKeys.supa_anon_key
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'GoRouter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}