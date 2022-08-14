import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/packages/components/components.dart';
import 'package:shop_app/packages/constants/constants.dart';
import 'package:shop_app/packages/cubit/cubit.dart';
import 'package:shop_app/packages/cubit/state.dart';
import 'package:shop_app/packages/model/search_model.dart';
import '../../components/components_ui.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(appBar: AppBar(), body: buildShowItemSearch(context));
      },
    );
  }

  Widget buildShowItemSearch(context) {
    var cubit = ShopCubit.get(context);
    return BlocBuilder<ShopCubit, ShopCubitStates>(
      builder: (context, state) {
        if (state is ShopCubitSearchProductLoadingState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(language(context).searching,
                    style: Theme.of(context).textTheme.headline6),
                const SizedBox(
                  height: 10,
                ),
                defaultLinearIndicator(),
              ],
            ),
          );
        }
        if (cubit.searchData!.data.data.isEmpty) {
          return buildImageEmpty();
        }
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavoritesItem(
                cubit.searchData?.data.data[index], context,
                isOldPrice: false),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.searchData!.data.data.length);
      },
    );
  }
}
