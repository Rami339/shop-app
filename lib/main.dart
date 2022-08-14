import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/packages/constants/bloc_ob_server.dart';
import 'package:shop_app/packages/constants/constants.dart';
import 'package:shop_app/packages/constants/shared_pref_key.dart';
import 'package:shop_app/packages/cubit/cubit.dart';
import 'package:shop_app/packages/cubit/state.dart';
import 'package:shop_app/packages/helper/cache_helper.dart';
import 'package:shop_app/packages/helper/dio_helper.dart';
import 'package:shop_app/packages/lang/lang_cubit.dart';
import 'package:shop_app/packages/modules/login_screen/login_cubit/login_cubit.dart';
import 'package:shop_app/packages/modules/sign_up_screen/sign_up_cubit/sign_up_cubit.dart';
import 'package:shop_app/packages/modules/splash_screen/spalsh_screen.dart';
import 'package:shop_app/packages/style/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () async {
      await CacheHelper.init();
      await DioHelper.init();
      var isDark = await CacheHelper.getData(key: darkKey);
      token = await CacheHelper.getData(key: tokenKey);
      chooseLang = await CacheHelper.getData(key: chooseLangKey);
      defaultLangData = await CacheHelper.getData(key: defaultLangKey) ?? 'en';
      print(token);
      runApp(
        MyApp(
          isDark: isDark,
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  dynamic isDark;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopSignUpCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..changeMode(isMode: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => LanguageCubit(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, Locale?>(
        builder: (context, lang) {
          return BlocBuilder<ShopCubit, ShopCubitStates>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: lightMode,
                darkTheme: darkMode,
                themeMode: ShopCubit.get(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: const SplashScreen(),
                locale: lang,
              );
            },
          );
        },
      ),
    );
  }
}
