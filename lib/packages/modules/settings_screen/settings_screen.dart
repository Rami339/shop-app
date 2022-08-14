import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/packages/components/components_ui.dart';
import 'package:shop_app/packages/constants/shared_pref_key.dart';
import 'package:shop_app/packages/helper/cache_helper.dart';
import 'package:shop_app/packages/lang/lang_cubit.dart';
import '../../components/components.dart';
import '../../constants/constants.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../model/login_model.dart';
import '../login_screen/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopCubitStates>(
      listener: (context, state) {
        if (state is ShopEditProfileSuccessState) {
          if (state.shopLoginModel!.status) {
            Navigator.pop(context);
            defaultSnackBar(
                text: state.shopLoginModel?.message,
                state: SnackBarState.success,
                context: context);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              language(context).settings,
              style:
                  Theme.of(context).textTheme.headline6?.copyWith(fontSize: 20),
            ),
          ),
          body: buildGetProfileData(cubit.profileData?.data, context),
        );
      },
    );
  }

  Widget buildGetProfileData(ShopLoginData? model, BuildContext context) {
    return BlocBuilder<ShopCubit, ShopCubitStates>(
      builder: (context, state) {
        if (model == null) {
          return defaultCircleIndicator();
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildProfileSettings(model, context),
                buildSpaceSetting(),
                buildBottomDarkMode(context),
                buildSpaceSetting(),
                buildSelectedLanguage(context),
                buildSpaceSetting(),
                buildLogOut(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildLogOut(context) {
    return BlocBuilder<ShopCubit, ShopCubitStates>(builder: (context, state) {
      return InkWell(
        onTap: () async{
CacheHelper.deleteData(key: tokenKey);
          navigateAndRemove(context, LoginScreen());
        },
        child: Row(
          children: [
            buildCircleIcon(icon: Icons.logout),
            const SizedBox(
              width: 10,
            ),
            Text(
              language(context).logout,
              style:
                  Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15),
            ),
          ],
        ),
      );
    });
  }

  Widget buildProfileSettings(ShopLoginData? model, context) {
    return Row(
      children: [
        CircleAvatar(
          maxRadius: 40,
          minRadius: 40,
          backgroundImage: NetworkImage(model!.image),
        ),
        const SizedBox(
          width: 25,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.name,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.normal, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              model.email,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 8.5,
              ),
            )
          ],
        ),
        const Spacer(),
        defaultIconButton(
            onPressed: () {
              dialog(context);
            },
            icon: Icons.edit,
            color: defaultColor)
      ],
    );
  }

  Widget buildSelectedLanguage(context) {
    var cubit = ShopCubit.get(context);

    return BlocConsumer<ShopCubit, ShopCubitStates>(
      listener: (context, state) {},
      builder: (
        context,
        state,
      ) {
        return Row(
          children: [
            buildCircleIcon(icon: Icons.translate),
            const SizedBox(
              width: 10,
            ),
            Text(
              language(context).language,
              style:
                  Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorder),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2.5),
              ),
              child: DropdownButton(
                underline: const Divider(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(defaultBorder),
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                items: cubit.itemLang(context),
                onChanged: (value) async {
                  cubit.onChangeDropDown(value, context);
                },
                value: cubit.dropValue ?? 'english',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildBottomDarkMode(context) {
    var cubit = ShopCubit.get(context);
    return Row(
      children: [
        buildCircleIcon(icon: Icons.dark_mode),
        const SizedBox(
          width: 10,
        ),
        Text(
          language(context).darkMode,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                fontSize: 15,
              ),
        ),
        const Spacer(),
        cubit.switchMode()
      ],
    );
  }

  Future<void> dialog(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Container(
        color: Colors.transparent,
        child: BlocConsumer<ShopCubit, ShopCubitStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return buildAlertDialog(context);
          },
        ),
      ),
    );
  }

  Widget buildAlertDialog(context) {
    var cubit = ShopCubit.get(context);
    var profile = ShopCubit.get(context).profileData;
    final formKey = GlobalKey<FormState>();
    final editNameController = TextEditingController();
    final editPhoneController = TextEditingController();
    final editEmailController = TextEditingController();
    editNameController.text = profile!.data!.name;
    editEmailController.text = profile.data!.email;
    editPhoneController.text = profile.data!.phone;
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      insetPadding: EdgeInsets.zero,
      title: Text(
        language(context).editProfile,
        style: const TextStyle(color: defaultColor),
      ),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              if (cubit.isLoading == true)
                Center(
                  child: Column(
                    children: [
                      defaultLinearIndicator(),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              if (cubit.editProfile?.status == false)
                Visibility(
                  visible: cubit.isVisible,
                  child: Text(
                    cubit.editProfile?.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              defaultTextField(
                  controller: editNameController,
                  label: language(context).name,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return language(context).enterName;
                    }
                    return null;
                  },
                  keyBoard: TextInputType.text),
              const SizedBox(
                height: 8,
              ),
              defaultTextField(
                  controller: editEmailController,
                  label: language(context).email,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return language(context).enterEmail;
                    }
                    return null;
                  },
                  keyBoard: TextInputType.text),
              const SizedBox(
                height: 8,
              ),
              defaultTextField(
                  controller: editPhoneController,
                  label: language(context).phone,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return language(context).enterPhone;
                    }
                    return null;
                  },
                  keyBoard: TextInputType.text),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            defaultTextBottom(
                pressed: () {
                  Navigator.pop(context);
                },
                label: language(context).cancel),
            defaultTextBottom(
                pressed: () {
                  if (formKey.currentState!.validate()) {
                    cubit.updateUser(
                        name: editNameController.text,
                        phone: editPhoneController.text,
                        email: editEmailController.text);
                  }
                },
                label: language(context).save),
          ],
        ),
      ],
    );
  }
}
