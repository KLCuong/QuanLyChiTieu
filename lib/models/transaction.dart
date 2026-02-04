class Transaction {
  final String id;
  final String userId;

  final String type; // expense | income
  final String category;
  final String wallet;

  final double amount;
  final DateTime date;
  final String? note;

  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.type,
    required this.category,
    required this.wallet,
    required this.amount,
    required this.date,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: json['type'] as String,
      category: json['category'] as String,
      wallet: json['wallet'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      note: json['note'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'type': type,
      'category': category,
      'wallet': wallet,
      'amount': amount,
      'date': date.toIso8601String(),
      'note': note,
    };
  }
}
