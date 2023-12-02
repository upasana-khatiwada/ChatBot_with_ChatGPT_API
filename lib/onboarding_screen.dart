import 'package:chatgpt_bot/home_page.dart';
import 'package:chatgpt_bot/intro_page1.dart';
import 'package:chatgpt_bot/intro_page2.dart';
import 'package:chatgpt_bot/intro_page3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //controller to keep track of which page we are on
  final PageController _controller = PageController();

  //keep track of if we are in the last page or not
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Creates a scrollable list that works page by page from an explicit [List] of widgets.

          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              // Container(
              //   color: Colors.blue,
              // ),
              // Container(
              //   color: Colors.yellow,
              // ),
              // Container(
              //   color: Colors.green,
              // ),

              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
              HomePage(),
            ],
          ),

          //dot indicators
          Container(
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //skip
                  GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(2);
                      },
                      child: const Text('skip')),
                  SmoothPageIndicator(controller: _controller, count: 3),

                  //next
                  onLastPage
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const HomePage();
                              },
                            ));
                          },
                          child: const Text('Done'))
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: const Text('next')),
                ],
              )),
        ],
      ),
    );
  }
}
