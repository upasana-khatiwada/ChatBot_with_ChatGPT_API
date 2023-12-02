import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 116, 211, 239),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 10),
                child: Image.asset("assets/images/robo.jpg"),
              ),
              const Padding(
                padding: EdgeInsets.all(28.0),
                child: Text(
                  "Hello, I am ChatGPT,a large language modeltrained by OpenAI. I can answer questions, generate text, and assist with various tasks . I am a work in progress , so please be patient with me",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
