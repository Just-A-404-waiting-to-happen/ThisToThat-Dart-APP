import 'package:flutter/material.dart';
import 'package:myapp/models/unit_manager.dart';

class UnitScreen extends StatefulWidget {
  const UnitScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UnitScreenState createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  final TextEditingController _inputController = TextEditingController();
  String unitFlag = "Inches to Bananas";
  String input = "00";
  String result = "";

  UnitConverter currencyManager = UnitConverter();
  List<String> codeList = []; // add more countries

  void updateCodelist() {
    codeList = currencyManager.getUnitOptionsList();
  }

  @override
  Widget build(BuildContext context) {
    updateCodelist();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Unit Converter",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: const Color.fromRGBO(96, 125, 139, 1),
        padding: const EdgeInsets.all(16.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // Input Field
          Expanded(
            child: Container(
              color: const Color.fromARGB(155, 255, 255, 255),
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                value: unitFlag,
                onChanged: (value) {
                  setState(() {
                    unitFlag = value!;
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
          ),
          const SizedBox(height: 10),
          // Conversion Button
          Container(
            color: const Color.fromARGB(179, 255, 255, 255),
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              //: Colors.white,
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: "Input",
              ),
              style: const TextStyle(fontSize: 28),
            ),
          ),
          const SizedBox(height: 16),
          // Dropdown Menus for Selection
          ElevatedButton(
            //check selected from

            onPressed: () {
              setState(() {
                result = currencyManager
                    .convertUnit(unitFlag, double.parse(_inputController.text))
                    .toString();
              });
            },

            child: const Text(
              "Convert",
              style: TextStyle(
                  fontSize: 60, color: Color.fromARGB(255, 26, 95, 68)),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            color: const Color.fromARGB(154, 255, 255, 255),
            padding: const EdgeInsets.all(16.0), // Output Field
            child: Text(
              result,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ]),
      ),
    );
  }

  // void _convertCurrency() {
  //   // Simulate currency conversion logic
  //   double inputAmount = double.tryParse(_inputController.text) ?? 0.0;
  //   setState(() {
  //     _conversionResult =
  //         "$inputAmount $_selectedFromCurrency -> $_selectedToCurrency";
  //   });
  // }
}
