import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/country.dart';
import 'package:http/http.dart' as http;

class MyCountries extends StatefulWidget {
  const MyCountries({Key? key}) : super(key: key);

  @override
  State<MyCountries> createState() => _MyCountriesState();
}

class _MyCountriesState extends State<MyCountries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countries')),
      body: FutureBuilder<List<Country>>(
        future: getCountries(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final countries = snapshot.data!;

            return ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];

                return Row(
                  children: [
                    Image.network(
                      country.flag,
                      height: 64,
                      width: 96,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(width: 16),
                    Text(country.name),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Country>> getCountries() async {
    final rawResponse = await http.get(
      Uri.parse('https://restcountries.com/v3.1/all'),
    );

    final parsedResponse = jsonDecode(utf8.decode(rawResponse.bodyBytes));

    return parsedResponse.map<Country>((map) => Country.fromMap(map)).toList();
  }
}
