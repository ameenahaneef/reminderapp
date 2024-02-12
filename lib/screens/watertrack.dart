import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newproj/screens/dbfunctions/waterdatabase.dart';
import 'package:newproj/screens/navbar.dart';
import 'package:newproj/screens/notinoti.dart';
import 'package:newproj/screens/style.dart';
import 'package:newproj/screens/waterhistory.dart';
import 'package:newproj/screens/watermodel.dart';

class WaterTrack extends StatefulWidget {
  static String selectedReminderFrequency = 'every minute';

  const WaterTrack({Key? key}) : super(key: key);

  @override
  State<WaterTrack> createState() => _WaterTrackState();
}

class _WaterTrackState extends State<WaterTrack> {
  int dailyGoal = 2640;
  int consumedAmount = 0;
  int selectedQuantity = 0;
  bool showChoiceChips = false;
  DateTime lastConsumptionDate = DateTime.now();
  String selectedReminderFrequency = 'every minute';
  bool isReminderSet = false;

  @override
  void initState() {
    super.initState();

    WaterHelper.loadConsumptionData(_setConsumptionData);
    WaterHelper.loadReminderData(_setReminderData);
  }

  void _setConsumptionData(int consumedAmount, DateTime lastConsumptionDate) {
    setState(() {
      this.consumedAmount = consumedAmount;
      this.lastConsumptionDate = lastConsumptionDate;
    });
  }

  void _setReminderData(String reminderFrequency) {
    setState(() {
      selectedReminderFrequency = reminderFrequency;
      isReminderSet = true;
    });
  }

  Future<void> _loadReminderData() async {
    WaterHelper.loadReminderData(_setReminderData);
  }

  Future<void> _loadConsumptionData() async {
    WaterHelper.loadConsumptionData(_setConsumptionData);
  }

  Future<void> _updateConsumedAmount(int amount) async {
    DateTime today = DateTime.now();

    if (today.difference(lastConsumptionDate).inDays > 0) {
      setState(() {
        consumedAmount = 0;
        lastConsumptionDate = today;
      });
    }

    if (selectedQuantity > 0) {
      setState(() {
        consumedAmount += amount;
        showChoiceChips = false;
        selectedQuantity = 0;
      });

      await _saveConsumptionData(today, amount);

      if (consumedAmount >= dailyGoal) {
        _showGoalAchievedDialog();
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Alert'),
              content: const Text(
                  'Please select a quantity before updating consumption'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'))
              ],
            );
          });
    }
  }

  Future<void> _saveConsumptionData(DateTime date, int amount) async {
    final consumptionData = ConsumptionData(
        consumedDay: date,
        consumedAmount: amount,
        reminderInterval: selectedReminderFrequency);
    final box = await Hive.openBox<ConsumptionData>('consumption_data');
    box.add(consumptionData);
    print('added $amount');
  }

  void _showGoalAchievedDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
                child: Text(
              '****Goal Achieved****',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            )),
            content: const Text(
              'Congratulations! You have reached your dialy water goal.',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            backgroundColor: const Color.fromARGB(255, 86, 45, 90),
            elevation: 5.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ))
            ],
          );
        });
  }

  void _showReminderOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set Reminder'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Every Minute'),
                  onTap: () {
                    _updateReminderFrequency('Every Minute');
                    LocalNotifications.showSimpleNotifications(
                        title: 'succes',
                        body: 'Alarm set',
                        payload: 'watching you');
                    LocalNotifications.showPeriodicNNotifications(
                        title: 'every minute',
                        body: 'this is every minute notification',
                        payload: 'This is periodic data');
                  },
                ),
                ListTile(
                  title: const Text('Every 5 minutes'),
                  onTap: () {
                    _updateReminderFrequency('Every five minutes');
                    LocalNotifications.showSimpleNotifications(
                        title: 'succes',
                        body: 'Alarm set',
                        payload: 'watching you');

                    LocalNotifications.showScheduleNotifications(
                        title: 'schedule notification',
                        body: 'this is noti after 5 mins',
                        payload: 'this is scheduled');
                  },
                ),
                ListTile(
                  title: const Text('Every Hour'),
                  onTap: () {
                    _updateReminderFrequency('Every Hour');
                    LocalNotifications.showSimpleNotifications(
                        title: 'succes',
                        body: 'Alarm set',
                        payload: 'watching you');
                    LocalNotifications.showPeriodicNNotificationsHourly(
                        title: 'Every hour',
                        body: 'This is every Hour Notification',
                        payload: 'This is every hour data');
                  },
                ),
                ListTile(
                  title: const Text('Every Two Hours'),
                  onTap: () {
                    _updateReminderFrequency('Every Two Hours');
                    LocalNotifications.showSimpleNotifications(
                        title: 'succes',
                        body: 'Alarm set',
                        payload: 'watching you');

                    LocalNotifications.showScheduleNotificationstwo(
                        title: 'every two hour',
                        body: 'this is every two hour notification',
                        payload: 'this is every two hour data');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _updateReminderFrequency(String frequency) async {
    setState(() {
      selectedReminderFrequency = frequency;
      isReminderSet = true;
    });
    final box = await Hive.openBox<String>('reminder_data');
    box.put('reminderFrequency', frequency);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double progress = consumedAmount / dailyGoal;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      drawer: const NavBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color.fromARGB(156, 180, 130, 161),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Daily Goal: $dailyGoal ml',
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white),
                      ),
                      const SizedBox(height: 20.0),
                      AnimatedContainer(
                        width: 100,
                        height: 100,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: CircularProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.white,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                          strokeWidth: 10.0,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Consumed: $consumedAmount ml',
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showChoiceChips = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(156, 180, 130, 161),
                  ),
                  child: const Text('Drink Water',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                const SizedBox(height: 20.0),
                if (showChoiceChips)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int quantity in [50, 100, 150, 200, 250, 300, 350])
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ChoiceChip(
                              label: Text('$quantity ml'),
                              selected: selectedQuantity == quantity,
                              selectedColor:
                                  const Color.fromARGB(156, 175, 90, 141),
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedQuantity = selected ? quantity : 0;
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    _updateConsumedAmount(selectedQuantity);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(156, 180, 130, 161),
                  ),
                  child: const Text('Update Consumption',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return DailyConsumptionScreen();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(156, 180, 130, 161),
                    ),
                    child: const Text(
                      'View Consumption History',
                      style: TextStyle(fontSize: 18),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(156, 180, 130, 161),
                      ),
                      width: 100,
                      height: 100,
                      child: IconButton(
                        onPressed: () {
                          if (!isReminderSet) {
                            _showReminderOptionsDialog();
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Existing Reminder'),
                                  content: const Text(
                                      'You already have a reminder set.'),
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
                          }
                        },
                        icon: const Icon(
                          Icons.alarm,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    ),
                    Text(
                      'set alarm',
                      style: MyTextStyles.bodyTextStyle(20),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (isReminderSet)
                      Row(
                        children: [
                          const SizedBox(
                            width: 80,
                          ),
                          Text(
                            'Reminder:$selectedReminderFrequency',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {
                                LocalNotifications.cancelAll();
                                setState(() {
                                  isReminderSet = false;
                                  selectedReminderFrequency = '';
                                });
                              },
                              icon: const Icon(Icons.cancel))
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
