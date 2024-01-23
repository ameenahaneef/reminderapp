import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:newproj/screens/style.dart';
import 'package:newproj/screens/watermodel.dart';

class DailyConsumptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Consumption'),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.4, 0.7],
            colors: [
              Colors.black,
              Color.fromARGB(255, 94, 66, 103),
            ],
          ),
        ),
        child: FutureBuilder(
          future: _loadDailyConsumptionData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
              return Center(
                child: Text(
                  'No daily consumption data available.',
                  style: MyTextStyles.bodyTextStyle(16),
                ),
              );
            } else {
              List<ConsumptionData> dailyConsumptionData =
                  snapshot.data as List<ConsumptionData>;

              return ListView.builder(
                itemCount: dailyConsumptionData.length,
                itemBuilder: (context, index) {
                  ConsumptionData data = dailyConsumptionData[index];

                  return ListTile(
                    title: Text(
                        'Date: ${DateFormat('yyyy-MM-dd').format(data.consumedDay)}',
                        style: MyTextStyles.bodyTextStyle(16)),
                    subtitle: Text('Consumed Amount: ${data.consumedAmount} ml',
                        style: MyTextStyles.bodyTextStyle(16)),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<ConsumptionData>> _loadDailyConsumptionData() async {
    final box = await Hive.openBox<ConsumptionData>('consumption_data');
    Map<DateTime, int> dailyConsumptionMap = {};

    for (var entry in box.values) {
      DateTime day = DateTime(entry.consumedDay.year, entry.consumedDay.month,
          entry.consumedDay.day);
      dailyConsumptionMap[day] =
          (dailyConsumptionMap[day] ?? 0) + entry.consumedAmount;
    }

    List<ConsumptionData> dailyConsumptionData = [];

    dailyConsumptionMap.forEach((day, totalConsumedAmount) {
      dailyConsumptionData.add(ConsumptionData(
        consumedDay: day,
        consumedAmount: totalConsumedAmount,
        reminderInterval: '',
      ));
    });

    return dailyConsumptionData;
  }
}
