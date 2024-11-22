// lib/models/base_converter_model.dart
class BaseConverterModel {
  // [Previous BaseConverterModel implementation remains the same...]
  // Only uppercase letters
  // ignore: constant_identifier_names
  static const String DIGIT_CHARS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  // ignore: constant_identifier_names
  static const int MAX_BASE = 36; // Maximum base is 36 (0-9, A-Z)

  String inputNumber;
  int currentBase;
  int targetBase;
  String? result;
  String? error;

  BaseConverterModel({
    this.inputNumber = "",
    this.currentBase = 10,
    this.targetBase = 2,
    this.result,
    this.error,
  });

  // [Rest of the BaseConverterModel implementation...]
  bool isValidInput() {
    if (inputNumber.isEmpty) return false;

    // Special case for hex - allow both cases for A-F
    if (currentBase == 16) {
      return inputNumber.split('').every((char) {
        return RegExp(r'^[0-9A-Fa-f]$').hasMatch(char);
      });
    }

    // For all other bases - only allow uppercase
    return inputNumber.split('').every((char) {
      return DIGIT_CHARS.contains(char) && _getDigitValue(char) < currentBase;
    });
  }

  String convert() {
    try {
      if (!isValidInput()) {
        throw FormatException('Invalid input for base $currentBase');
      }
      BigInt decimal = _toDecimal();
      return _fromDecimal(decimal);
    } catch (e) {
      throw FormatException('Conversion error: $e');
    }
  }

  BigInt _toDecimal() {
    BigInt result = BigInt.zero;

    for (int i = 0; i < inputNumber.length; i++) {
      int digitValue = _getDigitValue(inputNumber[i]);
      result = result * BigInt.from(currentBase) + BigInt.from(digitValue);
    }
    return result;
  }

  String _fromDecimal(BigInt decimal) {
    if (decimal == BigInt.zero) return "0";
    String result = "";
    BigInt base = BigInt.from(targetBase);

    while (decimal > BigInt.zero) {
      int remainder = (decimal % base).toInt();
      result = DIGIT_CHARS[remainder] + result;
      decimal = decimal ~/ base;
    }
    return result;
  }

  int _getDigitValue(String char) {
    // Handle numbers
    if (RegExp(r'[0-9]').hasMatch(char)) {
      return int.parse(char);
    }

    // Handle hex special case
    if (currentBase == 16) {
      char = char.toUpperCase();
      if (RegExp(r'[A-F]').hasMatch(char)) {
        return char.codeUnitAt(0) - 'A'.codeUnitAt(0) + 10;
      }
    }
    // Handle other bases (uppercase only)
    else if (RegExp(r'[A-Z]').hasMatch(char)) {
      return char.codeUnitAt(0) - 'A'.codeUnitAt(0) + 10;
    }

    return -1;
  }

  static List<int> get supportedBases {
    List<int> common = [2, 8, 10, 16]; // Common bases first
    List<int> others = List.generate(MAX_BASE - 1, (index) => index + 2)
        .where((base) => !common.contains(base))
        .toList();
    return [...common, ...others];
  }

  static String getValidDigitsForBase(int base) {
    if (base == 16) {
      return "0-9, A-F (or a-f)";
    }
    if (base > 10) {
      String digits = DIGIT_CHARS.substring(0, base);
      return "0-9, ${digits[10]}-${digits[base - 1]} (uppercase only)";
    }
    return DIGIT_CHARS.substring(0, base);
  }

  static String getBaseName(int base) {
    switch (base) {
      case 2:
        return "Binary";
      case 8:
        return "Octal";
      case 10:
        return "Decimal";
      case 16:
        return "Hexadecimal";
      default:
        return "Base-$base";
    }
  }

  String getInputErrorMessage() {
    if (currentBase == 16) {
      return "Please enter only digits 0-9 and letters A-F (case insensitive)";
    }
    if (currentBase > 10) {
      String maxLetter = DIGIT_CHARS[currentBase - 1];
      return "Please enter only digits 0-9 and uppercase letters A-$maxLetter";
    }
    return "Please enter only digits 0-${currentBase - 1}";
  }
}

// void main() {
//   // Example 1: Convert decimal to binary
//   try {
//     var decToBin =
//         BaseConverterModel(inputNumber: "42", currentBase: 10, targetBase: 2);
//     print('Decimal (${decToBin.inputNumber}) to Binary: ${decToBin.convert()}');
//   } catch (e) {
//     print('Error: $e');
//   }

//   // Example 2: Convert hexadecimal to decimal
//   try {
//     var hexToDec =
//         BaseConverterModel(inputNumber: "2A", currentBase: 16, targetBase: 10);
//     print(
//         'Hexadecimal (${hexToDec.inputNumber}) to Decimal: ${hexToDec.convert()}');
//   } catch (e) {
//     print('Error: $e');
//   }

//   // Example 3: Convert binary to hexadecimal
//   try {
//     var binToHex = BaseConverterModel(
//         inputNumber: "101010", currentBase: 2, targetBase: 16);
//     print(
//         'Binary (${binToHex.inputNumber}) to Hexadecimal: ${binToHex.convert()}');
//   } catch (e) {
//     print('Error: $e');
//   }

//   // Example 4: Test error handling with invalid input
//   try {
//     var invalidInput = BaseConverterModel(
//         inputNumber: "12G", // Invalid for decimal
//         currentBase: 10,
//         targetBase: 2);
//     print('Invalid input test: ${invalidInput.convert()}');
//   } catch (e) {
//     print('Expected error: $e');
//   }

//   // Example 5: Convert between unusual bases (base-5 to base-7)
//   try {
//     var unusualBases =
//         BaseConverterModel(inputNumber: "123", currentBase: 5, targetBase: 7);
//     print(
//         'Base-5 (${unusualBases.inputNumber}) to Base-7: ${unusualBases.convert()}');
//   } catch (e) {
//     print('Error: $e');
//   }

//   // Print supported bases
//   print('\nSupported bases: ${BaseConverterModel.supportedBases}');
//   print(
//       'Valid digits for base 16: ${BaseConverterModel.getValidDigitsForBase(16)}');
// }
