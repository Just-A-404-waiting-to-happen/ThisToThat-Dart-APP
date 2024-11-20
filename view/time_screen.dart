import 'package:flutter/material.dart';
import 'package:myapp/models/time_manager.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  TimeConverter timeManager = TimeConverter();
  String _selectedFromCity = "Local";
  String _selectedToCity = "Tokyo";
  String _displayToTime = "Tokyo";
  String _displayFromTime = "Local";

  List<String> codeList = [
    "Local",
    "Phoenix",
    "Pago_Pago",
    "Tokyo",
    "Cairo",
    "Kiritimati"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Converter"),
        //backgroundColor: Colors.black,
      ),
      body: Container(
        color: const Color.fromARGB(255, 96, 125, 139),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Field
            Container(
              color: const Color.fromARGB(154, 255, 255, 255),
              padding: const EdgeInsets.all(16.0), // Output Field
              child: Text(
                "Local: $_displayFromTime",
                style: const TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(height: 16),
            // Dropdown Menus for Currency Selection
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
                        _displayFromTime =
                            timeManager.getTimeIn(_selectedFromCity);
                      });
                    },
                    items: codeList
                        .map((code) => DropdownMenuItem(
                              value: code,
                              child: Text(code,
                                  style: const TextStyle(fontSize: 28)),
                            ))
                        .toList(),
                  ),
                )),
                Container(
                   color: const Color.fromARGB(89, 255, 255, 255),
                   padding: const EdgeInsets.all(16.0),
                   child: const Icon(
                        Icons.arrow_forward ,
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
                          _displayToTime =
                              timeManager.getTimeDifference( 
                              _selectedFromCity, _selectedToCity);
                        });
                      },
                      items: codeList
                          .map((code) => DropdownMenuItem(
                                value: code,
                                child: Text(
                                  code,
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            // Conversion Button

            const SizedBox(height: 10),
            Container(
              color: const Color.fromARGB(154, 255, 255, 255),
              padding: const EdgeInsets.all(16.0), // Output Field
              child: Text(
                "$_selectedToCity: $_displayToTime",
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
