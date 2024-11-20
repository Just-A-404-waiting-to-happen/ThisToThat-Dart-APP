// Elbaraa Abdalla
class TimeConverter {
  // Map of capitals and their UTC offsets
  final Map<String, int> cities = {
    'Local': 0,

    // Europe
    'London': 0, // UK
    'Paris': 1, // France
    'Berlin': 1, // Germany
    'Rome': 1, // Italy
    'Madrid': 1, // Spain
    'Amsterdam': 1, // Netherlands
    'Brussels': 1, // Belgium
    'Stockholm': 1, // Sweden
    'Oslo': 1, // Norway
    'Copenhagen': 1, // Denmark
    'Vienna': 1, // Austria
    'Moscow': 3, // Russia
    'Athens': 2, // Greece
    'Warsaw': 1, // Poland
    'Lisbon': 0, // Portugal
    'Dublin': 0, // Ireland
    'Reykjavik': 0, // Iceland
    'Helsinki': 2, // Finland
    'Budapest': 1, // Hungary
    'Prague': 1, // Czech Republic
    'Bucharest': 2, // Romania
    'Sofia': 2, // Bulgaria
    'Belgrade': 1, // Serbia
    'Zagreb': 1, // Croatia
    'Kiev': 2, // Ukraine
    'Riga': 2, // Latvia
    'Vilnius': 2, // Lithuania
    'Tallinn': 2, // Estonia
    'Minsk': 3, // Belarus
    'Chisinau': 2, // Moldova

    // Asia
    'Tokyo': 9, // Japan
    'Beijing': 8, // China
    'Singapore': 8, // Singapore
    'Bangkok': 7, // Thailand
    'Dubai': 4, // UAE
    'Seoul': 9, // South Korea
    'Manila': 8, // Philippines
    'Jakarta': 7, // Indonesia
    'Kuala_Lumpur': 8, // Malaysia
    'Hong_Kong': 8, // Hong Kong
    'Taipei': 8, // Taiwan
    'Hanoi': 7, // Vietnam
    'New_Delhi': 5, // India
    'Mumbai': 5, // India
    'Karachi': 5, // Pakistan
    'Dhaka': 6, // Bangladesh
    'Colombo': 5, // Sri Lanka
    'Kathmandu': 5, // Nepal
    'Almaty': 6, // Kazakhstan
    'Tashkent': 5, // Uzbekistan
    'Kabul': 4, // Afghanistan
    'Tehran': 3, // Iran
    'Baghdad': 3, // Iraq
    'Riyadh': 3, // Saudi Arabia
    'Muscat': 4, // Oman
    'Doha': 3, // Qatar
    'Kuwait_City': 3, // Kuwait
    'Manama': 3, // Bahrain
    'Ashgabat': 5, // Turkmenistan
    'Dushanbe': 5, // Tajikistan
    'Bishkek': 6, // Kyrgyzstan
    'Yangon': 6, // Myanmar
    'Phnom_Penh': 7, // Cambodia
    'Vientiane': 7, // Laos
    'Ulaanbaatar': 8, // Mongolia

    // Americas
    'New_York': -5, // USA East
    'Los_Angeles': -8, // USA West
    'Chicago': -6, // USA Central
    'Toronto': -5, // Canada
    'Vancouver': -8, // Canada
    'Mexico_City': -6, // Mexico
    'Sao_Paulo': -3, // Brazil
    'Rio_de_Janeiro': -3, // Brazil
    'Buenos_Aires': -3, // Argentina
    'Lima': -5, // Peru
    'Bogota': -5, // Colombia
    'Santiago': -4, // Chile
    'Caracas': -4, // Venezuela
    'Montreal': -5, // Canada
    'Ottawa': -5, // Canada
    'Edmonton': -7, // Canada
    'Calgary': -7, // Canada
    'Winnipeg': -6, // Canada
    'Halifax': -4, // Canada
    'Kodiak': -9, // USA
    'Honolulu': -10, // USA
    'Pago_Pago': -11, // Samoa
    'Adak': -10, // USA
    'Alofi': -11, // Niue
    'Midway': -11, // USA
    'San_Francisco': -8, // USA
    'Seattle': -8, // USA
    'Denver': -7, // USA
    'Phoenix': -7, // USA
    'Houston': -6, // USA
    'Miami': -5, // USA
    'Boston': -5, // USA
    'Atlanta': -5, // USA
    'Washington_DC': -5, // USA
    'Philadelphia': -5, // USA
    'Dallas': -6, // USA
    'Havana': -5, // Cuba
    'Panama_City': -5, // Panama
    'Guatemala_City': -6, // Guatemala
    'San_Jose': -6, // Costa Rica
    'Managua': -6, // Nicaragua
    'San_Salvador': -6, // El Salvador
    'Tegucigalpa': -6, // Honduras
    'Belize_City': -6, // Belize
    'Quito': -5, // Ecuador
    'La_Paz': -4, // Bolivia
    'Asuncion': -4, // Paraguay
    'Montevideo': -3, // Uruguay
    'Georgetown': -4, // Guyana
    'Paramaribo': -3, // Suriname
    'Cayenne': -3, // French Guiana

    // Africa
    'Cairo': 2, // Egypt
    'Lagos': 1, // Nigeria
    'Nairobi': 3, // Kenya
    'Johannesburg': 2, // South Africa
    'Casablanca': 1, // Morocco
    'Accra': 0, // Ghana
    'Addis_Ababa': 3, // Ethiopia
    'Dakar': 0, // Senegal
    'Cape_Town': 2, // South Africa
    'Durban': 2, // South Africa
    'Pretoria': 2, // South Africa
    'Tunis': 1, // Tunisia
    'Algiers': 1, // Algeria
    'Tripoli': 2, // Libya
    'Khartoum': 2, // Sudan
    'Djibouti': 3, // Djibouti
    'Mogadishu': 3, // Somalia
    'Kampala': 3, // Uganda
    'Dar_es_Salaam': 3, // Tanzania
    'Lusaka': 2, // Zambia
    'Harare': 2, // Zimbabwe
    'Maputo': 2, // Mozambique
    'Luanda': 1, // Angola
    'Kinshasa': 1, // DR Congo
    'Brazzaville': 1, // Republic of Congo
    'Libreville': 1, // Gabon
    'Yaounde': 1, // Cameroon
    'Abuja': 1, // Nigeria
    'Port_Louis': 4, // Mauritius
    'Antananarivo': 3, // Madagascar

    // Oceania
    'Sydney': 10, // Australia
    'Melbourne': 10, // Australia
    'Brisbane': 10, // Australia
    'Perth': 8, // Australia
    'Adelaide': 9, // Australia
    'Darwin': 9, // Australia
    'Hobart': 10, // Australia
    'Canberra': 10, // Australia
    'Auckland': 12, // New Zealand
    'Wellington': 12, // New Zealand
    'Christchurch': 12, // New Zealand
    'Port_Moresby': 10, // Papua New Guinea
    'Suva': 12, // Fiji
    'Noumea': 11, // New Caledonia
    'Port_Vila': 11, // Vanuatu
    'Honiara': 11, // Solomon Islands
    'Apia': 13, // Samoa
    'Nuku_alofa': 13, // Tonga
    'Tarawa': 12, // Kiribati
    'Majuro': 12, // Marshall Islands

    // Other
    'Kiritimati': 14, // Kiribati
  };

