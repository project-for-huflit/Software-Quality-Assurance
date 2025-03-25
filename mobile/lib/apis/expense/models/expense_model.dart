class ExpenseModel {
  String? id;
  String amount;
  String category;
  String imageUrl;
  DateTime expenseAt;
  String wallet;
  DateTime? createdAt;
  DateTime? updatedAt;

  ExpenseModel({
    this.id,
    required this.amount,
    required this.category,
    required this.expenseAt,
    this.imageUrl = '',
    required this.wallet,
    this.createdAt, 
    this.updatedAt, 
  });

  ExpenseModel.formJson(Map<String, dynamic> json)
      : id = json['id'],
        amount = json['amount'],
        category = json['category'],
        imageUrl = json['imageUrl'],
        expenseAt = DateTime.parse(json['incomeAt']),
        wallet = json['wallet'],
        createdAt = json['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt']['_seconds'] * 1000)
          : null,
        updatedAt = json['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['updatedAt']['_seconds'] * 1000)
          : null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "amount": amount,
      "category": category,
      "wallet": wallet,
      "imageUrl": imageUrl,
      "incomeAt": expenseAt.toIso8601String(),
      "createdAt": createdAt != null
        ? {
            "_seconds": createdAt!.millisecondsSinceEpoch ~/ 1000,
            "_nanoseconds": (createdAt!.millisecondsSinceEpoch % 1000) * 1000000
          }
        : null,
      "updatedAt": updatedAt != null
        ? {
            "_seconds": updatedAt!.millisecondsSinceEpoch ~/ 1000,
            "_nanoseconds": (updatedAt!.millisecondsSinceEpoch % 1000) * 1000000
          }
        : null,
    };
  }
}