class Transfer {
  final String id;
  final String userId;

  final String fromWallet;
  final String toWallet;
  final double amount;
  final DateTime date;
  final String? note;

  final DateTime createdAt;

  Transfer({
    required this.id,
    required this.userId,
    required this.fromWallet,
    required this.toWallet,
    required this.amount,
    required this.date,
    this.note,
    required this.createdAt,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      id: json['id'],
      userId: json['user_id'],
      fromWallet: json['from_wallet'],
      toWallet: json['to_wallet'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      note: json['note'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from_wallet': fromWallet,
      'to_wallet': toWallet,
      'amount': amount,
      'date': date.toIso8601String(),
      'note': note,
    };
  }
}
