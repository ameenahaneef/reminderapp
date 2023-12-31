// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:intl/intl.dart';
// import 'package:newproj/screens/dailydose.dart';
// import 'package:newproj/screens/editmed.dart';
// import 'package:newproj/screens/medmodel.dart';

// Widget seper = const SizedBox(
//   height: 10,
// );

// class MedicineDetailsScreen extends StatefulWidget {
//   final MedicineModel medicine;

//   const MedicineDetailsScreen({super.key, required this.medicine});

//   @override
//   State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
// }

// class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
//   late Box boxes;
//   @override
//   void initState() {
//     super.initState();
//     boxes = Hive.box<MedicineModel>('MedicineModelBox');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Medicine Details'),
//           backgroundColor: Colors.black,
//           elevation: 0.0,
//         ),
//         body: Container(
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               stops: [0.4, 0.9],
//               colors: [
//                 Colors.black,
//                 Color.fromARGB(255, 116, 74, 129),
//               ],
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Name: ${widget.medicine.name}',
//                   style: const TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 seper,
//                 Text(
//                   'Dosage: ${widget.medicine.dosage}',
//                   style: const TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 seper,
//                 Text(
//                   'dedscription:${widget.medicine.description}',
//                   style: const TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 seper,
//                 Text(
//                   'Type:${widget.medicine.type}',
//                   style: const TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 seper,

//                 // Text(
//                 //   'Selected Dates: ${_formatDates(widget.medicine.selectedDates)}',
//                 //   style: const TextStyle(color: Colors.white, fontSize: 20),
//                 // ),
//                 seper,
//                 Text(
//                   'Selected Times: ${widget.medicine.selectedTimes.join(", ")}',
//                   style: const TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 seper,

//                 // Add other details as needed
//                 // ...

//                 // Edit and Delete buttons
//                 seper,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white),
//                       onPressed: () {
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (ctx) {
//                           return EditMed(medicine: widget.medicine);
//                         }));
//                       },
//                       child: const Text(
//                         'Edit',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white),
//                       onPressed: () {
//                         showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: const Text('Confirm Deletion'),
//                                 content: const Text(
//                                     'Are you sure you want to delete this medicine?'),
//                                 actions: [
//                                   TextButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: const Text('Cancel')),
//                                   TextButton(
//                                       onPressed: () async {
//                                         deleteMedicine();
//                                         print(
//                                             'the medicine${widget.medicine.name} got deleted');
//                                         Navigator.pushAndRemoveUntil(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     DailyDose()),
//                                             (route) => false);
//                                       },
//                                       child: const Text('Delete'))
//                                 ],
//                               );
//                             });
//                       },
//                       child: const Text('Delete',
//                           style: TextStyle(color: Colors.black)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }

//   Future<void> deleteMedicine() async {
//     final index = boxes.values.toList().indexOf(widget.medicine);
//     if (index != -1) {
//       boxes.deleteAt(index);
//     }
//   }

//   String _formatDates(List<DateTime> dates) {
//     final formattedDates =
//         dates.map((date) => DateFormat('yyyy-MM-dd').format(date)).toList();
//     return formattedDates.join(", ");
//   }
// }

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:newproj/screens/dailydose.dart';
import 'package:newproj/screens/editmed.dart';
import 'package:newproj/screens/medmodel.dart';

Widget seper = const SizedBox(
  height: 10,
);

class MedicineDetailsScreen extends StatefulWidget {
  final MedicineModel medicine;

  const MedicineDetailsScreen({super.key, required this.medicine});

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  late Box boxes;
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    boxes = Hive.box<MedicineModel>('MedicineModelBox');
    searchController=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Medicine Details'),
          backgroundColor: Colors.black,
          elevation: 0.0,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.4, 0.9],
              colors: [
                Colors.black,
                Color.fromARGB(255, 116, 74, 129),
              ],
            ),
          ),
           child: SingleChildScrollView(
             child: Padding(
                     padding: const EdgeInsets.all(50.0),
                     child: Card(
                                 color: Color.fromARGB(255, 108, 75, 111),
                                 elevation: 8.0,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(15.0),
                                 ),
                                     
                     child: Padding(
                                 padding: const EdgeInsets.all(16.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       'Name: ${widget.medicine.name}',
                                       style: const TextStyle(color: Colors.white, fontSize: 20),
                                     ),
                                     seper,
                                     Text(
                                       'Dosage: ${widget.medicine.dosage}',
                                       style: const TextStyle(color: Colors.white, fontSize: 20),
                                     ),
                                     seper,
                                     Text(
                                       'dedscription:${widget.medicine.description}',
                                       style: const TextStyle(color: Colors.white, fontSize: 20),
                                     ),
                                     seper,
                                     Text(
                                       'Type:${widget.medicine.type}',
                                       style: const TextStyle(color: Colors.white, fontSize: 20),
                                     ),
                                     seper,
                                     Text('food time:${widget.medicine.foodTime}',style: const TextStyle(color: Colors.white,fontSize: 20),),
                                    
                                     
                                     seper,
                                     Text('Interval:${widget.medicine.frequency}',style: TextStyle(color: Colors.white,fontSize: 20),),
                                     seper,
                                     Text('starting time:${widget.medicine.startingTime}',style: TextStyle(color: Colors.white,fontSize: 20),),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return EditMed(medicine:widget.medicine ,);
                          }));
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: const Text(
                                      'Are you sure you want to delete this medicine?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () async {
                                          deleteMedicine();
                                          print(
                                              'the medicine${widget.medicine.name} got deleted');
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DailyDose()),
                                              (route) => false);
                                        },
                                        child: const Text('Delete'))
                                  ],
                                );
                              });
                        },
                        child: const Text('Delete',
                            style: TextStyle(color: Colors.black)),
                      ),
                                       ],
                                     ),
                                   ],
                                 ),
                     ),
                                     )),
           )));
  }

  Future<void> deleteMedicine() async {
    final index = boxes.values.toList().indexOf(widget.medicine);
    if (index != -1) {
      boxes.deleteAt(index);
    }
  }

  String _formatDates(List<DateTime> dates) {
    final formattedDates =
        dates.map((date) => DateFormat('yyyy-MM-dd').format(date)).toList();
    return formattedDates.join(", ");
  }
}

