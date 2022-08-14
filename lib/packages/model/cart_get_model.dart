class GetCartModel {
  late bool status;
  late String message;
  CartData? data;

  GetCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CartData.fromJson(json['data']) : null;
  }
}

class CartData {
  List<CartItems>? cartItems;

  CartData.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((element) {
        cartItems!.add(CartItems.fromJson(element));
      });
    }
  }
}

class CartItems {
  ProductCart? productCart;

  CartItems.fromJson(Map<String, dynamic> json) {
    productCart =
        json['product'] != null ? ProductCart.fromJson(json['product']) : null;
  }
}

class ProductCart {
  late int id;
  dynamic price;
  dynamic oldPrice;
  late int discount;
  late String image;
  late String name;

  ProductCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
