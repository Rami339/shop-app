class FavoritesGetModel {
  late bool? status;
  FavoritesGet? data;

  FavoritesGetModel.fromJson(Map<String, dynamic> json) {
    data = FavoritesGet.fromJson(json['data']);
  }
}

class FavoritesGet {
  late int currentPage;
  late List<ProductFavoritesData> data;

  FavoritesGet.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductFavoritesData>[];
      json['data'].forEach(
        (element) {
          data.add(ProductFavoritesData.fromJson(element));
        },
      );
    }
  }
}

class ProductFavoritesData {
  late int id;
  late ProductData? data;

  ProductFavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = ProductData.fromJson(json['product']);
  }
}

class ProductData {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late dynamic image;
  late dynamic name;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
