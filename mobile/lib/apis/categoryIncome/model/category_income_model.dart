class CategoryIncomeModel {
  String? id;
  String name;
  DateTime? createdAt;
  DateTime? updatedAt;

  CategoryIncomeModel({
    this.id,
    required this.name,
    this.createdAt, 
    this.updatedAt, 
  });

  CategoryIncomeModel.formJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
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