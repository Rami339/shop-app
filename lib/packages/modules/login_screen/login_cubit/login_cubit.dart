import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/packages/cubit/cubit.dart';
import 'package:shop_app/packages/helper/cache_helper.dart';
import '../../../constants/constants.dart';
import '../../../constants/end_point.dart';
import '../../../constants/shared_pref_key.dart';
import '../../../helper/dio_helper.dart';
import '../../../lang/lang_cubit.dart';
import '../../../model/login_model.dart';
import 'login_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitial());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? shopLoginModel;

  void loginData({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(url: login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);

      print(shopLoginModel!.message);
      emit(ShopLoginSuccessState(shopLoginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState());
    });
  }

  bool isHidden = true;

  hiddenPassword() {
    isHidden = !isHidden;
    emit(ShopLoginIsHiddenPassword());
  }

  getToken(context) async {
    token = await CacheHelper.getData(key: tokenKey);
    ShopCubit.get(context).getHomeData();
    ShopCubit.get(context).getFavorites();
    emit(ShopLoginGetToken());
  }
}
