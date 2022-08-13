import 'package:apartment_complex/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset('assets/images/luxury.jpeg',fit: BoxFit.cover,height: MediaQuery.of(context).size.height),
       Container(
         margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/4 ),
         child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 45.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'lobster',
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText('Luxury Apartments'),

              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
       ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 40,
              width:MediaQuery.of(context).size.width/1.2 ,
              margin: const EdgeInsets.only(bottom:30),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>HomeScreen()));
                },
                child: const Text("Get Started",style: TextStyle(color: Colors.black,
                  fontFamily: 'lobster',
                  fontSize: 20,),),
              ),
            ),
          )

        ],
      ),
    );
  }
}
