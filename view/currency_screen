import 'package:flutter/material.dart';
import 'package:myapp/models/currencey_manager.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final TextEditingController _inputController = TextEditingController();
  String fromCurrInput = "USD";
  String toCurInput = "EUR";
  String result = "";
  bool dirctionFlag = true;
  CurrencyManager currencyManager = CurrencyManager();
  List<String> codeList = ["USD", "EUR", "JPY"]; // add more countries

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Currency Converter",
          style:
              TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: const Color.fromRGBO(96, 125, 139, 1),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Field
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
                  labelText: "Amount",
                ),
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
                    value: fromCurrInput,
                    onChanged: (value) {
                      setState(() {
                        fromCurrInput = value!;
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
                  child: IconButton(
                    icon: Icon(
                      dirctionFlag ? Icons.arrow_forward : Icons.arrow_back,
                    ),
                    onPressed: () {
                      setState(() {
                        dirctionFlag = !dirctionFlag;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(155, 255, 255, 255),
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      value: toCurInput,
                      onChanged: (value) {
                        setState(() {
                          toCurInput = value!;
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

            ElevatedButton(
              //check selected from currency

              onPressed: () {
                double fromAmount =
                    double.tryParse(_inputController.text) ?? 0.0;
                String fromCurrency = dirctionFlag ? fromCurrInput : toCurInput;
                String toCurrency = !dirctionFlag ? fromCurrInput : toCurInput;
                debugPrint('Convert Button Pressed');
                debugPrint('From: $fromCurrency to: $toCurrency');

                debugPrint('From Amount: $fromAmount');

                if (fromCurrency == "USD") {
                  setState(() {
                    result = currencyManager.dollarTo(fromAmount, toCurrency);
                  });
                } else {
                  setState(() {
                    result = currencyManager.fromTo(
                        fromAmount, fromCurrency, toCurrency);
                  });
                }

                debugPrint("Result: $result");
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
                "Amount: $result",
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ],
        ),
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
