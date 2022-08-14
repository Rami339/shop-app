import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/shared_pref_key.dart';
import '../helper/cache_helper.dart';

class LanguageCubit extends Cubit<Locale?> {
  LanguageCubit() : super(null);

static LanguageCubit get(context)=>BlocProvider.of(context);
   changeStartLang() async {
    var langCode = await CacheHelper.getData(key: defaultLangKey);
    print(langCode);
    if (langCode != null) {
      emit(Locale(langCode, ''));
    } else {
      emit(const Locale('en', ''));
    }
  }

  void changeLang(context, String data) async {
    emit(Locale(data, ''));
    await CacheHelper.setData(key: defaultLangKey, value: data);
  }

}
