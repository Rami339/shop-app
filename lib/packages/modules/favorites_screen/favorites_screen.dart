import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../components/components_ui.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../model/favorites_get_model.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: buildListItem(
            cubit.favoritesGetModel?.data,
            context,
          ),
        );
      },
    );
  }

  Widget buildListItem(FavoritesGet? favoritesGet, context) {
    var cubit = ShopCubit.get(context);
    if (favoritesGet == null) {
      return defaultCircleIndicator();
    } else if (cubit.favoritesGetModel!.data!.data.isEmpty) {
      return  buildImageEmpty();
    }
    return BlocBuilder<ShopCubit, ShopCubitStates>(
      builder: (context, state) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildFavoritesItem(favoritesGet.data[index].data, context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: favoritesGet.data.length,
      ),
    );
  }



}