  // Get local time
  String getLocalTime() {
    DateTime now = DateTime.now();
    return '${pad(now.hour)}:${pad(now.minute)}:${pad(now.second)}';
  }

  // Get time in specific city
  String getTimeIn(String city) {
    if (!cities.containsKey(city)) return "City not found";
    // Get current UTC time and add city's offset
    DateTime now = DateTime.now().toUtc();
    DateTime cityTime = now.add(Duration(hours: cities[city]!));

    return '${pad(cityTime.hour)}:${pad(cityTime.minute)}:${pad(cityTime.second)}';
  }

  // Get time difference between cities
  String getTimeDifference(String fromCity, String toCity) {
    // Checks if the input is valid
    if (!cities.containsKey(fromCity) || !cities.containsKey(toCity)) {
      return "Invalid city";
    }

    int difference = cities[toCity]! - cities[fromCity]!;
    bool nextDay = false;

    DateTime now = DateTime.now().toUtc();
    DateTime fromTime = now.add(Duration(hours: cities[fromCity]!));
    DateTime toTime = now.add(Duration(hours: cities[toCity]!));

    if (toTime.day > fromTime.day) {
      nextDay = true;
    }

    return '${difference >= 0 ? "+" : ""}$difference${nextDay ? " Next Day" : ""}';
  }

  String pad(int number) {
    return number.toString().padLeft(2, '0');
  }
}

// void main() {
//     TimeConverter converter = TimeConverter();

//     // Test 1: Get local time
//     print('Local Time');
//     print('Local time: ${converter.getLocalTime()}');
//     print('');

//     // Test 2: Get time in specific cities
//     print('Time in specific cities');
//     print('Tokyo: ${converter.getTimeIn("Tokyo")}');
//     print('New_York: ${converter.getTimeIn("New_York")}');
//     print('London: ${converter.getTimeIn("London")}');
//     print('Dubai: ${converter.getTimeIn("Dubai")}');
//     print('Pago_Pago: ${converter.getTimeIn("Pago_Pago")}');
//     print('Kiritimati: ${converter.getTimeIn("Kiritimati")}');
//     print('');

//     // Test 3: Test invalid city
//     print('Invalid city');
//     print('Invalid city test: ${converter.getTimeIn("FakeCity")}');
//     print('');

//     // Test 4: Time differences between cities
//     print('Time difference between cities');
//     //large time differences (should show next day)
//     print('Tokyo → New_York: ${converter.getTimeDifference("Tokyo", "New_York")}');
//     print('New_York → Tokyo: ${converter.getTimeDifference("New_York", "Tokyo")}');
//     //smaller time differences
//     print('London → Paris: ${converter.getTimeDifference("London", "Paris")}');
//     print('Dubai → Singapore: ${converter.getTimeDifference("Dubai", "Singapore")}');
//     //cities in same timezone
//     print('Paris → Berlin: ${converter.getTimeDifference("Paris", "Berlin")}');
//     //invalid cities
//     print('Invalid cities: ${converter.getTimeDifference("FakeCity", "Tokyo")}');
//     //extreme time differences
//     print('Pago_Pago → Kiritimati: ${converter.getTimeDifference("Pago_Pago", "Kiritimati")}');
//     print('Kiritimati → Pago_Pago: ${converter.getTimeDifference("Kiritimati", "Pago_Pago")}');
// }
