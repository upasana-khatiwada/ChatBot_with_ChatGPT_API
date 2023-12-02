import 'package:chatgpt_bot/home_page.dart';
import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 10),
                child: Image.asset("assets/images/robo3.png"),
              ),
              const Padding(
                padding: EdgeInsets.all(28.0),
                child: Text(
                  "Let's get started.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}