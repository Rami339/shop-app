import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/packages/cubit/state.dart';
import 'package:shop_app/packages/helper/cache_helper.dart';
import 'package:shop_app/packages/model/cart_model.dart';
import '../components/components.dart';
import '../constants/constants.dart';
import '../constants/end_point.dart';
import '../constants/shared_pref_key.dart';
import '../helper/dio_helper.dart';
import '../lang/lang_cubit.dart';
import '../model/cart_get_model.dart';
import '../model/categories_model.dart';
import '../model/favorites_get_model.dart';
import '../model/favorites_model.dart';
import '../model/home_model.dart';
import '../model/login_model.dart';
import '../model/search_model.dart';
import '../modules/categories_screen/categories_screen.dart';
import '../modules/favorites_screen/favorites_screen.dart';
import '../modules/settings_screen/settings_screen.dart';

class ShopCubit extends Cubit<ShopCubitStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  void menuSelected(int menu, context) {
    if (menu == 1) {
      getProfileData();
      navigateTo(context, const SettingsScreen());
    }
    if (menu == 2) {
      navigateTo(context, const FavoritesScreen());
      getFavorites();
    }
    if (menu == 3) {
      navigateTo(context, const CategoriesScreen());
    }

    emit(ShopCubitMenuSelectedState());
  }

  HomeModel? homeModel;
  Map<int, bool> addFavorites = {};
  Map<int, bool> addCart = {};

  void getHomeData() {
    emit(ShopGetHomeLoadingState(homeModel));
    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      emit(ShopGetHomeSuccessState());
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products?.forEach((element) {
        addFavorites.addAll({element.id: element.inFavorites});
      });
      homeModel?.data?.products?.forEach((element) {
        addCart.addAll({element.id: element.inCart});
      });
      print(addFavorites.toString());
      print(addCart.toString());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetHomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: categories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopGetCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetCategoriesErrorState());
    });
  }

  GetCartModel? getCartModel;

  void getCarts() {
    emit(ShopGetCartLoadingState());
    DioHelper.getData(
      url: getCart,
      token: token,
    ).then((value) {
      getCartModel = GetCartModel.fromJson(value.data);
      emit(ShopGetCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetCartErrorState());
    });
  }

  CartModel? cartModel;

  void changeCart(int id) {
    addCart[id] = !addCart[id]!;
    // emit((ShopChangeCartSuccessState()));
    DioHelper.postData(
      url: buyProduct,
      token: token,
      data: {
        "product_id": id,
      },
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      if (!cartModel!.status) {
        addCart[id] = !addCart[id]!;
      } else {
        getCarts();
      }
      emit(ShopChangeCartSuccessState(cartModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopChangeCartErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void changeFavorites(int id) {
    addFavorites[id] = !addFavorites[id]!;
    //emit(ShopChangeFavoritesSuccessState());
    DioHelper.postData(
      url: favorites,
      token: token,
      data: {
        'product_id': id,
      },
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      if (!favoritesModel!.status) {
        addFavorites[id] = !addFavorites[id]!;
      } else {
        getFavorites();
      }

      emit(ShopChangeFavoritesSuccessState(favoritesModel!));
    }).catchError((error) {
      print(error.toString());
      addFavorites[id] = !addFavorites[id]!;

      emit(ShopChangeFavoritesErrorState());
    });
  }

  FavoritesGetModel? favoritesGetModel;

  void getFavorites() {
    emit(ShopGetFavoritesLoadingState());

    DioHelper.getData(
      url: getFavorite,
      token: token,
    ).then((value) {
      favoritesGetModel = FavoritesGetModel.fromJson(value.data);

      emit(ShopGetFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavoritesErrorState());
    });
  }

  ShopLoginModel? profileData;

  void getProfileData() {
    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      profileData = ShopLoginModel.fromJson(value.data);
      emit(ShopGetProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetProfileErrorState());
    });
  }

  ShopLoginModel? editProfile;
  bool? isLoading;

  void updateUser({
    required String name,
    required String phone,
    required String email,
  }) {
    isLoading = true;
    emit(ShopEditProfileLoadingState());
    DioHelper.putData(url: updateProfile, token: token, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      print(value.data);

      editProfile = ShopLoginModel.fromJson(value.data);

      isLoading = false;
      if (editProfile?.status == false) {
        showText();
        Future.delayed(
          const Duration(seconds: 3),
        ).then((value) {
          hideText();
        });
      }
      emit(ShopEditProfileSuccessState(editProfile!));
    }).catchError((error) {
      print(error.toString());
    }).then((value) {
      getProfileData();
    });
  }

  SearchModel? searchData;

  void getSearchData({
    required String text,
  }) {
    emit(ShopCubitSearchProductLoadingState());
    DioHelper.postData(token: token, url: searchProduct, data: {
      'text': text,
    }).then((value) {
      searchData = SearchModel.fromJson(value.data);
      emit(ShopCubitSearchProductSuccessState());
      print(searchData.toString());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCubitSearchProductErrorState());
    });
  }

  late bool isVisible = true;

  void hideText() {
    isVisible = false;

    emit(ShopCubitHideTextErrorState());
  }

  void showText() {
    isVisible = true;

    emit(ShopCubitShowTextErrorState());
  }

  bool isDark = true;

  Widget switchMode() {
    return CupertinoSwitch(
      value: isDark,
      onChanged: (value) {
        changeMode();

        emit(ShopCubitIsModeState());
      },
      activeColor: defaultColor,
    );
  }

  void changeMode({bool? isMode}) {
    if (isMode != null) {
      isDark = isMode;
    } else {
      isDark = !isDark;
      CacheHelper.setData(key: darkKey, value: isDark).then((value) {
        emit(ShopCubitIsAppModeState());
      });
    }
  }

  dynamic dropValue = chooseLang;

  itemLang(context) {
    return [
      DropdownMenuItem(
        value: 'arabic',
        child: Text(language(context).arabic),
      ),
      DropdownMenuItem(
        value: 'english',
        child: Text(language(context).english),
      ),
    ].toList();
  }

  void onChangeDropDown(value, context) async {
    dropValue = value;

    if (value == 'arabic') {
      LanguageCubit.get(context).changeLang(context, 'ar');
    } else {
      LanguageCubit.get(context).changeLang(context, 'en');
    }
    CacheHelper.setData(key: chooseLangKey, value: value);

    defaultLangData = await CacheHelper.getData(key: defaultLangKey);
    getHomeData();
    getCategories();
    emit(ShopCubitDropDownValueState());
  }

  bool isReadMore = true;

  void defaultBackReadMore() {
    isReadMore = true;
    emit(ShopCubitDefaultReadMoreState());
  }

  void showDescription() {
    isReadMore = !isReadMore;
    emit(ShopCubitReadMoreDescriptionState());
  }

  void setSplash(context) async {
    await Future.delayed(const Duration(seconds: 3));
    emit(ShopCubitSetSplashLoadedState());
  }



}
