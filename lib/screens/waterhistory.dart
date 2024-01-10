import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:newproj/screens/style.dart';
import 'package:newproj/screens/watermodel.dart'; 

class ConsumptionHistoryScreen extends StatefulWidget {
  final int consumedAmountFromWaterTrack;
  const ConsumptionHistoryScreen({required this.consumedAmountFromWaterTrack});
  @override
  _ConsumptionHistoryScreenState createState() =>
      _ConsumptionHistoryScreenState();
}

class _ConsumptionHistoryScreenState extends State<ConsumptionHistoryScreen> {
  late Future<Box<ConsumptionData>> _boxFuture;

  @override
  void initState() {
    super.initState();
    _boxFuture = _openBox();
  }

  Future<Box<ConsumptionData>> _openBox() async {
    final box = await Hive.openBox<ConsumptionData>('consumption_data');
    return box;
  }

  List<ConsumptionData> _groupDataByDay(List<ConsumptionData> dataList) {
    Map<DateTime, List<ConsumptionData>> groupedData = {};

    for (var data in dataList) {
      DateTime day = DateTime(
          data.consumedDay.year, data.consumedDay.month, data.consumedDay.day);
      groupedData[day] = groupedData[day] ?? [];
      groupedData[day]!.add(data);
    }

    List<ConsumptionData> result = [];

    groupedData.forEach((key, value) {
      int totalConsumedAmount = 0;
      for (var data in value) {
        totalConsumedAmount += data.consumedAmount;
      }
      result.add(ConsumptionData(
          consumedDay: key,
          consumedAmount: widget.consumedAmountFromWaterTrack,
          reminderInterval: ''));
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Consumption History'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.9],
            colors: [
              Color.fromARGB(255, 10, 9, 9),
              Color.fromARGB(255, 116, 74, 129),
            ],
          ),
        ),
        child: FutureBuilder(
          future: _boxFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final box = snapshot.data as Box<ConsumptionData>;
                if (box.isNotEmpty) {
                  List<ConsumptionData> dataList = box.values.toList();
                  List<ConsumptionData> groupedData = _groupDataByDay(dataList);

                  return ListView.separated(
                    itemCount: groupedData.length,
                    itemBuilder: (context, index) {
                      final data = groupedData[index];
                      final formattedDate =
                          DateFormat.yMd().format(data.consumedDay);
                      return ListTile(
                        title: Text(
                          '$formattedDate',
                          style: MyTextStyles.bodyTextStyle(15),
                        ),
                        subtitle: Text(
                          'Consumed Amount: ${data.consumedAmount} ml',
                          style: MyTextStyles.bodyTextStyle(15),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                  );
                } else {
                  return Center(
                    child: Text(
                      'No consumption data available.',
                      style: MyTextStyles.bodyTextStyle(20),
                    ),
                  );
                }
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
