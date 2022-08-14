



import '../../../model/login_model.dart';

abstract class ShopSignUpState {}

class ShopSignUpInitial extends ShopSignUpState {}

class ShopSignUpLoadingState extends ShopSignUpState {}

class ShopSignUpSuccessState extends ShopSignUpState {
  final ShopLoginModel shopSignUPModel;

  ShopSignUpSuccessState(this.shopSignUPModel);
}

class ShopSignUpErrorState extends ShopSignUpState {}
