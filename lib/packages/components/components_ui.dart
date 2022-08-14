import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/packages/cubit/state.dart';
import '../constants/constants.dart';
import '../cubit/cubit.dart';
import 'components.dart';

Widget buildFavoritesItem(model, context, {bool isOldPrice = true}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(defaultBorder),
      ),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(defaultBorder),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: model.image,
                    width: 135,
                    height: 110,
                  ),
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                      color: Colors.red,
                      child: Text(
                        language(context).discount,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      )),
              ],
            ),
            const SizedBox(width: 5.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.normal, fontSize: 10),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: const TextStyle(color: defaultColor),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: ShopCubit.get(context).addFavorites[model.id]!
                            ? const Icon(
                                Icons.favorite,
                                color: defaultColor,
                              )
                            : Icon(
                                Icons.favorite_border_sharp,
                                color: ShopCubit.get(context)
                                        .addFavorites[model.id]!
                                    ? Colors.transparent
                                    : Colors.grey,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeCart(model.id);
                        },
                        icon: ShopCubit.get(context).addCart[model.id]!
                            ? const Icon(
                                Icons.shopping_cart_sharp,
                                color: defaultColor,
                              )
                            : Icon(
                                Icons.shopping_cart_outlined,
                                color: ShopCubit.get(context).addCart[model.id]!
                                    ? Colors.transparent
                                    : Colors.grey,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
Widget buildSpaceSetting() {
  return Column(
    children: [
      const SizedBox(
        height: 7.5,
      ),
      myDivider(),
      const SizedBox(
        height: 7.5,
      ),
    ],
  );
}
Widget buildCircleIcon({
  required IconData icon,
}) {
  return BlocBuilder<ShopCubit, ShopCubitStates>(builder: (context, state) {
    return ShopCubit.get(context).isDark
        ? CircleAvatar(
            backgroundColor: Colors.grey[700],
            child: Icon(
              icon,
              color: Colors.white,
            ),
          )
        : CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          );
  });
}
