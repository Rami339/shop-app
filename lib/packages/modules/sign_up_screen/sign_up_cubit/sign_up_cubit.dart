import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/packages/modules/sign_up_screen/sign_up_cubit/sign_up_state.dart';

import '../../../constants/end_point.dart';
import '../../../helper/dio_helper.dart';
import '../../../model/login_model.dart';




class ShopSignUpCubit extends Cubit<ShopSignUpState> {
  ShopSignUpCubit() : super(ShopSignUpInitial());

  static ShopSignUpCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? shopSignUPModel;

  void signUpData({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopSignUpLoadingState());
    DioHelper.postData(url: signUp, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,

    }).then((value) {
      shopSignUPModel = ShopLoginModel.fromJson(value.data);

     print(shopSignUPModel!.message);
      emit(ShopSignUpSuccessState(shopSignUPModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopSignUpErrorState());
    });
  }
}
