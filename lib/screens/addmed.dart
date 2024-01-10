import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newproj/screens/dailydose.dart';
import 'package:newproj/screens/dbfunctions/meddatabase.dart';
import 'package:newproj/screens/medmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newproj/screens/notinoti.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AddMed extends StatefulWidget {
  const AddMed({super.key});

  @override
  State<AddMed> createState() => _AddMedState();
}

class _AddMedState extends State<AddMed> {
  late Box boxes;
  late Box historyBox;
  bool? beforeFoodSelected;
  bool? afterFoodSelected;
  @override
  void initState() {
    super.initState();
    boxes = Hive.box<MedicineModel>('MedicineModelBox');
    historyBox = Hive.box<MedicineModel>('MedicineHistoryBox');
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
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: TextFormField(
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
              borderSide: const BorderSide(color: Colors.red),
            ),
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white)),
        validator: validator,
      ),
    );
  }

  final nameController = TextEditingController();
  final doseController = TextEditingController();
  final desController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> choices = ['Syrup', 'Tablet', 'Injections', 'inhalers'];
  String selectedChoice = '';

  List<TimeOfDay> selectedTimes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(220, 0, 0, 0),
        elevation: 0.0,
        title: const Text('Add your medicine'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.9],
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
                              selectedChoice = selected ? choice : '';
                            });
                          },
                          selectedColor:
                              const Color.fromARGB(255, 194, 66, 217));
                    }).toList(),
                  ),
                  seperator,
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: true,
                            groupValue: beforeFoodSelected,
                            onChanged: (bool? value) async {
                              setState(() {
                                beforeFoodSelected = value;
                                afterFoodSelected = false;
                              });
                            },
                          ),
                          const Text(
                            'Before Food',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: true,
                            groupValue: afterFoodSelected,
                            onChanged: (bool? value) async {
                              setState(() {
                                afterFoodSelected = value;
                                beforeFoodSelected = false;
                              });
                            },
                          ),
                          const Text(
                            'After Food',
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
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.transparent),
                    child: const Text(
                      'Select time',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  seperator,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 8.0,
                          children: selectedTimes.map((TimeOfDay time) {
                            return Chip(
                              label: Text(
                                '${time.format(context)}',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                              deleteIcon: const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                              onDeleted: () {
                                setState(() {
                                  selectedTimes.remove(time);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  seperator,
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (selectedChoice.isEmpty ||
                            beforeFoodSelected == null ||
                            afterFoodSelected == null ||
                            selectedTimes.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    'Please provide all the required data'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          saveMedicineToHive();
                          LocalNotifications.showSimpleNotifications(
                              title: 'medicine save',
                              body: 'we will track',
                              payload: 'this is your medicine');
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const DailyDose();
                          }));
                        }
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveMedicineToHive() async {
    String beforeOrAfter = '';
    if (beforeFoodSelected != null && beforeFoodSelected!) {
      beforeOrAfter = 'Before Food';
    } else if (afterFoodSelected != null && afterFoodSelected!) {
      beforeOrAfter = 'After Food';
    }

    List<String> formattedTimes = selectedTimes.map((time) {
      String period = time.period == DayPeriod.am ? 'AM' : 'PM';
      return '${time.hourOfPeriod}:${time.minute} $period';
    }).toList();

    await DatabaseHelper().saveMedicineToHive(
        name: nameController.text,
        dosage: doseController.text,
        description: desController.text,
        type: selectedChoice,
        beforeOrAfter: beforeOrAfter,
        selectedTimes: formattedTimes);
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      DateTime now = DateTime.now();
      DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (selectedDateTime.isBefore(now)) {
        selectedDateTime = selectedDateTime.add(Duration(days: 1));
      }

      setState(() {
        selectedTimes.add(TimeOfDay.fromDateTime(selectedDateTime));
      });

      int baseNotificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      selectedTimes.forEach((time) async {
        int notificationId = baseNotificationId + selectedTimes.indexOf(time);
        DateTime notificationTime = selectedDateTime;

        String medicineName = nameController.text;
        String dosage = doseController.text;
        String bodyy = 'Medicine:$medicineName,Dosage:$dosage';

        LocalNotifications.scheduleNotification(
          title: 'Hey, it\'s time to take your medicine',
          body: bodyy,
          payLoad: 'noti at time',
          scheduledNotificationDateTime: notificationTime,
          id: notificationId,
        );
      });
    }
  }
}
