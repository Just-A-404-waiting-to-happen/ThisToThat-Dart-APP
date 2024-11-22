class Currency {
  final String currencyCode;
  final String currencyName;
  final String country;
  double rate;

  Currency(this.currencyCode, this.currencyName, this.country, this.rate);

  void setRate(double newRate) {
    rate = newRate;
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
    );
  }
}
