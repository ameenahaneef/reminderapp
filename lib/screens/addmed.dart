
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newproj/screens/dailydose.dart';
import 'package:newproj/screens/medmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newproj/screens/notiservice.dart';

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
              borderSide: const BorderSide(
                  color: Colors.red), 
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
  String selectedChoice = 'Syrup';

  DateTimeRange? selectedDateRange;
  bool? everydaySelected;

  List<TimeOfDay> selectedTimes = [];
  List<DateTime> selectedDates = [];

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
                                everydaySelected = value;
                              });
                              if (value == true) {
                                await _selectDateRange(context);
                              }
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
                                everydaySelected = value;
                              });
                              if (value == false) {
                                _selectDateRange(context);
                              }
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
                        // setState(() {
                          if (_formKey.currentState!.validate()) {
                            saveMedicineToHive();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return DailyDose();
                            }));
                          }
                        // });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  //TextButton(onPressed: (){notificationsServices.sendNotification("title", "body");}, child: Text('hi'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveMedicineToHive() async {
    MedicineModel medicine = MedicineModel(
      name: nameController.text,
      dosage: doseController.text,
      description: desController.text,
      type: selectedChoice,
      selectedDates: selectedDates,
      selectedTimes: selectedTimes.map((time) => time.format(context)).toList(),
    );

    await boxes.add(medicine);
    await historyBox.add(medicine);

    print('data stored suuceesfully');
    print('name:${medicine.name}');
    print('dose:${medicine.dosage}');

    print('description:${medicine.description}');

    print('type:${medicine.type}');
    print(
        'date:${medicine.selectedDates.toSet().map((date) => DateFormat('yyyy-MM-dd').format(date))}');
    print('times:${medicine.selectedTimes}');

    
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
        if (everydaySelected == true) {
          selectedDates.addAll(getDatesInRange(selectedDateRange!));
        } else {
          selectedDates.addAll(getAlternateDatesInRange(selectedDateRange!));
        }
      });
      for (int i = 0; i < selectedDates.length; i++) {
        DateTime date = selectedDates[i];
        for (int j = 0; j < selectedTimes.length; j++) {
          TimeOfDay time = selectedTimes[j];
          DateTime ScheduledDateTime =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
          print('scheduled Date:$ScheduledDateTime');
        }
      }
    }
  }

  List<DateTime> getAlternateDatesInRange(DateTimeRange dateRange) {
    List<DateTime> dates = [];
    DateTime currentDate = dateRange.start;
    bool alternateDay = false;

    while (currentDate.isBefore(dateRange.end)) {
      dates.add(currentDate);
      currentDate = currentDate.add(Duration(days: alternateDay ? 2 : 0));
      alternateDay = !alternateDay;
    }

    return dates;
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

    if (selectedTime != null && selectedDateRange != null) {
      DateTime scheduledDateTime = DateTime(
        selectedDateRange!.start.year,
        selectedDateRange!.start.month,
        selectedDateRange!.start.day,
        selectedTime.hour,
        selectedTime.minute,
      );print('${scheduledDateTime}');
        selectedTimes.add(selectedTime);
        NotificationsServices notificationsServices=NotificationsServices();
      await notificationsServices.scheduleNotification(0,'medicine reminder','take your medicine',scheduledDateTime);
//notificationsServices.sendNotification("title", "body"); //child: Text('hi');
     
      setState(() {

      });
    }
  }

}