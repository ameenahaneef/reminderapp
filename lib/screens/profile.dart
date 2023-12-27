// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body:  Container(
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 stops: [0.4, 0.9],
//                 colors: [
//                   Color.fromARGB(255, 116, 74, 129),
//                   Colors.black,
//                 ],
//               ),
//             ),
//             child: Column(children: [
//               Text('Profile'),
              
//             ],),
        
        
      
//        ) ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newproj/screens/medmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Box medicineHistoryBox;
  @override
  void initState() {
    super.initState();
    medicineHistoryBox=Hive.box<MedicineModel>('MedicineHistoryBox');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: const Color.fromARGB(255, 116, 74, 129),elevation: 0.0,),
      body:  Container(
          width: double.infinity,
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
          child: Column(children: [
            const Text('Medicine History',style: TextStyle(color: Colors.white,fontSize: 20),),
            Expanded(child: ListView.separated(itemCount: medicineHistoryBox.length,separatorBuilder: (context,index)=>Divider(thickness: 2,color: Colors.white,),
              itemBuilder: (context,index){
              MedicineModel medicine=medicineHistoryBox.getAt(index) as MedicineModel;
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('medicine name:${medicine.name}',style: TextStyle(color: Colors.white),),
                    Text('Dosage:${medicine.dosage}',style: TextStyle(color: Colors.white),),
                  
                  ],
                ),
                trailing: IconButton(onPressed: (){setState(() {
                  medicineHistoryBox.deleteAt(index);
                });}, icon: Icon(Icons.delete,color: Colors.white,)),
              
              );
            }))
            
          ],),
      
      
        
         ) );
  }
}