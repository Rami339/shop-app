import 'package:shop_app/packages/model/favorites_model.dart';
import 'package:shop_app/packages/model/home_model.dart';
import 'package:shop_app/packages/model/login_model.dart';

import '../model/cart_model.dart';

abstract class ShopCubitStates {}

class ShopInitialState extends ShopCubitStates {}

class ShopGetHomeLoadingState extends ShopCubitStates {
  final HomeModel? homeModel;

  ShopGetHomeLoadingState(this.homeModel);
}

class ShopGetHomeSuccessState extends ShopCubitStates {}

class ShopGetHomeErrorState extends ShopCubitStates {}

class ShopGetCategoriesSuccessState extends ShopCubitStates {}

class ShopGetCategoriesErrorState extends ShopCubitStates {}

class ShopChangeFavoritesSuccessState extends ShopCubitStates {
  final FavoritesModel favoritesModel;

  ShopChangeFavoritesSuccessState(this.favoritesModel);
}

class ShopChangeFavoritesErrorState extends ShopCubitStates {}

class ShopGetFavoritesLoadingState extends ShopCubitStates {}

class ShopGetFavoritesSuccessState extends ShopCubitStates {}

class ShopGetFavoritesErrorState extends ShopCubitStates {}

class ShopChangeCartLoadingState extends ShopCubitStates {}

class ShopChangeCartSuccessState extends ShopCubitStates {
  late final CartModel getCartModel;

  ShopChangeCartSuccessState(this.getCartModel);
}

class ShopChangeCartErrorState extends ShopCubitStates {}

class ShopGetCartLoadingState extends ShopCubitStates {}

class ShopGetCartSuccessState extends ShopCubitStates {}

class ShopGetCartErrorState extends ShopCubitStates {}

class ShopGetProfileSuccessState extends ShopCubitStates {}

class ShopGetProfileErrorState extends ShopCubitStates {}

class ShopEditProfileLoadingState extends ShopCubitStates {}

class ShopEditProfileSuccessState extends ShopCubitStates {
  late ShopLoginModel? shopLoginModel;

  ShopEditProfileSuccessState(this.shopLoginModel);
}

class ShopCubitMenuSelectedState extends ShopCubitStates {}

class ShopEditProfileErrorState extends ShopCubitStates {}

class ShopCubitHideTextErrorState extends ShopCubitStates {}

class ShopCubitShowTextErrorState extends ShopCubitStates {}

class ShopCubitIsModeState extends ShopCubitStates {}

class ShopCubitIsAppModeState extends ShopCubitStates {}

class ShopCubitDropDownValueState extends ShopCubitStates {}

class ShopCubitReadMoreDescriptionState extends ShopCubitStates {}

class ShopCubitDefaultReadMoreState extends ShopCubitStates {}

class ShopCubitSearchProductLoadingState extends ShopCubitStates {}

class ShopCubitSearchProductSuccessState extends ShopCubitStates {}

class ShopCubitSearchProductErrorState extends ShopCubitStates {}

class ShopCubitSetSplashLoadedState extends ShopCubitStates {}
