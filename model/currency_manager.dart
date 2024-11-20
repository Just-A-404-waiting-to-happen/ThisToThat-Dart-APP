import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// void main() async {
//   print("Main");
//   CurrencyManager c = new CurrencyManager();
//   await c.updateTable();

//   //check rate for JPY
//   //print("post:${c.getRate("JPY")}");

//   print("10 USD to JPY = ${c.dollarTo(10.0, "JPY")}");
//   print("10 USD to EUR = ${c.dollarTo(10.0, "EUR")}");
//   print("10 USD to AUD = ${c.dollarTo(10.0, "AUD")}");
//   print("1527 JPY to USD = ${c.dollarFrom(1527, "JPY")}");

//   print("From(EUR) to To(JPY) = ${c.fromTo(9.22, "EUR", "JPY")}");
//   //c.printCodes();
// }

/* CurrenceyManager works with the table and could be renamed to controler. 
* It makes and updates the table rates. 
*/
class CurrencyManager {
  Map<String, Currency> currencies = CurrencyTable().returnMAP();
  Set<String> codes = {};

  CurrencyManager() {
    debugPrint("CurrencyManager");
    updateTable();
  }

  Future<void> updateTable() async {
    debugPrint("Updating Table");
    Map<String, dynamic> exchangeRates = await fetchExchangeRates();
    exchangeRates.forEach((code, rate) {
      if (currencies[code] != null) {
        currencies[code]?.setRate(rate.toDouble());
        currencies[code]?.setUpdated(true);
        codes.add(code);
        debugPrint('$code: $rate');
      } else {
        //debug print("$code Not USED");
      }
    });
    /*debug currency.printAllByUpdate(false);
    print("------------------------");
    currency.printAllByUpdate(true);*/
  }

  // API call to exchangerate-API
  Future<Map<String, dynamic>> fetchExchangeRates() async {
    final url = Uri.parse(
        'https://v6.exchangerate-api.com/v6/_PUT_YOUR_KEY_HERE_/latest/USD');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['conversion_rates'];
    } else {
      debugPrint('Failed to load exchange rates');
      return {}; // Return an empty map if there is an error
    }
  }

  Set<String> getCodes() {
    return codes;
  }

  String dollarTo(double dollars, String code) {
    Currency? c = currencies[code];
    double rate = c?.getRate() ?? 1.0;
    int decimalPrecision = c?.getDecimal() ?? 2;
    double converted = dollars * rate;
    //debug print("Debug $dollars * $rate = $converted");
    return converted.toStringAsFixed(decimalPrecision);
  }

  String dollarFrom(double dollars, String code) {
    Currency? c = currencies[code];
    double rate = c?.getRate() ?? 1.0;
    int decimalPrecision = c?.getDecimal() ?? 2;
    double converted = dollars / rate;
    //debug print("Debug $dollars * $rate = $converted");
    return converted.toStringAsFixed(decimalPrecision);
  }

  String fromTo(double dollars, String from, String to) {
    dollars = double.parse(dollarFrom(dollars, from));
    return dollarTo(dollars, to);
  }

  double getRate(String code) {
    return currencies[code]?.getRate() ?? 0.0;
  }
}

// a class obj to hold currency data.
class Currency {
  final String currencyCode;
  final String currencyName;
  final String country;
  double rate;
  int decimal;
  bool update;

  Currency(this.currencyCode, this.currencyName, this.country, this.rate,
      this.decimal, this.update);

  void setRate(double newRate) {
    rate = newRate;
  }

  void setUpdated(bool newUpdate) {
    update = newUpdate;
  }

  double getRate() {
    return rate;
  }

  String getCurrencyCode() {
    return currencyCode;
  }

  int getDecimal() {
    return decimal;
  }

  bool getUpdate() {
    return update;
  }

