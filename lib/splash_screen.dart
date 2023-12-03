import 'package:chatgpt_bot/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      
      Get.to(()=> const OnBoardingScreen());
    });
  }
  //to start or execute
  @override
  void initState() {
    changeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ,
      body: Center(
        child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 100,
                  child: Image.asset(
                    "assets/images/robo.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Text("Version 1.0.0",style: TextStyle(color: Colors.black),),
              
              const Spacer(),
             
              const Text(
                'made by : U&S',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'sans_semibold'),
              ),
              const SizedBox(height: 30,)
            ]),
      ),
    );
  }
}