import 'package:flutter/foundation.dart';
import '../home/home_model.dart';

class FavoritesViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<Drink> _favorites = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Drink> get favorites => List.unmodifiable(_favorites);

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setFavorites(List<Drink> drinks) {
    _favorites = drinks;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
