import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newproj/screens/dbfunctions/meddatabase.dart';
import 'package:newproj/screens/meddetailsscreen.dart';
import 'package:newproj/screens/medmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newproj/screens/notinoti.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class EditMed extends StatefulWidget {
  final MedicineModel medicine;
  const EditMed({super.key, required this.medicine});

  @override
  State<EditMed> createState() => _EditMedState();
}

class _EditMedState extends State<EditMed> {
  late Box boxes;
  late Box historyBox;
  bool? beforeFoodSelected;
  bool? afterFoodSelected;
  final nameController = TextEditingController();
  final doseController = TextEditingController();
  final desController = TextEditingController();
  List<dynamic> selectedTimes = [];

  @override
  void initState() {
    super.initState();
    boxes = Hive.box<MedicineModel>('MedicineModelBox');
    historyBox = Hive.box<MedicineModel>('MedicineHistoryBox');
    nameController.text = widget.medicine.name;
    doseController.text = widget.medicine.dosage;
    desController.text = widget.medicine.description;
    selectedChoice = widget.medicine.type;
    if (widget.medicine.beforeOrAfter == 'Before food') {
      beforeFoodSelected = true;
      afterFoodSelected = false;
    } else {
      beforeFoodSelected = false;
      afterFoodSelected = true;
    }
    selectedTimes = widget.medicine.selectedTimes.toList();
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> choices = ['Syrup', 'Tablet', 'Injections', 'inhalers'];
  String selectedChoice = 'Syrup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              selectedChoice = choice;
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
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        String period = pickedTime.hour >= 12 ? 'PM' : 'AM';
                        int hour = pickedTime.hourOfPeriod == 0
                            ? 12
                            : pickedTime.hourOfPeriod;
                        setState(() {
                          selectedTimes
                              .add('$hour:${pickedTime.minute}$period');
                        });
                      }
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
                          children: selectedTimes.map((dynamic time) {
                            return Chip(
                              label: Text(
                                time,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                              deleteIconColor: Colors.white,
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        saveUpdatedData();
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text(
                      'Save Changes',
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

  void saveUpdatedData() {
    MedicineModel updatedMedicine = MedicineModel(
        name: nameController.text,
        dosage: doseController.text,
        description: desController.text,
        type: selectedChoice,
        beforeOrAfter:
            beforeFoodSelected == true ? 'before food' : 'after food',
        selectedTimes: selectedTimes);

    DatabaseHelper().updateMedicine(widget.medicine, updatedMedicine);

    LocalNotifications.cancelAll();
    int idCounter = 1;

    for (String time in selectedTimes) {
      List<String> parts = time.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1].substring(0, 2));
      String period = parts[1].substring(2);

      if (period == 'PM' && hour != 12) {
        hour += 12;
      }

      DateTime scheduledNotificationDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        hour,
        minute,
      );

      int id = idCounter++;
      LocalNotifications.scheduleNotification(
        title: 'Medicine Reminder',
        body:
            'Take your medicine: ${updatedMedicine.name},${updatedMedicine.dosage}',
        payLoad: 'medicine_reminder',
        scheduledNotificationDateTime: scheduledNotificationDateTime,
        id: id,
      );
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return MedicineDetailsScreen(medicine: updatedMedicine);
    }));
  }
}
