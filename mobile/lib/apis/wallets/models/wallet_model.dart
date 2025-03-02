class WalletModel {
  String? title;
	String? type;
	bool? isPublished;
	String? imageUrl;

  WalletModel({this.title, this.type, this.isPublished, this.imageUrl});

  
  WalletModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        type = json['type'],
        isPublished = json['email'],
        imageUrl = json['phone'];
}