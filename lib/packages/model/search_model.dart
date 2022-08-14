class SearchModel {
  late bool status;
  late SearchData data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =SearchData.fromJson(json['data']);
  }
}

class SearchData {
 late List<ProductData> data;

  SearchData.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      data=<ProductData>[];
      json['data'].forEach((element){
        data.add(ProductData.fromJson(element));
      });

    }
  }
}

class ProductData {
  late dynamic id;
  late dynamic price;
  late String image;
  late String name;
  late String description;
  late dynamic discount;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    discount = json['discount'];
  }
}
