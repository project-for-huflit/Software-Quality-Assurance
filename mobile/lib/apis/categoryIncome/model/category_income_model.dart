class CategoryIncomeModel {
  String name;

  CategoryIncomeModel({
    required this.name,
  });

  CategoryIncomeModel.formJson(Map<String, dynamic> json)
      : name = json['name'];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}