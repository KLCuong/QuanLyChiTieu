

import 'package:quanlychitieu/models/transaction.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionService{
  final SupabaseClient _client = Supabase.instance.client;

  /// CREATE TRANSACTION
  Future<void> createTransaction(Transaction transaction) async{
    final user = _client.auth.currentUser;
    if(user == null){
      throw Exception("Where is the user?");
    }
    await _client.from('transactions').insert({
      ...transaction.toJson(),
      'user_id': user.id
    });
  }

  /// READ TRANSACTIONS
  Future<List<Transaction>> getTransactionList({
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    var query = _client
        .from('transactions')
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
        .map((e) => Transaction.fromJson(e))
        .toList();
  }



  /// READ TRANSACTION BY ID
  Future<Transaction?> getTransactionById(String transactionId) async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final data = await _client
        .from('transactions')
        .select()
        .eq('id', transactionId)
        .eq('user_id', user.id)
        .maybeSingle();

    if (data == null) return null;
    return Transaction.fromJson(data);
  }

  /// UPDATE TRANSACTION
  Future<void> updateTransaction({
    required String transactionId,
    String? type,
    String? category,
    String? wallet,
    double? amount,
    DateTime? date,
    String? note,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception("Where is the user?");
    }

    await _client.from('transactions').update({
      if (type != null) 'type': type,
      if (category != null) 'category': category,
      if (wallet != null) 'wallet': wallet,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date.toIso8601String(),
      if (note != null) 'note': note,
      'updated_at': DateTime.now().toIso8601String(),
    })
        .eq('id', transactionId)
        .eq('user_id', user.id);
  }

  /// DELETE
  Future<void> deleteTransaction(String transactionId) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception("Where is the user?");
    }

    await _client
        .from('transactions')
        .delete()
        .eq('id', transactionId)
        .eq('user_id', user.id);
  }

}