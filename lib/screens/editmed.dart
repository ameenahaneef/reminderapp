// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:newproj/screens/dailydose.dart';
// import 'package:newproj/screens/medmodel.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:intl/intl.dart';

// class EditMed extends StatefulWidget {
//   final MedicineModel medicine;
//   const EditMed({super.key, required this.medicine});

//   @override
//   State<EditMed> createState() => EditMedState();
// }

// class EditMedState extends State<EditMed> {
//   late Box boxes;
//   @override
//   void initState() {
//     super.initState();
//     boxes = Hive.box<MedicineModel>('MedicineModelBox');
//     nameController.text = widget.medicine.name;
//     doseController.text = widget.medicine.dosage;
//     desController.text = widget.medicine.description;
//     selectedChoice = widget.medicine.type;
//     //selectedDates = widget.medicine.selectedDates;
//     selectedTimes = widget.medicine.selectedTimes
//         .map((time) => TimeOfDay.fromDateTime(DateFormat.Hm().parse(time)))
//         .toList();
//   }

//   Widget seperator = const SizedBox(
//     height: 20,
//   );

//   Widget medButton({
//     required TextEditingController text,
//     required String label,
//     int? maxLines,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       controller: text,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide: const BorderSide(color: Colors.white)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.white)),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: const BorderSide(
//                 color: Colors.red), 
//           ),
//           labelText: label,
//           labelStyle: const TextStyle(color: Colors.white)),
//       validator: validator,
//     );
//   }

//   final nameController = TextEditingController();
//   final doseController = TextEditingController();
//   final desController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   List<String> choices = ['Syrup', 'Tablet', 'Injections', 'inhalers'];
//   String selectedChoice = 'Syrup';

//   DateTimeRange? selectedDateRange;
//   bool everydaySelected = true;

