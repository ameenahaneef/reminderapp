import 'package:flutter/material.dart';
import 'package:newproj/screens/dailydose.dart';
import 'package:newproj/screens/mainhome.dart';
import 'package:newproj/screens/navbar.dart';

class Medicine extends StatelessWidget {
  const Medicine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(backgroundColor:  const Color.fromARGB(255, 116, 74, 129),elevation: 0.0,
      //  leading: IconButton(onPressed: (){
      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainHome()), (route) => false);
      // }, icon: const Icon(Icons.arrow_back)),
      ),
      drawer: const NavBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.4, 0.9],
            colors: [
              Color.fromARGB(255, 116, 74, 129),
              Colors.black,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 30,),
              const Text('Add your medicine to get a notification',style: TextStyle(color: Colors.white,fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),),
              const SizedBox(height: 40,),
              ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)),
              backgroundColor: Colors.transparent,
              padding:const EdgeInsets.only(
              top: 15, bottom: 10, left: 30, right: 30)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return DailyDose();
              }));
              
            },
            child:const Text('Add',style: TextStyle(color: Colors.amber,fontSize: 20,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic),)),
            SizedBox(height: 60,),
              const Image(image: AssetImage('assets/images/[removal.ai]_5a311f65-f830-493f-9085-8c10e9a94563-fun-3d-illustration-cartoon-teenage-girl_183364-80047.png'))
            ],
          ),
        ),
      ),
      
    );
  }
}
