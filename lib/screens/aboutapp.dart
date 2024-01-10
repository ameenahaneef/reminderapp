import 'package:flutter/material.dart';
import 'package:newproj/screens/style.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});
  

  @override
  Widget build(BuildContext context) {
    String about='''

  Our Mission

 At Well Alert, our mission is to empower individuals to take control of their health and well-being through smart and personalized reminders. We believe that a healthier lifestyle is within everyone's reach with the right guidance and support.

  Who We Are

 Well Alert is the brainchild of a passionate team dedicated to improving the health and well-being of people around the world. Our diverse team of developers, designers, and health enthusiasts came together with a shared vision of creating a user-friendly app that seamlessly integrates into your daily routine.

  What We Offer

 1. **Medicine Reminder**

 Never miss a dose again! Well Alert ensures that you stay on top of your medication schedule, providing timely reminders and keeping you on the path to better health.

 2. **Healthy Diet Guidance**

 Eating well is a key component of a healthy lifestyle. Well Alert provides personalized diet recommendations, helping you make informed choices that contribute to your overall well-being.

 3. **Hydration Tracker**

 Staying hydrated is vital for good health. Well Alert's water reminder feature helps you maintain optimal hydration levels, supporting your body's various functions.

  Our Approach

 Well Alert is more than just an app; it's a companion on your journey to a healthier you. We understand that everyone's health needs are unique, so our app is designed to adapt and cater to individual preferences and requirements.


 Thank you for choosing Well Alert on your journey to a healthier and happier life!


''';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('About Us'),
      ),
      body: Container(
        decoration: const BoxDecoration(
         color: Colors.black
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(about,style: MyTextStyles.bodyTextStyle(15),),
          ),
        ),
        ),
        
      ); 
  }
}