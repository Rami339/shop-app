import '../../../model/login_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitial extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  final ShopLoginModel shopLoginModel;

  ShopLoginSuccessState(this.shopLoginModel);
}

class ShopLoginErrorState extends ShopLoginState {}

class ShopLoginGetToken extends ShopLoginState {}

class ShopLoginIsHiddenPassword extends ShopLoginState {}
