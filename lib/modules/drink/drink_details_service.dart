import 'dart:convert';
import 'package:http/http.dart' as http;

import 'drink_details_model.dart';

class DrinkDetailsService {
  Future<DrinkDetails> fetchDetails(String drinkId) async {
    final url = Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$drinkId',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar detalhes do drink');
    }

    final decoded = json.decode(response.body) as Map<String, dynamic>;
    final drinkJson = (decoded['drinks'] as List).first;

    return DrinkDetails.fromJson(drinkJson);
  }
}
