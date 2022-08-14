class HomeModel {
  late bool status;
  HomeModelData? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeModelData.fromJson(json['data']);
  }
}

class HomeModelData {
  List<HomeBannersModel>? banners;

  List<HomeProductsModel>? products;

  HomeModelData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <HomeBannersModel>[];
      json['banners'].forEach((element) {
        banners!.add(HomeBannersModel.fromJson(element));
      });
    }
    if (json['products'] != null) {
      products = <HomeProductsModel>[];
      json['products'].forEach((element) {
        products!.add(HomeProductsModel.fromJson(element));
      });
    }
  }
}

class HomeBannersModel {
  late int id;
  late String image;

  HomeBannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class HomeProductsModel {
  late int id;
   dynamic price;
   dynamic oldPrice;
   dynamic disCount;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;
  late bool inCart;

  HomeProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    disCount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
