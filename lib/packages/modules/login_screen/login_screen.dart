import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../components/components.dart';
import '../../constants/constants.dart';
import '../../constants/shared_pref_key.dart';
import '../../cubit/cubit.dart';
import '../../helper/cache_helper.dart';
import '../../lang/lang_cubit.dart';
import '../home_screen/home_screen.dart';
import '../sign_up_screen/sign_up_screen.dart';
import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    context.read<LanguageCubit>().changeStartLang();
    return BlocListener<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.shopLoginModel.status) {
              CacheHelper.setData(
                      key: tokenKey, value: state.shopLoginModel.data?.token)
                  .then((value) {
                defaultSnackBar(
                  text: state.shopLoginModel.message,
                  state: SnackBarState.success,
                  context: context,
                );
              });
              navigateAndRemove(context, const HomeScreen());
              state == ShopLoginCubit.get(context).getToken(context);
            } else {
              defaultSnackBar(
                text: state.shopLoginModel.message,
                state: SnackBarState.error,
                context: context,
              );
            }
          }
        },
        child: Scaffold(body: buildLoginScreen(context)));
  }

  Widget buildLoginScreen(context) {
    return BlocBuilder<ShopLoginCubit, ShopLoginState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                      child: SvgPicture.asset(
                    'images/login.svg',
                    height: 100,
                  )),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    language(context).login,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.w500, color: defaultColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultTextField(
                    controller: emailController,
                    label: language(context).email,
                    priFix: Icons.email_outlined,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return language(context).enterEmail;
                      }
                      return null;
                    },
                    keyBoard: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextField(
                  isPassword: ShopLoginCubit.get(context).isHidden,
                    suffixIcon: defaultIconButton(
                      onPressed: () {
                        ShopLoginCubit.get(context).hiddenPassword();
                      },
                      icon: ShopLoginCubit.get(context).isHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    controller: passwordController,
                    label: language(context).password,
                    priFix: Icons.lock_outline,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return language(context).enterPassword;
                      }
                      return null;
                    },
                    keyBoard: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state is! ShopLoginLoadingState
                      ? defaultButton(
                          pressed: () {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).loginData(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: language(context).login,
                        )
                      : Center(child: defaultCircleIndicator()),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        language(context).donNotHaveAccount,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      defaultTextBottom(
                        pressed: () {
                          navigateAndRemove(context, SignUpScreen());
                        },
                        label: language(context).signUp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
