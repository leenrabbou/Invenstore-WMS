// ignore_for_file: file_names

import 'package:project_1_v2/Screens/OnBoarding/IntroScreens.dart';
import 'package:project_1_v2/Screens/SignInScreen.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});
  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final PageController _pageController = PageController();
  final _myBox = Hive.box('mainBox');
  void storeData() {
    _myBox.put('onBoard', true);
  }

  bool onLastPage = false;
  List<IntroScreens> introScreens = [
    IntroScreens(
      image: "images/picture1.png",
      title: S().easySecureAndOrganized,
      description:
          S().yourWarehouseOperationsMadeEasySecureAndPerfectlyOrganized,
    ),
    IntroScreens(
      image: "images/picture2.png",
      title: S().fullSupport,
      description: S().WeHereForYouWithOurSupportTeamAlwaysReadyToLendaHand,
    ),
    IntroScreens(
      image: "images/picture3.png",
      title: S().orderAnywhere,
      description: S().PlaceOrdersWithEaseWhereveYouAreWithJustAFewClicks,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      index == 2 ? onLastPage = true : onLastPage = false;
                    });
                  },
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return introScreens[index];
                  },
                  itemCount: introScreens.length,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: SmoothPageIndicator(
                          effect: const ExpandingDotsEffect(
                            activeDotColor: Color.fromARGB(255, 104, 168, 221),
                          ),
                          controller: _pageController,
                          count: 3,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    !onLastPage
                        ? Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _pageController.jumpToPage(2);
                                  },
                                  child: Text(
                                    S().skip,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      104,
                                      168,
                                      221,
                                    ),
                                    fixedSize: Size(
                                      40,
                                      MediaQuery.of(context).size.height * 0.06,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              storeData();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              backgroundColor: const Color.fromARGB(
                                255,
                                104,
                                168,
                                221,
                              ),
                              fixedSize: Size(
                                350,
                                MediaQuery.of(context).size.height * 0.06,
                              ),
                            ),
                            child: Text(
                              S().getStarted,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
