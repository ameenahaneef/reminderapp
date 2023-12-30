import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newproj/screens/dailydose.dart';
import 'package:newproj/screens/medmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  late NotificationsServices notificationsServices;
  String selectedFoodTiming = 'Before Food';
  int selectedFrequency = 1; // Default to once a day

  @override
  void initState() {
    super.initState();
    boxes = Hive.box<MedicineModel>('MedicineModelBox');
    historyBox = Hive.box<MedicineModel>('MedicineHistoryBox');
    notificationsServices = NotificationsServices();
    notificationsServices.initialiseNotifications();
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

                  

                  Row(
                    children: [
                      Radio(
                        value: 'Before Food',
                        groupValue: selectedFoodTiming,
                        onChanged: (String? value) {
                          setState(() {
                            selectedFoodTiming = value!;
                          });
                        },
                      ),
                      const Text(
                        'Before Food',
                        style: TextStyle(color: Colors.white),
                      ),
                      Radio(
                        value: 'After Food',
                        groupValue: selectedFoodTiming,
                        onChanged: (String? value) {
                          setState(() {
                            selectedFoodTiming = value!;
                          });
                        },
                      ),
                      const Text(
                        'After Food',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  seperator,
                  Row(
                    children: [
                      Center(
                        child: Container(
                          width: 290,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: DropdownButton<int>(
                              value: selectedFrequency,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedFrequency = value!;
                                });
                              },
                              style: const TextStyle(
                                  color:
                                      Colors.white), // Set text color to white
                              underline: Container(), // Remove the underline
                              dropdownColor: Colors.black,
                              items: const [
                                DropdownMenuItem<int>(
                                  value: 1,
                                  child: Text('Once a day'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 2,
                                  child: Text('Twice a day'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 3,
                                  child: Text('Thrice a day'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 4,
                                  child: Text('Four times a day'),
                                ),
                              ],
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  seperator,
                  ElevatedButton(
                    onPressed: () async {
                     await _selectStartingTime();
                    },
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.transparent),
                    child: const Text(
                      'Starting time',
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
                      if (_formKey.currentState!.validate()) {
                        saveMedicineToHive();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return DailyDose();
                        }));
                      }
                      // });
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(onPressed: (){
                    notificationsServices.sendNotification("title", "body");}, child: const Text('hi'))
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
      foodTime: selectedFoodTiming, 
      frequency: selectedFrequency, 
      startingTime: selectedTimes.isNotEmpty ? selectedTimes.first.format(context) : '', 
      
    );

    await boxes.add(medicine);
    

    print('data stored suuceesfully');
    print('name:${medicine.name}');
    print('dose:${medicine.dosage}');

    print('description:${medicine.description}');

    print('type:${medicine.type}');
    print('foodtime:${medicine.foodTime}');
    print('interval:${medicine.frequency}');
    print('startingtime:${medicine.startingTime}');
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
  Future<void> _selectStartingTime() async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime != null) {
    setState(() {
      selectedTimes=[pickedTime];
      //selectedTimes.add(pickedTime);
    });
  }
}

  
}
