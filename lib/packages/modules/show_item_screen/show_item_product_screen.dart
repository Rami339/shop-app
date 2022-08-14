import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/packages/components/components.dart';
import 'package:shop_app/packages/model/home_model.dart';
import '../../constants/constants.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../home_screen/home_screen.dart';

class SHowItemProduct extends StatelessWidget {
  final HomeProductsModel model;

  const SHowItemProduct({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopCubitStates>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            ShopCubit.get(context).defaultBackReadMore();
            return true;
          },
          child: Scaffold(
            body: buildShowImageProduct(context),
          ),
        );
      },
    );
  }

  Widget buildShowImageProduct(context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              height: 280,
              child: Stack(
                children: [
                  buildImageItem(),
                  buildShowFavoritesItemProduct(context),
                  buildShowTopIconProduct(context),
                ],
              ),
            ),
            buildShowDescription(context),
          ],
        ),
      ),
    );
  }

  Widget buildImageItem() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(defaultBorder),
      ),
      child: Hero(
        tag: model.id,
        child: Center(
          child: FadeInImage.assetNetwork(
            image: model.image,
            width: double.infinity,
            height: double.infinity,
            placeholder: 'images/loading.gif',
          ),
        ),
      ),
    );
  }

  Widget buildShowTopIconProduct(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[400],
            child: defaultIconButton(
                onPressed: () {
                  ShopCubit.get(context).defaultBackReadMore();
                  navigateAndRemove(context, const HomeScreen());
                },
                icon: Icons.arrow_back_outlined,
                color: secondColor),
          ),
          const Spacer(),
          CircleAvatar(
            backgroundColor: Colors.grey[400],
            child: IconButton(
              onPressed: () {
                ShopCubit.get(context).changeCart(model.id);
              },
              icon: ShopCubit
                  .get(context)
                  .addCart[model.id]!
                  ? const Icon(
                Icons.shopping_cart_sharp,
                color: defaultColor,
              )
                  : Icon(
                Icons.shopping_cart_outlined,
                color: ShopCubit
                    .get(context)
                    .addCart[model.id]!
                    ? Colors.transparent
                    : secondColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShowFavoritesItemProduct(context) {
    return Positioned(
      bottom: 11,
      right: 25,
      child: CircleAvatar(
        backgroundColor: Colors.grey[400],
        child: IconButton(
          onPressed: () {
            ShopCubit.get(context).changeFavorites(model.id);
          },
          icon: ShopCubit
              .get(context)
              .addFavorites[model.id]!
              ? const Icon(
            Icons.favorite,
            color: defaultColor,
          )
              : Icon(
            Icons.favorite_border_sharp,
            color: ShopCubit
                .get(context)
                .addFavorites[model.id]!
                ? Colors.transparent
                : secondColor,
          ),
        ),
      ),
    );
  }

  Widget buildShowDescription(context) {
    var cubit = ShopCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          model.name,
          style: Theme
              .of(context)
              .textTheme
              .headline6
              ?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          language(context).introduce,
          style: Theme
              .of(context)
              .textTheme
              .headline6,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorder),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.description,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontSize: 10, color: Colors.grey),
                    maxLines: cubit.isReadMore ? 3 : null,
                    overflow: cubit.isReadMore
                        ? TextOverflow.ellipsis
                        : TextOverflow.visible,
                  ),
                  Row(
                    children: [
                      defaultTextBottom(
                          pressed: () {
                            cubit.showDescription();
                          },
                          label: cubit.isReadMore ? language(context).showMore : language(context).showLess),
                      cubit.isReadMore
                          ? defaultIcon(Icons.expand_more_rounded, defaultColor)
                          : defaultIcon(Icons.expand_less, defaultColor),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
