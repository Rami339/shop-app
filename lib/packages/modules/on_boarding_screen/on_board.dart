import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../components/components.dart';
import '../../constants/constants.dart';
import '../../constants/shared_pref_key.dart';
import '../../helper/cache_helper.dart';

import '../login_screen/login_screen.dart';

class BoardingModel {
  String? image;
  String? body;
  String? title;

  BoardingModel({
    required this.image,
    required this.body,
    required this.title,
  });
}

List<BoardingModel> boarding = [
  BoardingModel(
    image: 'images/shop_1.svg',
    body: 'screen 1',
    title: 'body 1',
  ),
  BoardingModel(
    image: 'images/shop_2.svg',
    body: 'screen 2',
    title: 'body 2',
  ),
  BoardingModel(
    image: 'images/shop_3.svg',
    body: 'screen 3',
    title: 'body 3',
  ),
];

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  bool isLast = false;

  void submit() {
    CacheHelper.setData(
      key: boardKey,
      value: true,
    ).then((value) {
      if (value) {
        navigateAndRemove(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        actions: [defaultTextBottom(pressed: submit, label: 'Skip')],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor,
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: SvgPicture.asset(
          '${model.image}',
          height: 200,
        )),
        const SizedBox(
          height: 20,
        ),
        Text(
          '${model.title}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          '${model.body}',
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
