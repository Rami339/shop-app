import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/packages/modules/search_screen/search_screen.dart';
import '../../components/components.dart';
import '../../constants/constants.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../lang/lang_cubit.dart';
import '../../model/categories_model.dart';
import '../../model/home_model.dart';
import '../categories_screen/categories_screen.dart';

import '../show_item_screen/show_item_product_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LanguageCubit>().changeStartLang();
    return BlocConsumer<ShopCubit, ShopCubitStates>(
      listener: (context, state) {
        if (state is ShopCubitSearchProductLoadingState) {
          navigateTo(context, const SearchScreen());
        }

        if (state is ShopChangeFavoritesSuccessState) {
          if (state.favoritesModel.status) {
            defaultSnackBar(
                text: state.favoritesModel.message,
                state: SnackBarState.success,
                context: context);
          }
        }
        if (state is ShopChangeCartSuccessState) {
          if (state.getCartModel.status) {
            defaultSnackBar(
                text: state.getCartModel.message,
                state: SnackBarState.success,
                context: context);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
            body: cubit.homeModel != null && cubit.categoriesModel != null
                ? productBuilder(
                    cubit.homeModel!,
                    cubit.categoriesModel!,
                    context,
                  )
                : defaultCircleIndicator());
      },
    );
  }

  Widget buildPopUpMenu(context) {
    return BlocConsumer<ShopCubit, ShopCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return PopupMenuButton(
          icon: const Icon(
            Icons.more_vert,
            color: Colors.grey,
          ),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: 1,
              child: Text(language(context).settings),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(language(context).favorites),
            ),
            PopupMenuItem(
              value: 3,
              child: Text(language(context).categories),
            ),
          ],
          onSelected: (int menu) {
            ShopCubit.get(context).menuSelected(menu, context);
          },
        );
      },
    );
  }

  Widget buildSearchProduct(context) {
    final searchController = TextEditingController();
    final searchKey = GlobalKey<FormState>();
    return Form(
      key: searchKey,
      child: defaultTextField(
          controller: searchController,
          label: language(context).search,
          textAction: TextInputAction.search,
          validate: (value) {
            if (value!.isEmpty) {
              return language(context).enterText;
            }
            return null;
          },
          onSubmitted: (value) {
            if (searchKey.currentState!.validate()) {
              ShopCubit.get(context).getSearchData(text: searchController.text);
            }
          }),
    );
  }

  Widget productBuilder(
      HomeModel model, CategoriesModel categoriesModel, context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          title: Text(
            language(context).home,
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: [
            buildPopUpMenu(context),
          ],
          bottom: AppBar(
            title: buildSearchProduct(context),
            toolbarHeight: 100,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildBannerProduct(model),
                  const SizedBox(
                    height: 15,
                  ),
                  buildCategories(context, categoriesModel),
                  buildItemProduct(context, model)
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildBannerProduct(HomeModel model) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CarouselSlider(
          items: model.data!.banners!
              .map(
                (e) => CachedNetworkImage(
                  imageUrl: e.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 190.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }

  Widget buildCategories(context, CategoriesModel categoriesModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                language(context).categories,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              defaultTextBottom(
                  pressed: () {
                    navigateTo(context, const CategoriesScreen());
                  },
                  label: language(context).seeAll,
                  color: Colors.grey)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 100,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCategoryItem(
                  categoriesModel.data!.data![index], context),
              separatorBuilder: (context, index) => const SizedBox(
                width: 5,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            language(context).newProduct,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }

  Widget buildItemProduct(context, HomeModel model) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          const SizedBox(
            height: 10,
          ),
          GridView.count(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(3),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            shrinkWrap: true,
            childAspectRatio: 1 / 1.77,
            children: List.generate(
              model.data!.products!.length,
              (index) =>
                  buildGridProduct(model.data!.products![index], context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(CategoriesData model, context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(defaultBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CachedNetworkImage(
              imageUrl: model.image,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(defaultBorder),
            ),
          ),
          child: SizedBox(
            width: 110,
            height: 20,
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGridProduct(HomeProductsModel model, context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(defaultBorder))
              // BorderRadius.circular(8)
              ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              GestureDetector(
                onTap: () {
                  navigateTo(
                      context,
                      SHowItemProduct(
                        model: model,
                      ));
                },
                child: Hero(
                  tag: model.id,
                  child: CachedNetworkImage(
                    imageUrl: model.image,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
              ),
              if (model.disCount != 0)
                Container(
                  color: Colors.red,
                  child: Text(
                    language(context).discount,
                    style: const TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Expanded(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(defaultBorder)),
                color: Theme.of(context).primaryColor),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Column(
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 10,
                        ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.price.round()}',
                            style: const TextStyle(color: defaultColor),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          if (model.disCount != 0)
                            Text(
                              '${model.oldPrice.round()}',
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                        child: Row(
                          children: [
                            const Spacer(),
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
                                      color: ShopCubit.get(context)
                                              .addCart[model.id]!
                                          ? Colors.transparent
                                          : Colors.grey,
                                    ),
                            ),
                            IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavorites(model.id);
                              },
                              icon:
                                  ShopCubit.get(context).addFavorites[model.id]!
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
                          ],
                        ),
                      )
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
