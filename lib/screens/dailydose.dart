// import 'package:flutter/material.dart';
// import 'package:newproj/screens/addmed.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:newproj/screens/med.dart';
// import 'package:newproj/screens/meddetailsscreen.dart';
// import 'package:newproj/screens/medmodel.dart';

// class DailyDose extends StatefulWidget {
//   const DailyDose({super.key});

//   @override
//   State<DailyDose> createState() => _DailyDoseState();
// }

// class _DailyDoseState extends State<DailyDose> {
//   late Box medicineBox;
// @override
//   void initState() {
//     super.initState();
//     medicineBox=Hive.box<MedicineModel>('MedicineModelBox');
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     medicineBox=Hive.box<MedicineModel>('MedicineModelBox');
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Color.fromARGB(255, 124, 48, 157),elevation: 0.0,leading: IconButton(onPressed: (){
//         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Medicine()), (route) => false);
//       }, icon: Icon(Icons.arrow_back)),),
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             stops: [0.4, 0.9],
//             colors: [
//               Colors.white,
//               Color.fromARGB(255, 116, 74, 129),
//             ],
//           ),
//         ),
//         child:  Column(
//           children: [
//             Text('Welcome to Daily Doses',style: TextStyle(color: Colors.black,fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),),
//             SizedBox(height: 10,),
//             _buildMedicineList(),
//             Text('No Medicines',style: TextStyle(color: Colors.white),),
//           ],
          
//         ),
        
//       ),
      
//     floatingActionButton: FloatingActionButton(onPressed: (){
//       Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
//         return AddMed();
//       }));
//     },child: Text('+',style: TextStyle(fontSize: 20),),backgroundColor: Colors.black,foregroundColor: Colors.white,),
//     );
//   }
//   Widget _buildMedicineList() {
//   if (medicineBox.isOpen) {
//     final medicines = medicineBox.values.toList();
//     if (medicines.isNotEmpty) {
//       return Expanded(
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3, // Set the number of items in each row
//             crossAxisSpacing: 8.0,
//             mainAxisSpacing: 8.0,
//             childAspectRatio: 1.5,
//           ),
//           itemCount: medicines.length,
//           itemBuilder: (context, index) {
//             final medicine = medicines[index];
//             return InkWell(
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(builder: (context){
//                   return MedicineDetailsScreen(medicine: medicine);
//                 }));
//                 // Handle tapping on a medicine item if needed
//               },
//               child: Card(
//                 color: Color.fromARGB(132, 0, 0, 0),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Name: ${medicine.name}',
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       Text(
//                         'Dose: ${medicine.dosage}',
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     } else {
//       return Center(
//         child:  Text(
//           'No Medicines',
//           style: TextStyle(color: Colors.black),
//         ),
//       );
//     }
//   } else {
//     // Hive box is not open yet
//     return const CircularProgressIndicator();
//   }
// }

  
// }
import 'package:flutter/material.dart';
import 'package:newproj/screens/addmed.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newproj/screens/med.dart';
import 'package:newproj/screens/meddetailsscreen.dart';
import 'package:newproj/screens/medmodel.dart';

class DailyDose extends StatefulWidget {
  const DailyDose({super.key});

  @override
  State<DailyDose> createState() => _DailyDoseState();
}

class _DailyDoseState extends State<DailyDose> {
  late Box medicineBox;
  TextEditingController searchController=TextEditingController();
@override
  void initState() {
    super.initState();
    medicineBox=Hive.box<MedicineModel>('MedicineModelBox');
  }
  
  @override
  Widget build(BuildContext context) {
    medicineBox=Hive.box<MedicineModel>('MedicineModelBox');
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0.0,leading: IconButton(onPressed: (){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Medicine()), (route) => false);
      }, icon: Icon(Icons.arrow_back,color: Colors.black,),),title: Text('Welcome to daily doses',style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600,fontSize: 20),),),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.9],
            colors: [
              Colors.white,
              Colors.white,
             // Color.fromARGB(255, 116, 74, 129),
            ],
          ),
        ),
        child:  Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(controller: searchController,onChanged: (value){
                setState(() {
                  
                });
              },
              decoration: InputDecoration(labelText: 'search',labelStyle: TextStyle(color:Color.fromARGB(255, 116, 74, 129) ), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.black),),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color:Color.fromARGB(255, 116, 74, 129) ))),),
            ),
            _buildMedicineList(),
          ],
          
        ),
        
      ),
      
    floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
        return AddMed();
      }));
    },child: Text('+',style: TextStyle(fontSize: 20),),backgroundColor: Color.fromARGB(255, 116, 74, 129),foregroundColor: Colors.white,),
    );
  }
  Widget _buildMedicineList() {
  if (medicineBox.isOpen) {
    final medicines = medicineBox.values.where((medicine) => medicine.name.toLowerCase().startsWith(searchController.text.toLowerCase())).toList();



    if (medicines.isNotEmpty) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, 
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.5,
            ),
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return MedicineDetailsScreen(medicine: medicine);
                  }));
                 
                },
                child: Card(
                 // color: Color.fromARGB(132, 0, 0, 0),
                 //color: Colors.blue,
                 color:  Color.fromARGB(255, 116, 74, 129),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${medicine.name}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Dose: ${medicine.dosage}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Center(
        child:  Text(
          'No Medicines',
          style: TextStyle(color: Colors.black),
        ),
      );
    }
  } else {
    
    return const CircularProgressIndicator();
  }
}

  
}

