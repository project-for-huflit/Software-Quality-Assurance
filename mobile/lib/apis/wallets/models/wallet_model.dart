class WalletModel {
  String? id;
  String name;
	String type;
	int amount;
  DateTime? createdAt;
  DateTime? updatedAt;

  WalletModel({
    this.id,
    required this.name, 
    required this.type, 
    required this.amount, 
    this.createdAt, 
    this.updatedAt, 
  });
  
  WalletModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        amount = json['amount'] ?? 0,
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "name": name,
      "type": type,
      "amount": amount,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}