  Map<String, dynamic> toJson() => {
        "Currency Code": currencyCode,
        "Currency Name": currencyName,
        "Country": country,
        "Rate": rate,
      };

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
        json["Currency Code"],
        json["Currency Name"],
        json["Country"],
        (json["Rate"] ?? 0.0).toDouble(),
        (json["Decimal"] ?? 2),
        json["Updated"]);
  }
}

// Due to issues with file system permisions I've hard coded a few rates into a table
// basiclly just returns a map of listed currencey by code.
class CurrencyTable {
  //final Map<String, String> countryMap ={ GERMANY: curntry{Euro}
  //};
  final Map<String, Currency> currencies = {
    /*"USD": Currency("USD", "United States Dollar", "United States", 1.0),
    "EUR": Currency("EUR", "Euro", "European Union", 0.9),
    "JPY": Currency("JPY", "Japanese Yen", "Japan", 0.0)*/
    "AED": Currency("AED", "UAE Dirham", "United Arab Emirates", 0.0, 2, false),
    "AFN": Currency("AFN", "Afghan Afghani", "Afghanistan", 0.0, 2, false),
    "ALL": Currency("ALL", "Albanian Lek", "Albania", 0.0, 2, false),
    "AMD": Currency("AMD", "Armenian Dram", "Armenia", 0.0, 2, false),
    "ANG": Currency("ANG", "Netherlands Antillian Guilder",
        "Netherlands Antilles", 0.0, 2, false),
    "AOA": Currency("AOA", "Angolan Kwanza", "Angola", 0.0, 2, false),
    "ARS": Currency("ARS", "Argentine Peso", "Argentina", 0.0, 2, false),
    "AUD": Currency("AUD", "Australian Dollar", "Australia", 0.0, 2, false),
    "AWG": Currency("AWG", "Aruban Florin", "Aruba", 0.0, 2, false),
    "AZN": Currency("AZN", "Azerbaijani Manat", "Azerbaijan", 0.0, 2, false),
    "BAM": Currency("BAM", "Bosnia and Herzegovina Mark",
        "Bosnia and Herzegovina", 0.0, 2, false),
    "BBD": Currency("BBD", "Barbados Dollar", "Barbados", 0.0, 2, false),
    "BDT": Currency("BDT", "Bangladeshi Taka", "Bangladesh", 0.0, 2, false),
    "BGN": Currency("BGN", "Bulgarian Lev", "Bulgaria", 0.0, 2, false),
    "BHD": Currency("BHD", "Bahraini Dinar", "Bahrain", 0.0, 3, false),
    "BIF": Currency("BIF", "Burundian Franc", "Burundi", 0.0, 0, false),
    "BMD": Currency("BMD", "Bermudian Dollar", "Bermuda", 0.0, 2, false),
    "BND": Currency("BND", "Brunei Dollar", "Brunei", 0.0, 2, false),
    "BOB": Currency("BOB", "Bolivian Boliviano", "Bolivia", 0.0, 2, false),
    "BRL": Currency("BRL", "Brazilian Real", "Brazil", 0.0, 2, false),
    "BSD": Currency("BSD", "Bahamian Dollar", "Bahamas", 0.0, 2, false),
    "BTN": Currency("BTN", "Bhutanese Ngultrum", "Bhutan", 0.0, 2, false),
    "BWP": Currency("BWP", "Botswana Pula", "Botswana", 0.0, 2, false),
    "BYN": Currency("BYN", "Belarusian Ruble", "Belarus", 0.0, 2, false),
    "BZD": Currency("BZD", "Belize Dollar", "Belize", 0.0, 2, false),
    "CAD": Currency("CAD", "Canadian Dollar", "Canada", 0.0, 2, false),
    "CDF": Currency("CDF", "Congolese Franc",
        "Democratic Republic of the Congo", 0.0, 2, false),
    "CHF": Currency("CHF", "Swiss Franc", "Switzerland", 0.0, 2, false),
    "CLP": Currency("CLP", "Chilean Peso", "Chile", 0.0, 0, false),
    "CNY": Currency("CNY", "Chinese Renminbi", "China", 0.0, 2, false),
    "COP": Currency("COP", "Colombian Peso", "Colombia", 0.0, 2, false),
    "CRC": Currency("CRC", "Costa Rican Colon", "Costa Rica", 0.0, 2, false),
    "CUP": Currency("CUP", "Cuban Peso", "Cuba", 0.0, 2, false),
    "CVE": Currency("CVE", "Cape Verdean Escudo", "Cape Verde", 0.0, 2, false),
    "CZK": Currency("CZK", "Czech Koruna", "Czech Republic", 0.0, 2, false),
    "DJF": Currency("DJF", "Djiboutian Franc", "Djibouti", 0.0, 0, false),
    "DKK": Currency("DKK", "Danish Krone", "Denmark", 0.0, 2, false),
    "DOP":
        Currency("DOP", "Dominican Peso", "Dominican Republic", 0.0, 2, false),
    "DZD": Currency("DZD", "Algerian Dinar", "Algeria", 0.0, 2, false),
    "EGP": Currency("EGP", "Egyptian Pound", "Egypt", 0.0, 2, false),
    "ERN": Currency("ERN", "Eritrean Nakfa", "Eritrea", 0.0, 2, false),
    "ETB": Currency("ETB", "Ethiopian Birr", "Ethiopia", 0.0, 2, false),
    "EUR": Currency("EUR", "Euro", "European Union", 0.0, 2, false),
    "FJD": Currency("FJD", "Fiji Dollar", "Fiji", 0.0, 2, false),
    "FKP": Currency(
        "FKP", "Falkland Islands Pound", "Falkland Islands", 0.0, 2, false),
    "FOK": Currency("FOK", "Faroese Króna", "Faroe Islands", 0.0, 2, false),
    "GBP": Currency("GBP", "Pound Sterling", "United Kingdom", 0.0, 2, false),
    "GEL": Currency("GEL", "Georgian Lari", "Georgia", 0.0, 2, false),
    "GGP": Currency("GGP", "Guernsey Pound", "Guernsey", 0.0, 2, false),
    "GHS": Currency("GHS", "Ghanaian Cedi", "Ghana", 0.0, 2, false),
    "GIP": Currency("GIP", "Gibraltar Pound", "Gibraltar", 0.0, 2, false),
    "GMD": Currency("GMD", "Gambian Dalasi", "The Gambia", 0.0, 2, false),
    "GNF": Currency("GNF", "Guinean Franc", "Guinea", 0.0, 0, false),
    "GTQ": Currency("GTQ", "Guatemalan Quetzal", "Guatemala", 0.0, 2, false),
    "GYD": Currency("GYD", "Guyanese Dollar", "Guyana", 0.0, 2, false),
    "HKD": Currency("HKD", "Hong Kong Dollar", "Hong Kong", 0.0, 2, false),
    "HNL": Currency("HNL", "Honduran Lempira", "Honduras", 0.0, 2, false),
    "HRK": Currency("HRK", "Croatian Kuna", "Croatia", 0.0, 2, false),
    "HTG": Currency("HTG", "Haitian Gourde", "Haiti", 0.0, 2, false),
    "HUF": Currency("HUF", "Hungarian Forint", "Hungary", 0.0, 2, false),
    "IDR": Currency("IDR", "Indonesian Rupiah", "Indonesia", 0.0, 2, false),
    "ILS": Currency("ILS", "Israeli New Shekel", "Israel", 0.0, 2, false),
    "IMP": Currency("IMP", "Manx Pound", "Isle of Man", 0.0, 2, false),
    "INR": Currency("INR", "Indian Rupee", "India", 0.0, 2, false),
    "IQD": Currency("IQD", "Iraqi Dinar", "Iraq", 0.0, 3, false),
    "IRR": Currency("IRR", "Iranian Rial", "Iran", 0.0, 2, false),
    "ISK": Currency("ISK", "Icelandic Króna", "Iceland", 0.0, 0, false),
    "JEP": Currency("JEP", "Jersey Pound", "Jersey", 0.0, 2, false),
    "JMD": Currency("JMD", "Jamaican Dollar", "Jamaica", 0.0, 2, false),
    "JOD": Currency("JOD", "Jordanian Dinar", "Jordan", 0.0, 3, false),
    "JPY": Currency("JPY", "Japanese Yen", "Japan", 0.0, 0, false),
    "KES": Currency("KES", "Kenyan Shilling", "Kenya", 0.0, 2, false),
    "KGS": Currency("KGS", "Kyrgyzstani Som", "Kyrgyzstan", 0.0, 2, false),
    "KHR": Currency("KHR", "Cambodian Riel", "Cambodia", 0.0, 2, false),
    "KID": Currency("KID", "Kiribati Dollar", "Kiribati", 0.0, 2, false),
    "KMF": Currency("KMF", "Comorian Franc", "Comoros", 0.0, 0, false),
    "KRW": Currency("KRW", "South Korean Won", "South Korea", 0.0, 0, false),
    "KWD": Currency("KWD", "Kuwaiti Dinar", "Kuwait", 0.0, 3, false),
    "KYD": Currency(
        "KYD", "Cayman Islands Dollar", "Cayman Islands", 0.0, 2, false),
    "KZT": Currency("KZT", "Kazakhstani Tenge", "Kazakhstan", 0.0, 2, false),
    "LAK": Currency("LAK", "Lao Kip", "Laos", 0.0, 2, false),
    "LBP": Currency("LBP", "Lebanese Pound", "Lebanon", 0.0, 2, false),
    "LKR": Currency("LKR", "Sri Lanka Rupee", "Sri Lanka", 0.0, 2, false),
    "LRD": Currency("LRD", "Liberian Dollar", "Liberia", 0.0, 2, false),
    "LSL": Currency("LSL", "Lesotho Loti", "Lesotho", 0.0, 2, false),
    "LYD": Currency("LYD", "Libyan Dinar", "Libya", 0.0, 3, false),
    "MAD": Currency("MAD", "Moroccan Dirham", "Morocco", 0.0, 2, false),
    "MDL": Currency("MDL", "Moldovan Leu", "Moldova", 0.0, 2, false),
    "MGA": Currency("MGA", "Malagasy Ariary", "Madagascar", 0.0, 2, false),
    "MKD":
        Currency("MKD", "Macedonian Denar", "North Macedonia", 0.0, 2, false),
    "MMK": Currency("MMK", "Burmese Kyat", "Myanmar", 0.0, 2, false),
    "MNT": Currency("MNT", "Mongolian Tögrög", "Mongolia", 0.0, 2, false),
    "MOP": Currency("MOP", "Macanese Pataca", "Macau", 0.0, 2, false),
    "MRU": Currency("MRU", "Mauritanian Ouguiya", "Mauritania", 0.0, 2, false),
    "MUR": Currency("MUR", "Mauritian Rupee", "Mauritius", 0.0, 2, false),
    "MVR": Currency("MVR", "Maldivian Rufiyaa", "Maldives", 0.0, 2, false),
    "MWK": Currency("MWK", "Malawian Kwacha", "Malawi", 0.0, 2, false),
    "MXN": Currency("MXN", "Mexican Peso", "Mexico", 0.0, 2, false),
    "MYR": Currency("MYR", "Malaysian Ringgit", "Malaysia", 0.0, 2, false),
    "MZN": Currency("MZN", "Mozambican Metical", "Mozambique", 0.0, 2, false),
    "NAD": Currency("NAD", "Namibian Dollar", "Namibia", 0.0, 2, false),
    "NGN": Currency("NGN", "Nigerian Naira", "Nigeria", 0.0, 2, false),
    "NIO": Currency("NIO", "Nicaraguan Córdoba", "Nicaragua", 0.0, 2, false),
    "NOK": Currency("NOK", "Norwegian Krone", "Norway", 0.0, 2, false),
    "NPR": Currency("NPR", "Nepalese Rupee", "Nepal", 0.0, 2, false),
    "NZD": Currency("NZD", "New Zealand Dollar", "New Zealand", 0.0, 2, false),
    "OMR": Currency("OMR", "Omani Rial", "Oman", 0.0, 3, false),
    "PAB": Currency("PAB", "Panamanian Balboa", "Panama", 0.0, 2, false),
    "PEN": Currency("PEN", "Peruvian Sol", "Peru", 0.0, 2, false),
    "PGK": Currency(
        "PGK", "Papua New Guinean Kina", "Papua New Guinea", 0.0, 2, false),
    "PHP": Currency("PHP", "Philippine Peso", "Philippines", 0.0, 2, false),
    "PKR": Currency("PKR", "Pakistani Rupee", "Pakistan", 0.0, 2, false),
    "PLN": Currency("PLN", "Polish Złoty", "Poland", 0.0, 2, false),
    "PYG": Currency("PYG", "Paraguayan Guaraní", "Paraguay", 0.0, 0, false),
    "QAR": Currency("QAR", "Qatari Riyal", "Qatar", 0.0, 2, false),
    "RON": Currency("RON", "Romanian Leu", "Romania", 0.0, 2, false),
    "RSD": Currency("RSD", "Serbian Dinar", "Serbia", 0.0, 2, false),
    "RUB": Currency("RUB", "Russian Ruble", "Russia", 0.0, 2, false),
    "RWF": Currency("RWF", "Rwandan Franc", "Rwanda", 0.0, 0, false),
    "SAR": Currency("SAR", "Saudi Riyal", "Saudi Arabia", 0.0, 2, false),
    "SBD": Currency(
        "SBD", "Solomon Islands Dollar", "Solomon Islands", 0.0, 2, false),
    "SCR": Currency("SCR", "Seychellois Rupee", "Seychelles", 0.0, 2, false),
    "SDG": Currency("SDG", "Sudanese Pound", "Sudan", 0.0, 2, false),
    "SEK": Currency("SEK", "Swedish Krona", "Sweden", 0.0, 2, false),
    "SGD": Currency("SGD", "Singapore Dollar", "Singapore", 0.0, 2, false),
    "SHP": Currency("SHP", "Saint Helena Pound", "Saint Helena", 0.0, 2, false),
    "SLE":
        Currency("SLE", "Sierra Leonean Leone", "Sierra Leone", 0.0, 2, false),
    "SOS": Currency("SOS", "Somali Shilling", "Somalia", 0.0, 2, false),
    "SRD": Currency("SRD", "Surinamese Dollar", "Suriname", 0.0, 2, false),
    "SSP":
        Currency("SSP", "South Sudanese Pound", "South Sudan", 0.0, 2, false),
    "STN": Currency("STN", "São Tomé and Príncipe Dobra",
        "São Tomé and Príncipe", 0.0, 2, false),
    "SYP": Currency("SYP", "Syrian Pound", "Syria", 0.0, 2, false),
    "SZL": Currency("SZL", "Eswatini Lilangeni", "Eswatini", 0.0, 2, false),
    "THB": Currency("THB", "Thai Baht", "Thailand", 0.0, 2, false),
    "TJS": Currency("TJS", "Tajikistani Somoni", "Tajikistan", 0.0, 2, false),
    "TMT": Currency("TMT", "Turkmenistan Manat", "Turkmenistan", 0.0, 2, false),
    "TND": Currency("TND", "Tunisian Dinar", "Tunisia", 0.0, 3, false),
    "TOP": Currency("TOP", "Tongan Paʻanga", "Tonga", 0.0, 2, false),
    "TRY": Currency("TRY", "Turkish Lira", "Turkey", 0.0, 2, false),
    "TTD": Currency("TTD", "Trinidad and Tobago Dollar", "Trinidad and Tobago",
        0.0, 2, false),
    "TVD": Currency("TVD", "Tuvaluan Dollar", "Tuvalu", 0.0, 2, false),
    "TWD": Currency("TWD", "New Taiwan Dollar", "Taiwan", 0.0, 2, false),
    "TZS": Currency("TZS", "Tanzanian Shilling", "Tanzania", 0.0, 2, false),
    "UAH": Currency("UAH", "Ukrainian Hryvnia", "Ukraine", 0.0, 2, false),
    "UGX": Currency("UGX", "Ugandan Shilling", "Uganda", 0.0, 0, false),
    "USD":
        Currency("USD", "United States Dollar", "United States", 0.0, 2, false),
    "UYU": Currency("UYU", "Uruguayan Peso", "Uruguay", 0.0, 2, false),
    "UZS": Currency("UZS", "Uzbekistani So'm", "Uzbekistan", 0.0, 2, false),
    "VES": Currency(
        "VES", "Venezuelan Bolívar Soberano", "Venezuela", 0.0, 2, false),
    "VND": Currency("VND", "Vietnamese Đồng", "Vietnam", 0.0, 0, false),
    "VUV": Currency("VUV", "Vanuatu Vatu", "Vanuatu", 0.0, 0, false),
    "WST": Currency("WST", "Samoan Tālā", "Samoa", 0.0, 2, false),
    "XAF": Currency("XAF", "Central African CFA Franc", "CEMAC", 0.0, 0, false),
    "XCD": Currency("XCD", "East Caribbean Dollar",
        "Organisation of Eastern Caribbean States", 0.0, 2, false),
    "XDR": Currency("XDR", "Special Drawing Rights",
        "International Monetary Fund", 0.0, 2, false),
    "XOF": Currency("XOF", "West African CFA franc", "CFA", 0.0, 0, false),
    "XPF": Currency(
        "XPF", "CFP Franc", "Collectivités d'Outre-Mer", 0.0, 0, false),
    "YER": Currency("YER", "Yemeni Rial", "Yemen", 0.0, 2, false),
    "ZAR": Currency("ZAR", "South African Rand", "South Africa", 0.0, 2, false),
    "ZMW": Currency("ZMW", "Zambian Kwacha", "Zambia", 0.0, 2, false),
    // Add more currencies as needed
  };

