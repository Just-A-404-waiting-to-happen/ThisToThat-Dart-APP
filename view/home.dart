// Suggested code may be subject to a license. Learn more: ~LicenseLog:2850964889.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1230424322.
import 'package:flutter/material.dart';
import 'package:myapp/controllers/base_controler.dart';
import 'package:myapp/my_button.dart';
import 'package:myapp/views/base_screen.dart';
import 'package:myapp/views/currency_screen.dart';
import 'package:myapp/views/time_screen.dart';
import 'package:myapp/views/unit_screen.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255)),
        title: const Text("This to That"),
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              MyButton(
                text: "Base",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (_) => BaseConverterController(),
                        child: const BaseConverterPage(),
                      ),
                    ),
                  );
                }, // Do nothing for now
                color: const Color.fromARGB(255, 81, 200, 255),
              ),
              const SizedBox(height: 16),
              MyButton(
                text: "Units",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UnitScreen()),
                  );
                }, // Do nothing for now
                color: const Color.fromARGB(255, 67, 164, 208),
              ),
              const SizedBox(height: 16),
              MyButton(
                text: "Time",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TimeScreen()),
                  );
                }, // Do nothing for now
                color: const Color.fromARGB(255, 53, 122, 154),
              ),
              const SizedBox(height: 16),
              MyButton(
                  text: "Currency",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CurrencyScreen()),
                    );
                  },
                  color: const Color.fromARGB(255, 96, 125, 139))
            ],
          ),
        ),
      ),
    );
  }
}
