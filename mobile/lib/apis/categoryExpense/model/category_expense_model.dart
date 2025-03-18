class CategoryExpenseModel {
  String name;

  CategoryExpenseModel({
    required this.name,
  });

  CategoryExpenseModel.formJson(Map<String, dynamic> json)
      : name = json['name'];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}