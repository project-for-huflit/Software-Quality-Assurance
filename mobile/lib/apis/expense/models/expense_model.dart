class ExpenseModel {
  String amount;
  String category;
  String imageUrl;
  DateTime expenseAt;
  String wallet;

  ExpenseModel({
    required this.amount,
    required this.category,
    required this.expenseAt,
    this.imageUrl = '',
    required this.wallet,
  });

  ExpenseModel.formJson(Map<String, dynamic> json)
      : amount = json['amount'],
        category = json['category'],
        imageUrl = json['imageUrl'],
        expenseAt = DateTime.parse(json['incomeAt']),
        wallet = json['wallet'];

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "category": category,
      "wallet": wallet,
      "imageUrl": imageUrl,
      "incomeAt": expenseAt.toIso8601String(),
    };
  }
}