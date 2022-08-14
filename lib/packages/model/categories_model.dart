class CategoriesModel {
  late bool status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  late int currentPage;
  List<CategoriesData>? data;

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CategoriesData>[];
      json['data'].forEach((element) {
        data!.add(CategoriesData.fromJson(element));
      });
    }
  }
}

class CategoriesData {
  late int id;
  late String name;
  late String image;

  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
