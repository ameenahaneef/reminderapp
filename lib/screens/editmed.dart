

  
  import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newproj/screens/dailydose.dart';
import 'package:newproj/screens/medmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditMed extends StatefulWidget {
  final MedicineModel medicine;
  const EditMed({super.key, required this.medicine});

  @override
  State<EditMed> createState() => EditMedState();
}

class EditMedState extends State<EditMed> {
  late Box boxes;
   String selectedFoodTiming = 'Before Food';
  int selectedFrequency = 1; 
  List<TimeOfDay> selectedTimes = [];

  @override
  void initState() {
    super.initState();
    boxes = Hive.box<MedicineModel>('MedicineModelBox');
    nameController.text = widget.medicine.name;
    doseController.text = widget.medicine.dosage;
    desController.text = widget.medicine.description;
    selectedChoice = widget.medicine.type;
    selectedFoodTiming=widget.medicine.foodTime;
    selectedFrequency=widget.medicine.frequency;
    
  
    
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
                  
                  seperator,
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                     saveEditedMedicine();
                     Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return DailyDose();
                     }));
                    

                     } },
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
    );
  }

Future<void> saveEditedMedicine() async {
  widget.medicine.name = nameController.text;
  widget.medicine.dosage = doseController.text;
  widget.medicine.description = desController.text;
  widget.medicine.type = selectedChoice;
  widget.medicine.foodTime = selectedFoodTiming;
  widget.medicine.frequency = selectedFrequency;

  if (selectedTimes.isNotEmpty) {
    TimeOfDay selectedTime = selectedTimes.first;
    widget.medicine.startingTime =
        '${selectedTime.hour}:${selectedTime.minute}';
  }
  int indexOfMedicine = boxes.values.toList().indexOf(widget.medicine);

  boxes.putAt(indexOfMedicine, widget.medicine);

  print('Changes saved successfully');
}

  
  
  Future<void> _selectTime(BuildContext context) async {
    print('select time button pressed');

  TimeOfDay initialTime =
      selectedTimes.isNotEmpty ? selectedTimes.first : TimeOfDay.now();

  TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );
     
  if (selectedTime != null) {
    setState(() {
      selectedTimes = [selectedTime];
    });
  }
   
  }
}
  

  


  