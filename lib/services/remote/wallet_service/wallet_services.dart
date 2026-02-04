import 'package:supabase_flutter/supabase_flutter.dart';

class WalletService {
  final SupabaseClient _client = Supabase.instance.client;

  /// GET WALLET BALANCE
  Future<double> getWalletBalance(String walletType) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    final data = await _client
        .from('wallets')
        .select('total')
        .eq('user_id', user.id)
        .eq('type', walletType)
        .single();

    return (data['total'] as num).toDouble();
  }

  /// UPDATE WALLET BALANCE
  Future<void> updateWalletBalance({
    required String walletType,
    required double newTotal,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _client.from('wallets').update({
      'total': newTotal,
      'updated_at': DateTime.now().toIso8601String(),
    })
        .eq('user_id', user.id)
        .eq('type', walletType);
  }

  /// CHANGE WALLET AMOUNT (+ / -)
  Future<void> changeWalletAmount({
    required String walletType,
    required double delta,
  }) async {
    final currentTotal = await getWalletBalance(walletType);
    final newTotal = currentTotal + delta;

    await updateWalletBalance(
      walletType: walletType,
      newTotal: newTotal,
    );
  }

  /// GET TOTAL AMOUNT (ALL WALLETS)
  Future<double> getTotalAmount() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    final data = await _client
        .from('wallets')
        .select('total')
        .eq('user_id', user.id);

    double sum = 0;
    for (final w in data as List) {
      sum += (w['total'] as num).toDouble();
    }

    return sum;
  }
}
