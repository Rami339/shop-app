class ShopLoginModel {
  late bool status;
  late dynamic message;
ShopLoginData? data;
ShopLoginModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  message=json['message'];
  data=json['data']!=null?ShopLoginData.fromJson(json['data']):null;
}

}

class ShopLoginData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;

  ShopLoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}
