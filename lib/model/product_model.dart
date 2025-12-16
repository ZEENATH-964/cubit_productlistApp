class ProductModel {
  final int id;
  final String title;
  final String body;
  ProductModel({required this.id,required this.title,required this.body});

  factory ProductModel.fromJson(Map<String,dynamic>json){
    return ProductModel(
      id: json["id"], 
      title: json["title"],
      body: json["body"]
      );
  }
}