  CurrencyTable();
  Map<String, Currency> returnMAP() {
    return currencies;
  } /*
  void setRate(String code, double newRate) {
    if (currencies.keys.contains(code)) {
      currencies[code]?.setRate(newRate);
    }
  }

  bool hasA(String code) {
    //debugPrint("hasA: ${code}: ${currencies.keys.contains(code)}");
    return currencies.keys.contains(code);
  }

  Currency? getCurrency(String code) {
    return currencies[code];
  }

  String convertUSD2(double dollars, String code) {
    Currency? c = currencies[code];
    double rate = c?.getRate() ?? 1.0;
    int decimalPrecision = c?.getDecimal() ?? 2;
    double converted = dollars * rate;
    //debug print("Debug $dollars * $rate = $converted");
    return converted.toStringAsFixed(decimalPrecision);
  }

  void printAllByUpdate(bool flag) {
    for (Currency c in currencies.values) {
      if (c.getUpdate() == flag) {
        print("${c.getCurrencyCode()}:${c.getRate()}");
      }
    }
  }

  bool beenUpdated(String code) {
    return currencies[code]?.getUpdate() ?? false;
  }

  void update(String code) {
    currencies[code]?.setUpdated(true);
  }

  double getRate(String code) {
    return currencies[code]?.getRate() ?? 0.0;
  }*/
}
