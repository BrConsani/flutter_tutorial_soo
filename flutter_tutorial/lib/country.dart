class Country {
  final String name;
  final String flag;

  Country({required this.name, required this.flag});

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['translations']['por']['official'] as String,
      flag: map['flags']['png'] as String,
    );
  }
}
