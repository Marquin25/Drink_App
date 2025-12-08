import 'package:flutter/foundation.dart';

import 'home_model.dart';
import 'home_state.dart';
//guarda os id dos drink favoritos
class HomeViewModel extends ChangeNotifier {
  HomeState _state = HomeState.initial();
  final Set<String> _favoriteIds = {};

  HomeState get state => _state;

  //drinks favoritados
  List<Drink> get favoriteDrinks =>
      _state.drinks.where((d) => _favoriteIds.contains(d.id)).toList();

  bool isFavorite(Drink drink) => _favoriteIds.contains(drink.id);
//add ou remove 
  void toggleFavorite(Drink drink) {
    if (_favoriteIds.contains(drink.id)) {
      _favoriteIds.remove(drink.id);
    } else {
      _favoriteIds.add(drink.id);
    }
    notifyListeners();
  }

  void setLoading(bool value) {
    _state = _state.copyWith(isLoading: value);
    notifyListeners();
  }

  void setError(String? message) {
    _state = _state.copyWith(errorMessage: message);
    notifyListeners();
  }

  void setDrinks(List<Drink> drinks) {
    _state = _state.copyWith(drinks: drinks);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
