import 'package:flutter/material.dart';
import 'package:myapp/controllers/base_controler.dart';
import 'package:provider/provider.dart';

class BaseConverterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BaseConverterController(),
      child: const BaseConverterPage(),
    );
  }
}

class BaseConverterPage extends StatelessWidget {
  // Define color constants
  static const Color backgroundBlue = Color(0xFF1a2639); // Dark blue background
  static const Color surfaceBlue =
      Color(0xFF243B55); // Slightly lighter blue for elements
  static const Color accentBlue = Color(0xFF4A90E2);

  const BaseConverterPage({super.key}); // Bright blue for interactive elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      appBar: AppBar(
        title: const Text('Base Converter'),
        elevation: 0,
        backgroundColor: surfaceBlue,
      ),
      body: Consumer<BaseConverterController>(
        builder: (context, controller, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildBaseSelector(
                  context,
                  'From Base:',
                  controller.currentBase,
                  (value) => controller.setCurrentBase(value),
                ),
                const SizedBox(height: 8),
                _buildInputField(context, controller),
                const SizedBox(height: 16),
                _buildSwapButton(context, controller),
                const SizedBox(height: 16),
                _buildBaseSelector(
                  context,
                  'To Base:',
                  controller.targetBase,
                  (value) => controller.setTargetBase(value),
                ),
                const SizedBox(height: 8),
                _buildResultField(context, controller),
                if (controller.error != null) ...[
                  const SizedBox(height: 8),
                  _buildErrorText(controller.error!),
                ],
                const SizedBox(height: 16),
                _buildValidDigitsInfo(context, controller),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBaseSelector(
    BuildContext context,
    String label,
    int currentValue,
    Function(int) onChanged,
  ) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<int>(
            value: currentValue,
            dropdownColor: surfaceBlue,
            style: TextStyle(color: Colors.white),
            items: context
                .read<BaseConverterController>()
                .supportedBases
                .map((base) => DropdownMenuItem(
                      value: base,
                      child: Text('Base $base'),
                    ))
                .toList(),
            onChanged: (value) => onChanged(value!),
            decoration: InputDecoration(
              filled: true,
              fillColor: surfaceBlue,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white24),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white24),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(
      BuildContext context, BaseConverterController controller) {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Input Number',
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: surfaceBlue,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: accentBlue),
        ),
        hintText: 'Enter a number in base ${controller.currentBase}',
        hintStyle: TextStyle(color: Colors.white38),
      ),
      onChanged: controller.setInputNumber,
    );
  }

  Widget _buildSwapButton(
      BuildContext context, BaseConverterController controller) {
    return ElevatedButton.icon(
      onPressed: controller.swapBases,
      icon: Icon(Icons.swap_vert),
      label: Text('Swap Bases'),
      style: ElevatedButton.styleFrom(
        backgroundColor: accentBlue,
        padding: EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildResultField(
      BuildContext context, BaseConverterController controller) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceBlue,
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Result (Base ${controller.targetBase}):',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 8),
          SelectableText(
            controller.result ?? 'No result',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorText(String error) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.shade900,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        error,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildValidDigitsInfo(
      BuildContext context, BaseConverterController controller) {
    String validDigits =
        controller.getValidDigitsForBase(controller.currentBase);
    return Card(
      color: surfaceBlue,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Valid digits for base ${controller.currentBase}:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              validDigits,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
