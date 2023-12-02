import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     // backgroundColor: Colors.pink,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 10),
                child: Image.asset("assets/images/robo2.jpg"),
              ),
              const Padding(
                padding: EdgeInsets.all(28.0),
                child: Text(
                  "To use ChatGPT, you can simply ask it a question or give it a prompt and it will generate a response. For example ask it a question like \"What is the capital of Nepal ?\" or give it a prompt like \"Write a poem on Flutter\".",
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