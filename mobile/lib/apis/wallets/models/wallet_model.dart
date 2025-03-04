class WalletModel {
  String name;
	String type;
	int amount;

  WalletModel({
    required this.name, 
    required this.type, 
    required this.amount, 
  });
  
  WalletModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'],
        amount = json['amount'] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "type": type,
      "amount": amount,
    };
  }
}