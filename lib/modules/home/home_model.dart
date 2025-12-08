class Drink {
  final String id;
  final String name;
  final String thumbnail;

  const Drink({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      id: json['idDrink']?.toString() ?? '',
      name: json['strDrink'] ?? '',
      thumbnail: json['strDrinkThumb'] ?? '',
    );
  }
}
