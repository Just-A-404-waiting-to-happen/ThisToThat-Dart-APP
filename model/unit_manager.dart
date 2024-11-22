// Project: ClassConverter
// Purpose: this class defines a method to convert units of length, area
//          mass, volume and temperature to and from each other
// Author:  Joel Thomassee

// NOTES:
// I anticipate that the GUI will return two things, a string from a dropdown menu
// indicating what conversion is being done, i.e. "Inches to Bananas", and a value
// indicating the value of the current unit i.e. 3.0

// The convertUnit method will find the matching string and perform the proper
// conversion on the value, and output a double representign the original value in
// the unit specified by the string, i.e. convertUnit("Inches to Bananas", 7.0) will
// return 1.0, because the average banana is 7 inches long

class UnitConverter {
  // may add more methods like getInstruction and getValue depending on how GUI works
  List<String> getUnitOptionsList() {
    return [
      "Inches to Bananas",
      "Inches to Spaghetti",
      "Miles to Football Fields",
      "Pounds to Cheeseburgers",
      "Gallons to Low Flow Toilet Flushes",
      "Gallons to Standard Flow Toilet Flushes",
      "Inches to Centimeters",
      "Centimeters to Inches",
      "Feet to Centimeters",
      "Centimeters to Feet",
      "Yards to Meters",
      "Meters to Yards",
      "Miles to Kilometers",
      "Kilometers to Miles",
      "Square Inches to Square Centimeters",
      "Square Centimeters to Square Inches",
      "Square Feet to Square Meters",
      "Square Meters to Square Yards",
      "Square Yards to Square Meters",
      "Square Kilometers to Square Miles",
      "Square Miles to Square Kilometers",
      "Hectares to Acres",
      "Acres to Hectares",
      "Ounces to Grams",
      "Grams to Ounces",
      "Pounds to Kilograms",
      "Kilograms to Pounds",
      "Short Tons to Metric Tons",
      "Metric Tons to Short Tons",
      "Long Tons to Metric Tons",
      "Teaspoons to Milliliters",
      "Milliliters to Fluid Ounces",
      "Tablespoons to Milliliters",
      "Liters to Pints",
      "Liters to Quarts",
      "Liters to Gallons",
      "Gallons to Liters",
      "Cups to Liters",
      "Pints to Liters",
      "Cubic Meters to Cubic Feet",
      "Cubic Feet to Cubic Meters",
      "Cubic Yards to Cubic Meters",
      "Fahrenheit to Celsius",
      "Celsius to Fahrenheit",
      "Meters Per Second to Kilometers Per Hour",
      "Meters Per Second to Miles Per Hour",
      "Meters Per Second to Feet Per Second",
      "Meters Per Second to Knots",
      "Kilometers Per Hour to Meters Per Second",
      "Kilometers Per Hour to Miles Per Hour",
      "Kilometers Per Hour to Feet Per Second",
      "Kilometers Per Hour to Knots",
      "Miles Per Hour to Meters Per Second",
      "Miles Per Hour to Kilometers Per Hour",
      "Miles Per Hour to Feet Per Second",
      "Miles Per Hour to Knots",
      "Feet Per Second to Meters Per Second",
      "Feet Per Second to Kilometers Per Hour",
      "Feet Per Second to Miles Per Hour",
      "Feet Per Second to Knots",
      "Knots to Meters Per Second",
      "Knots to Kilometers Per Hour",
      "Knots to Miles Per Hour",
      "Knots to Feet Per Second"
    ];
  }

