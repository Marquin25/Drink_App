class DrinkDetails {
  final String id;
  final String name;
  final String instructions;
  final String thumbnail;
  final List<String> ingredients;

  DrinkDetails({
    required this.id,
    required this.name,
    required this.instructions,
    required this.thumbnail,
    required this.ingredients,
  });

  factory DrinkDetails.fromJson(Map<String, dynamic> json) {
    final List<String> ingredients = [];

    // A API tem campos strIngredient1, strIngredient2, ..., strIngredient15
    for (int i = 1; i <= 15; i++) {
      final ingredient = json['strIngredient$i'];
      if (ingredient != null && ingredient.toString().isNotEmpty) {
        ingredients.add(ingredient.toString());
      }
    }

    return DrinkDetails(
      id: json['idDrink'],
      name: json['strDrink'],
      instructions: json['strInstructions'] ?? '',
      thumbnail: json['strDrinkThumb'],
      ingredients: ingredients,
    );
  }
}
