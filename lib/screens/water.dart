import 'package:flutter/material.dart';
import 'package:newproj/screens/navbar.dart';
import 'package:newproj/screens/style.dart';
import 'package:newproj/screens/watertrack.dart';

class WaterScreen extends StatelessWidget {
  const WaterScreen({super.key});

  Widget buildText(
    String text, {
    Color textColor = Colors.white,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
      ],
    );
  }




 Widget buildImageContainer(String imagePath, String body,String percentage) {
    return Container(width: 80,height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom:8.0,top: 4),
        child: Column(
          children: [
            Image(
              image: AssetImage(imagePath),
              width: 80,
              height: 48,
            ),
            Text(body,style: MyTextStyles.bodyTextStyle(13),),
            Text(
              percentage,
              style: MyTextStyles.bodyTextStyle(13),
            )
          ],
        ),
      ),
    );
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      drawer: const NavBar(),
      body: Container(
        width: double.infinity,
       height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.4, 0.7],
            colors: [
              Colors.black,
              Color.fromARGB(255, 94, 66, 103),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, ),
          child: Column(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildText('Helps Deliver\nOxygen all\nover the body'),
                        buildText('Keep mucosal\nmemebranes\nmoist'),
                        buildText(
                            'Allow bodys\nto grow,\nreproduce\nand survive'),
                        buildText('Flushes body\nwastes\nmainly in urine'),
                        buildText('Lubricates joints'),
                      ],
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Image(
                      image: AssetImage('assets/images/Man With Water (1).png'),
                      width: 130,
                      height: 350,
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText('Regulates\nbody\temperature'),
                      buildText(
                          'Acts as a\nshock absorer\nfor brain\nand spinalcord'),
                      buildText(
                          'converts\nfood to \ncomponents for\ndigestion'),
                      buildText('Forms saliva\ndigestion'),
                      buildText('Bringing nutri-\nents to cells'),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  buildText(
                      'Water is the major\ncomponent of most\nbody parts'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     buildImageContainer('assets/images/[removal.ai]_39505237-d1c4-4812-8fbb-29da30717555-hhup_edt6_220113.png','Kidney', '79%'),
                     buildImageContainer('assets/images/[removal.ai]_23c86a64-747b-4fb5-8a0c-37efa66e7e55-oq6c_oqju_160610.png','Liver', '73%'),
                     buildImageContainer('assets/images/[removal.ai]_df0c5e36-04ff-4d38-81c6-ed3f51e6d505-red-lungs-with-white-background-word-heart-it_1308-153031.png','Lungs', '83%'),
                     buildImageContainer('assets/images/[removal.ai]_de8b03ad-8237-4b3e-b4c8-3874019b4ae3-blood_08.png','Blood', '51%'),
              
                    ],
                  ),SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                                            buildImageContainer('assets/images/[removal.ai]_5bbca2bd-5f2e-4625-b77e-44fd3f5db9bb-9jp9_31fq_160622.png','Bones', '31%'),
                     buildImageContainer('assets/images/[removal.ai]_b3eede8f-9dbd-43b5-8214-cd03ff69c2e9-36el_uzef_160616.png','Brain', '73%'),
                     buildImageContainer('assets/images/[removal.ai]_eaeb350f-3c8b-4239-b46c-32c1b9e150ee-nmwy_e2e9_220113.png','Stomach', '40%'),
                     buildImageContainer('assets/images/[removal.ai]_f615a221-ce10-4f99-a081-bf00e6da5a03-human-internal-organ-with-intestine_1308-108352.png','Intestine', '50%'),
               
                    ],
                  ),
                 const SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return WaterTrack();
                    }));
                  }, style: ElevatedButton.styleFrom(backgroundColor: Colors.black,),
                  
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('Go Ahead'),
                        Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
