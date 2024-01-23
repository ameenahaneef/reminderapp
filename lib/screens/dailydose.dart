import 'package:flutter/material.dart';
import 'package:newproj/screens/addmed.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newproj/screens/meddetailsscreen.dart';
import 'package:newproj/screens/medmodel.dart';
import 'package:newproj/screens/navbar.dart';

class DailyDose extends StatefulWidget {
  const DailyDose({super.key});

  @override
  State<DailyDose> createState() => _DailyDoseState();
}

class _DailyDoseState extends State<DailyDose> {
  late Box medicineBox;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    medicineBox = Hive.box<MedicineModel>('MedicineModelBox');
  }

  @override
  Widget build(BuildContext context) {
    medicineBox = Hive.box<MedicineModel>('MedicineModelBox');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 116, 74, 129),
        elevation: 0.0,
        title: const Text(
          'Welcome to daily doses',
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
      ),
      drawer: const NavBar(),
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
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    labelText: 'search',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 116, 74, 129)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 116, 74, 129)))),
              ),
            ),
            _buildMedicineList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return const AddMed();
          }));
        },
        backgroundColor: const Color.fromARGB(255, 116, 74, 129),
        foregroundColor: Colors.white,
        child: const Text(
          '+',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  Widget _buildMedicineList() {
    if (medicineBox.isOpen) {
      final medicines = medicineBox.values
          .where((medicine) => medicine.name
              .toLowerCase()
              .startsWith(searchController.text.toLowerCase()))
          .toList();

      if (medicines.isNotEmpty) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.2,
              ),
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final medicine = medicines[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return MedicineDetailsScreen(medicine: medicine);
                    }));
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 116, 74, 129),
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
        return const Center(
          child: Text(
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