  double convertUnit(String instructionString, double oldValue) {
    double newValue = 0.0;

    switch (instructionString) {
      // random
      case "Inches to Bananas":
        newValue = oldValue / 7.0;
      case "Inches to Spaghetti":
        newValue = oldValue / 11.0;
      case "Miles to Football Fields":
        newValue = oldValue / 0.056818;
      case "Pounds to Cheeseburgers":
        newValue = oldValue / 0.25;
      case "Gallons to Low Flow Toilet Flushes":
        newValue = oldValue / 1.6;
      case "Gallons to Standard Flow Toilet Flushes":
        newValue = oldValue / 7.0;

      // length units
      case "Inches to Centimeters":
        newValue = oldValue * 2.54;
      case "Centimeters to Inches":
        newValue = oldValue * 0.3937;
      case "Feet to Centimeters":
        newValue = oldValue * 30.4878;
      case "Centimeters to Feet":
        newValue = oldValue / 30.4878;
      case "Yards to Meters":
        newValue = oldValue * 0.9144028;
      case "Meters to Yards":
        newValue = oldValue / 0.9144028;
      case "Miles to Kilometers":
        newValue = oldValue * 1.6093419;
      case "Kilometers to Miles":
        newValue = oldValue * 0.621372;

      // area units
      case "Square Inches to Square Centimeters":
        newValue = oldValue * 6.4516;
      case "Square Centimeters to Square Inches":
        newValue = oldValue * 0.1550;
      case "Square Feet to Square Meters":
        newValue = oldValue * 0.0929;
      case "Square Meters to Square Yards":
        newValue = oldValue * 1.195986;
      case "Square Yards to Square Meters":
        newValue = oldValue * 0.83613;
      case "Square Kilometers to Square Miles":
        newValue = oldValue * 0.386101;
      case "Square Miles to Square Kilometers":
        newValue = oldValue * 2.589999;
      case "Hectares to Acres":
        newValue = oldValue * 2.471044;
      case "Acres to Hectares":
        newValue = oldValue * 0.404687;

      // weight units
      case "Ounces to Grams":
        newValue = oldValue * 28.3495;
      case "Grams to Ounces":
        newValue = oldValue * 0.03527396;
      case "Pounds to Kilograms":
        newValue = oldValue * 0.4535924;
      case "Kilograms to Pounds":
        newValue = oldValue * 2.2046223;
      case "Short Tons to Metric Tons":
        newValue = oldValue * 0.892857;
      case "Metric Tons to Short Tons":
        newValue = oldValue * 1.1200;
      case "Long Tons to Metric Tons":
        newValue = oldValue * 1.01605;

      // colume units
      case "Teaspoons to Milliliters":
        newValue = oldValue * 5;
      case "Milliliters to Fluid Ounces":
        newValue = oldValue * 0.0338147;
      case "Tablespoons to Milliliters":
        newValue = oldValue * 15;
      case "Liters to Pints":
        newValue = oldValue * 2.11342;
      case "Liters to Quarts":
        newValue = oldValue * 1.05671;
      case "Liters to Gallons":
        newValue = oldValue * 0.264178;
      case "Gallons to Liters":
        newValue = oldValue * 3.785332;
      case "Cups to Liters":
        newValue = oldValue * 0.23658;
      case "Pints to Liters":
        newValue = oldValue * 0.473167;
      case "Cubic Meters to Cubic Feet":
        newValue = oldValue * 35.3144;
      case "Cubic Feet to Cubic Meters":
        newValue = oldValue * 0.0283170;
      case "Cubic Yards to Cubic Meters":
        newValue = oldValue * 0.764559;

      // temp units
      case "Fahrenheit to Celsius":
        newValue = (oldValue - 32) * 5 / 9;
      case "Celsius to Fahrenheit":
        newValue = (oldValue * 9 / 5) + 32;

      // speed units
      case "Meters Per Second to Kilometers Per Hour":
        newValue = oldValue * 3.6;
      case "Meters Per Second to Miles Per Hour":
        newValue = oldValue * 2.23694;
      case "Meters Per Second to Feet Per Second":
        newValue = oldValue * 3.28084;
      case "Meters Per Second to Knots":
        newValue = oldValue * 1.94384;
      case "Kilometers Per Hour to Meters Per Second":
        newValue = oldValue * 0.277778;
      case "Kilometers Per Hour to Miles Per Hour":
        newValue = oldValue * 0.621371;
      case "Kilometers Per Hour to Feet Per Second":
        newValue = oldValue * 0.911344;
      case "Kilometers Per Hour to Knots":
        newValue = oldValue * 0.539957;
      case "Miles Per Hour to Meters Per Second":
        newValue = oldValue * 0.44704;
      case "Miles Per Hour to Kilometers Per Hour":
        newValue = oldValue * 1.60934;
      case "Miles Per Hour to Feet Per Second":
        newValue = oldValue * 1.46667;
      case "Miles Per Hour to Knots":
        newValue = oldValue * 0.868976;
      case "Feet Per Second to Meters Per Second":
        newValue = oldValue * 0.3048;
      case "Feet Per Second to Kilometers Per Hour":
        newValue = oldValue * 1.09728;
      case "Feet Per Second to Miles Per Hour":
        newValue = oldValue * 0.681818;
      case "Feet Per Second to Knots":
        newValue = oldValue * 0.592484;
      case "Knots to Meters Per Second":
        newValue = oldValue * 0.514444;
      case "Knots to Kilometers Per Hour":
        newValue = oldValue * 1.852;
      case "Knots to Miles Per Hour":
        newValue = oldValue * 1.15078;
      case "Knots to Feet Per Second":
        newValue = oldValue * 1.68781;

      // default should never be reached, GUI should only allow
      // for valid strings to be selected
      default:
        return 0.0;
    }

    // limits decimal points to 3 point precision
    return double.parse((newValue).toStringAsFixed(3));
  }
}

// void main() {
//   UnitConverter test = UnitConverter();
//   print(test.convertUnit("Inches to Bananas", 12)); // Example usage
//   print(test.convertUnit("Feet Per Second to Knots", 37.132)); // Example usage
// }
