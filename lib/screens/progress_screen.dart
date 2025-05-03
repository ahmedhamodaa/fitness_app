import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, int> _workoutData = {
    DateTime.now().subtract(const Duration(days: 5)): 1,
    DateTime.now().subtract(const Duration(days: 4)): 2,
    DateTime.now().subtract(const Duration(days: 3)): 3,
    DateTime.now().subtract(const Duration(days: 2)): 1,
    DateTime.now().subtract(const Duration(days: 1)): 2,
    DateTime.now(): 3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Weekly Progress',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 100,
                        lineHeight: 20.0,
                        percent: 0.7,
                        center: const Text("70%"),
                        progressColor: Colors.green,
                      ),
                      const SizedBox(height: 10),
                      const Text('4 of 5 workouts completed this week'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Workout Calendar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TableCalendar(
                        firstDay: DateTime.now().subtract(
                          const Duration(days: 365),
                        ),
                        lastDay: DateTime.now().add(const Duration(days: 365)),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        onFormatChanged: (format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                        eventLoader: (day) {
                          return _workoutData[day] != null
                              ? [_workoutData[day]!]
                              : [];
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
