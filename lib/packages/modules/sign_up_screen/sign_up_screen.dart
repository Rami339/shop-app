import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/packages/modules/sign_up_screen/sign_up_cubit/sign_up_cubit.dart';
import 'package:shop_app/packages/modules/sign_up_screen/sign_up_cubit/sign_up_state.dart';
import '../../components/components.dart';
import '../../constants/constants.dart';
import '../login_screen/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopSignUpCubit, ShopSignUpState>(
      listener: (context, state) {
        if (state is ShopSignUpSuccessState) {
          if (state.shopSignUPModel.status) {
            navigateAndRemove(context, LoginScreen());
          } else {
            defaultSnackBar(
                text: state.shopSignUPModel.message,
                state: SnackBarState.error,
                context: context);
          }
        }
      },
    child: Scaffold(body: buildSinUpScreen(context)),
    );
  }

  Widget buildSinUpScreen(context) {
    return BlocBuilder<ShopSignUpCubit, ShopSignUpState>(
        builder: (context, state) {
      return SafeArea(
        child: SingleChildScrollView(
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
                    'images/sign_up.svg',
                    height: 90,
                  )),
                  Text(
                    language(context).signUp,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.w500, color: defaultColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultTextField(
                    controller: nameController,
                    label: language(context).name,
                    priFix: Icons.person,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return language(context).enterName;
                      }
                      return null;
                    },
                    keyBoard: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
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
                  defaultTextField(
                    controller: phoneController,
                    label: language(context).phone,
                    priFix: Icons.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return language(context).enterPhone;
                      }
                      return null;
                    },
                    keyBoard: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state is! ShopSignUpLoadingState
                      ? defaultButton(
                          pressed: () {
                            if (formKey.currentState!.validate()) {
                              ShopSignUpCubit.get(context).signUpData(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: language(context).signUp)
                      : Center(
                          child: defaultCircleIndicator(),
                        ),
                  Row(
                    children: [
                      Text(
                        language(context).haveAccount,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      defaultTextBottom(
                        pressed: () {
                          navigateAndRemove(context, LoginScreen());
                        },
                        label: language(context).login,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
