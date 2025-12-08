import 'dart:convert';
import 'package:http/http.dart' as http;

import 'home_model.dart';

class HomeService {
  //lista dos drink do "Cocktail"
  static const String _url =
      'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail';

  Future<List<Drink>> fetchDrinks() async {
    final uri = Uri.parse(_url);

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao buscar drinks. Código: ${response.statusCode}',
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final drinksJson = decoded['drinks'] as List<dynamic>?;

    if (drinksJson == null) return [];

    return drinksJson
        .map((json) => Drink.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
