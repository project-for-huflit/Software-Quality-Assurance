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
        createdAt = json['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt']['_seconds'] * 1000)
          : null,
        updatedAt = json['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['updatedAt']['_seconds'] * 1000)
          : null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "name": name,
      "type": type,
      "amount": amount,
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