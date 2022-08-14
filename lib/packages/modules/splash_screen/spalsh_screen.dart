import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/packages/components/components.dart';
import 'package:shop_app/packages/cubit/state.dart';
import '../../constants/constants.dart';
import '../../constants/shared_pref_key.dart';
import '../../cubit/cubit.dart';
import '../../helper/cache_helper.dart';
import '../home_screen/home_screen.dart';
import '../login_screen/login_screen.dart';
import '../on_boarding_screen/on_board.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    ShopCubit.get(context).setSplash(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopCubitStates>(
        listener: (context, state) async {
      if (state is ShopCubitSetSplashLoadedState) {
        if (await CacheHelper.getData(key: boardKey) != null) {
          navigateAndRemove(context, LoginScreen());
          if (token != null) {
            navigateAndRemove(context, const HomeScreen());
          } else {
            navigateAndRemove(context, LoginScreen());
          }
        } else {
          navigateAndRemove(context, const OnBoardingScreen());
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: secondColor,
        body: Center(
          child: Image.asset(
            'images/splash.gif',
            width: 300,
            height: 300,
          ),
        ),
      );
    });
  }
}
