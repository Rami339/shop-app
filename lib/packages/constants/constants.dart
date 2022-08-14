import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shop_app/packages/constants/shared_pref_key.dart';
import '../helper/cache_helper.dart';

const defaultColor = Color(0xff417D7A);
const secondColor = Color(0xffEEEEEE);
double defaultBorder = 8.0;
var token = CacheHelper.getData(key: tokenKey);
var dark = CacheHelper.getData(key: darkKey);
var chooseLang = CacheHelper.getData(key: chooseLangKey);
var defaultLangData = CacheHelper.getData(key: defaultLangKey);
AppLocalizations language(BuildContext context) {
  return AppLocalizations.of(context)!;
}
