import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/packages/constants/constants.dart';

import '../../components/components.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../model/categories_model.dart';



class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return cubit.categoriesModel != null
            ? Scaffold(
                appBar: AppBar(),
                body: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildCategoryItem(
                        cubit.categoriesModel!.data!.data![index], context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: cubit.categoriesModel!.data!.data!.length),
              )
            : Center(
                child: defaultCircleIndicator(),
              );
      },
    );
  }

  Widget buildCategoryItem(CategoriesData model, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(defaultBorder),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorder),
                color: Colors.white,
              ),
              child: CachedNetworkImage(
                imageUrl: model.image,
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                model.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
