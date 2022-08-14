import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/packages/modules/login_screen/login_cubit/login_state.dart';
import '../constants/constants.dart';
import '../modules/login_screen/login_cubit/login_cubit.dart';

void navigateTo(context, widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

void navigateAndRemove(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}

Widget defaultTextField({
  required TextEditingController controller,
  required String label,
  IconData? priFix,
  String? Function(String?)? validate,
  TextInputType? keyBoard,
  Widget? suffixIcon,
  Function(String)? onChange,
  Function()? suffixPress,
  TextInputAction? textAction,
  Function(String?)? onSubmitted,
  bool isPassword = false,
}) =>
    BlocBuilder<ShopLoginCubit, ShopLoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: isPassword,
        onFieldSubmitted: onSubmitted,
        textInputAction: textAction,
        cursorColor: defaultColor,
        controller: controller,
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(color: defaultColor),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: defaultColor,
              width: 2,
            ),
          ),
          label: Text(label),
          suffixIcon: suffixIcon,
          prefixIcon: Icon(
            priFix,
          ),
          border: const OutlineInputBorder(),
        ),
        validator: validate,
        onChanged: onChange,
        keyboardType: keyBoard,
      );
    });

Widget defaultButton({
  required Function() pressed,
  required String text,
  double height = 40,
  double minWidth = 150,
  bool isUpperCase = true,
}) =>
    MaterialButton(
      height: height,
      minWidth: minWidth,
      onPressed: pressed,
      color: defaultColor,
      child: Text(isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
    );

Widget defaultIcon(
  IconData? icon,
  Color? color,
) {
  return Icon(
    icon,
    color: color,
  );
}

Widget defaultTextBottom({
  required Function() pressed,
  required String label,
  Color? color,
  TextAlign? align,
}) {
  return TextButton(
    onPressed: pressed,
    child: Text(
      label,
      style: TextStyle(
        color: color,
      ),
      textAlign: align,
    ),
  );
}

Widget defaultIconButton({
  required Function()? onPressed,
  required IconData icon,
  Color? color,
}) {
  return IconButton(
    onPressed: onPressed,
    icon: Icon(
      icon,
      color: color,
    ),
  );
}

Widget defaultLinearIndicator() {
  return const LinearProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
    backgroundColor: defaultColor,
  );
}

Widget defaultCircleIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.grey,
      color: defaultColor,
    ),
  );
}

Widget myDivider() {
  return const Divider(
    endIndent: 20,
    indent: 20,
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> defaultSnackBar({
  required String text,
  required SnackBarState state,
  required context,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(milliseconds: 1000),
      backgroundColor: choseColor(state),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(70),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      elevation: 5,
    ),
  );
}

enum SnackBarState { success, error }

Color choseColor(SnackBarState state) {
  Color color;
  switch (state) {
    case SnackBarState.success:
      color = Colors.green;
      break;
    case SnackBarState.error:
      color = Colors.red;
      break;
  }
  return color;
}

Widget buildImageEmpty() {
  return Center(
      child: SvgPicture.asset(
    'images/empty.svg',
    height: 150,
    width: 150,
  ));
}
