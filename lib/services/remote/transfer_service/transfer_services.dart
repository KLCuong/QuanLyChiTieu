import 'package:quanlychitieu/models/transfer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransferService {
  final SupabaseClient _client = Supabase.instance.client;

  /// LIST TRANSFERS
  Future<List<Transfer>> getTransferList({
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    var query = _client
        .from('transfers')
        .select()
        .eq('user_id', user.id);

    if (fromDate != null) {
      query = query.gte('date', fromDate.toIso8601String());
    }
    if (toDate != null) {
      query = query.lte('date', toDate.toIso8601String());
    }

    final data = await query.order('date', ascending: false);

    return (data as List)
        .map((e) => Transfer.fromJson(e))
        .toList();
  }

  /// CREATE TRANSFER
  Future<void> createTransfer(Transfer transfer) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _client.from('transfers').insert({
      ...transfer.toJson(),
      'user_id': user.id,
    });
  }

  /// DELETE TRANSFER
  Future<void> deleteTransfer(String transferId) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _client
        .from('transfers')
        .delete()
        .eq('id', transferId)
        .eq('user_id', user.id);
  }
}
