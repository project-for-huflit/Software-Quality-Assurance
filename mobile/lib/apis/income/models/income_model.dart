class IncomeModel {
  String amount;
  String category;
  String imageUrl;
  DateTime incomeAt;
  String wallet;

  IncomeModel({
    required this.amount,
    required this.category,
    required this.incomeAt,
    this.imageUrl = '',
    required this.wallet,
  });

  IncomeModel.formJson(Map<String, dynamic> json)
      : amount = json['amount'],
        category = json['category'],
        imageUrl = json['imageUrl'],
        incomeAt = DateTime.parse(json['incomeAt']),
        wallet = json['wallet'];

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "category": category,
      "wallet": wallet,
      "imageUrl": imageUrl,
      "incomeAt": incomeAt.toIso8601String(),
    };
  }
}