//   List<TimeOfDay> selectedTimes = [];
//   List<DateTime> selectedDates = [];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(220, 0, 0, 0),
//           elevation: 0.0,
//           title: const Text('Edit your medicine'),
//         ),
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               stops: [0.4, 0.9],
//               colors: [
//                 Color.fromARGB(220, 0, 0, 0),
//                 Color.fromARGB(255, 116, 74, 129),
//               ],
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     medButton(
//                         text: nameController,
//                         label: 'Medicine name',
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'please enter medicine name';
//                           }
//                           return null;
//                         }),
//                     seperator,
//                     medButton(
//                         text: doseController,
//                         label: 'Dosage',
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'please enter the dosage';
//                           }
//                           return null;
//                         }),
//                     seperator,
//                     medButton(
//                         text: desController,
//                         label: 'Description',
//                         maxLines: 5,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'please enter the description';
//                           }
//                           return null;
//                         }),
//                     seperator,
//                     Wrap(
//                       spacing: 8.0,
//                       children: choices.map((String choice) {
//                         return ChoiceChip(
//                             label: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(choice),
//                             ),
//                             selected: selectedChoice == choice,
//                             onSelected: (bool selected) {
//                               setState(() {
//                                 selectedChoice = choice;
//                               });
//                             },
//                             selectedColor:
//                                 const Color.fromARGB(255, 194, 66, 217));
//                       }).toList(),
//                     ),
//                     seperator,
//                     const Text(
//                       'Select Days',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     Row(
//                       children: [
//                         Row(
//                           children: [
//                             Radio(
//                               value: true,
//                               groupValue: everydaySelected,
//                               onChanged: (bool? value) async {
//                                 setState(() {
//                                   everydaySelected = true;
//                                 });
//                                 await _selectDateRange(context);
//                               },
//                             ),
//                             const Text(
//                               'Everyday',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Radio(
//                               value: false,
//                               groupValue: everydaySelected,
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   everydaySelected = false;
//                                   _selectDateRange(context);
//                                 });
//                               },
//                             ),
//                             const Text(
//                               'Every alternative day',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     seperator,
//                     ElevatedButton(
//                       onPressed: () async {
//                         await _selectTime(context);
//                       },
//                       child: const Text(
//                         'Select time',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                           side: const BorderSide(color: Colors.white),
//                           minimumSize: const Size(double.infinity, 50),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30)),
//                           backgroundColor: Colors.transparent),
//                     ),
//                     seperator,
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Wrap(
//                         spacing: 8.0,
//                         children: selectedDaysChips(),
//                       ),
//                     ),
//                     seperator,
//                     ElevatedButton(
//                       onPressed: () {
//                         if (selectedDates.isEmpty || selectedTimes.isEmpty) {
//                           // Show AlertDialog if date or time is not selected
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: const Text('Incomplete Selection'),
//                                 content: const Text(
//                                     'Please select both date and time for your medicine.'),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text('OK'),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         } else {
//                           setState(() {
//                             if (_formKey.currentState!.validate()) {
//                               saveEditedMedicine();
//                               Navigator.of(context).pushReplacement(
//                                   MaterialPageRoute(builder: (ctx) {
//                                 return const DailyDose();
//                               }));
//                             }
//                           });
//                         }
//                       },
//                       child:  const Text(
//                         'Save Changes',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> saveEditedMedicine() async {
//     widget.medicine.name = nameController.text;
//     widget.medicine.dosage = doseController.text;
//     widget.medicine.description = desController.text;
//     widget.medicine.type = selectedChoice;
//     // widget.medicine.selectedDates = selectedDates;
//     widget.medicine.selectedTimes =
//         selectedTimes.map((time) => time.format(context)).toList();

//     print('Changes saved successfully');
//   }

//   List<Widget> selectedDaysChips() {
//     List<Widget> chips = [];

//     for (int index = 0; index < selectedTimes.length; index++) {
//       TimeOfDay time = selectedTimes[index];
//       chips.add(
//         Row(
//           children: [
//             Chip(
//               label: Text(
//                 '${time.format(context)}',
//                 style: const TextStyle(color: Colors.white),
//               ),
//               backgroundColor: Colors.black,
//               deleteIcon: const Icon(
//                 Icons.delete,
//                 color: Colors.white,
//               ),
//               onDeleted: () {
//                 setState(() {
//                   selectedTimes.removeAt(index);
//                 });
//               },
//             ),
//           ],
//         ),
//       );
//     }

//     return chips;
//   }

//   Future<void> _selectDateRange(BuildContext context) async {
//     DateTime currentDate = DateTime.now();
//     DateTime lastDate = currentDate.add(Duration(days: 365));

//     selectedDateRange = await showDateRangePicker(
//       context: context,
//       firstDate: currentDate,
//       lastDate: lastDate,
//     );

//     if (selectedDateRange != null) {
//       setState(() {
//         selectedDateRange = selectedDateRange;
//         selectedDates.clear();
//         selectedDates.addAll(getDatesInRange(selectedDateRange!));
//       });
//     }
//   }

//   List<DateTime> getDatesInRange(DateTimeRange dateRange) {
//     List<DateTime> dates = [];
//     DateTime currentDate = dateRange.start;

//     while (currentDate.isBefore(dateRange.end)) {
//       dates.add(currentDate);
//       currentDate = currentDate.add(Duration(days: 1));
//     }

//     return dates;
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     TimeOfDay? selectedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     if (selectedTime != null) {
//       setState(() {
//         selectedTimes.add(selectedTime);
//       });
//       print('Selected Time: ${selectedTime.format(context)}');
//     }
//   }
// }
  

  


  
  import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newproj/screens/dailydose.dart';
import 'package:newproj/screens/medmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class EditMed extends StatefulWidget {
  final MedicineModel medicine;
  const EditMed({super.key, required this.medicine});

  @override
  State<EditMed> createState() => EditMedState();
}

class EditMedState extends State<EditMed> {
  late Box boxes;
  @override
  void initState() {
    super.initState();
    boxes = Hive.box<MedicineModel>('MedicineModelBox');
    nameController.text = widget.medicine.name;
    doseController.text = widget.medicine.dosage;
    desController.text = widget.medicine.description;
    selectedChoice = widget.medicine.type;
    selectedDates = widget.medicine.selectedDates;
    selectedTimes = widget.medicine.selectedTimes
        .map((time) => TimeOfDay.fromDateTime(DateFormat.Hm().parse(time)))
        .toList();
  }

  Widget seperator = const SizedBox(
    height: 20,
  );

  Widget medButton({
    required TextEditingController text,
    required String label,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
                color: Colors.red), 
          ),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white)),
      validator: validator,
    );
  }

  final nameController = TextEditingController();
  final doseController = TextEditingController();
  final desController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> choices = ['Syrup', 'Tablet', 'Injections', 'inhalers'];
  String selectedChoice = 'Syrup';

  DateTimeRange? selectedDateRange;
  bool everydaySelected = true;

  List<TimeOfDay> selectedTimes = [];
  List<DateTime> selectedDates = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(220, 0, 0, 0),
          elevation: 0.0,
          title: const Text('Edit your medicine'),
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
                Color.fromARGB(220, 0, 0, 0),
                Color.fromARGB(255, 116, 74, 129),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    medButton(
                        text: nameController,
                        label: 'Medicine name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter medicine name';
                          }
                          return null;
                        }),
                    seperator,
                    medButton(
                        text: doseController,
                        label: 'Dosage',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter the dosage';
                          }
                          return null;
                        }),
                    seperator,
                    medButton(
                        text: desController,
                        label: 'Description',
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter the description';
                          }
                          return null;
                        }),
                    seperator,
                    Wrap(
                      spacing: 8.0,
                      children: choices.map((String choice) {
                        return ChoiceChip(
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(choice),
                            ),
                            selected: selectedChoice == choice,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedChoice = choice;
                              });
                            },
                            selectedColor:
                                const Color.fromARGB(255, 194, 66, 217));
                      }).toList(),
                    ),
                    seperator,
                    const Text(
                      'Select Days',
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: true,
                              groupValue: everydaySelected,
                              onChanged: (bool? value) async {
                                setState(() {
                                  everydaySelected = true;
                                });
                                await _selectDateRange(context);
                              },
                            ),
                            const Text(
                              'Everyday',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: false,
                              groupValue: everydaySelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  everydaySelected = false;
                                  _selectDateRange(context);
                                });
                              },
                            ),
                            const Text(
                              'Every alternative day',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    seperator,
                    ElevatedButton(
                      onPressed: () async {
                        await _selectTime(context);
                      },
                      child: const Text(
                        'Select time',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          backgroundColor: Colors.transparent),
                    ),
                    seperator,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 8.0,
                        children: selectedDaysChips(),
                      ),
                    ),
                    seperator,
                    ElevatedButton(
                      onPressed: () {
                        if (selectedDates.isEmpty || selectedTimes.isEmpty) {
                         
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Incomplete Selection'),
                                content: const Text(
                                    'Please select both date and time for your medicine.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              saveEditedMedicine();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (ctx) {
                                return const DailyDose();
                              }));
                            }
                          });
                        }
                      },
                      child:  const Text(
                        'Save Changes',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveEditedMedicine() async {
    widget.medicine.name = nameController.text;
    widget.medicine.dosage = doseController.text;
    widget.medicine.description = desController.text;
    widget.medicine.type = selectedChoice;
    widget.medicine.selectedDates = selectedDates;
    widget.medicine.selectedTimes =
        selectedTimes.map((time) => time.format(context)).toList();


    print('Changes saved successfully');
  }

  List<Widget> selectedDaysChips() {
    List<Widget> chips = [];

    for (int index = 0; index < selectedTimes.length; index++) {
      TimeOfDay time = selectedTimes[index];
      chips.add(
        Row(
          children: [
            Chip(
              label: Text(
                '${time.format(context)}',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
              deleteIcon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onDeleted: () {
                setState(() {
                  selectedTimes.removeAt(index);
                });
              },
            ),
          ],
        ),
      );
    }

    return chips;
  }

  Future<void> _selectDateRange(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime lastDate = currentDate.add(Duration(days: 365));

    selectedDateRange = await showDateRangePicker(
      context: context,
      firstDate: currentDate,
      lastDate: lastDate,
    );

    if (selectedDateRange != null) {
      setState(() {
        selectedDateRange = selectedDateRange;
        selectedDates.clear();
        selectedDates.addAll(getDatesInRange(selectedDateRange!));
      });
    }
  }

  List<DateTime> getDatesInRange(DateTimeRange dateRange) {
    List<DateTime> dates = [];
    DateTime currentDate = dateRange.start;

    while (currentDate.isBefore(dateRange.end)) {
      dates.add(currentDate);
      currentDate = currentDate.add(Duration(days: 1));
    }

    return dates;
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        selectedTimes.add(selectedTime);
      });
      print('Selected Time: ${selectedTime.format(context)}');
    }
  }
}
  

  


  