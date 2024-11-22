import 'package:flutter/material.dart';
import 'package:myapp/models/time_manager.dart';
import 'dart:async';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  TimeConverter timeManager = TimeConverter();
  String _selectedFromCity = "Phoenix";
  String _selectedToCity = "Tokyo";
  String _displayLocalTime = "";
  String _displayToTime = "";
  List<String> codeList = [];

  @override
  void initState() {
    super.initState();
    // Get all cities from the map
    // Get all cities and sort them
    codeList.addAll(timeManager.cities.keys
        // Remove Local from the rest
        .toList()
      ..sort());
    updateTime();
    // Update time every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          updateTime();
        });
      }
    });
  }

  void updateTime() {
    _displayLocalTime = timeManager.getTimeIn(_selectedFromCity);
    _displayToTime = timeManager.getTimeIn(_selectedToCity);
  }

  String getTimeDifferenceWithDay() {
    String difference =
        timeManager.getTimeDifference(_selectedFromCity, _selectedToCity);
    int diff = int.parse(difference.split(" ")[0]); // Get the number part

    if (diff < 0) {
      return "$difference (Previous Day)";
    }
    return difference;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Converter"),
      ),
      body: Container(
        color: const Color.fromARGB(255, 96, 125, 139),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Local time display
            Container(
              color: const Color.fromARGB(154, 255, 255, 255),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Local Time: $_displayLocalTime",
                style: const TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(height: 16),
            // Dropdown Menus
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(155, 255, 255, 255),
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      value: _selectedFromCity,
                      onChanged: (value) {
                        setState(() {
                          _selectedFromCity = value!;
                          updateTime();
                        });
                      },
                      items: codeList
                          .map((code) => DropdownMenuItem(
                                value: code,
                                child: Text(code,
                                    style: const TextStyle(fontSize: 20)),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromARGB(89, 255, 255, 255),
                  padding: const EdgeInsets.all(16.0),
                  child: const Icon(
                    Icons.arrow_forward,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(155, 255, 255, 255),
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      value: _selectedToCity,
                      onChanged: (value) {
                        setState(() {
                          _selectedToCity = value!;
                          updateTime();
                        });
                      },
                      items: codeList
                          .map((code) => DropdownMenuItem(
                                value: code,
                                child: Text(
                                  code,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            // Selected city time
            Container(
              color: const Color.fromARGB(154, 255, 255, 255),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "$_selectedToCity Time: $_displayToTime",
                style: const TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(height: 16),
            // Time difference
            Container(
              color: const Color.fromARGB(154, 255, 255, 255),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Time Difference: ${getTimeDifferenceWithDay()}",
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
