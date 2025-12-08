import 'home_viewmodel.dart';
import 'home_service.dart';
import 'home_model.dart';

class HomeController {
  final HomeViewModel viewModel;
  final HomeService _service;

  HomeController(
    this.viewModel, {
    HomeService? service,
  }) : _service = service ?? HomeService();

  void init() {
    _loadDrinks();
  }

  Future<void> onRefresh() async {
    await _loadDrinks();
  }

  Future<void> _loadDrinks() async {
    try {
      viewModel.setLoading(true);
      viewModel.setError(null);

      final List<Drink> drinks = await _service.fetchDrinks();
      viewModel.setDrinks(drinks);
    } catch (e) {
      viewModel.setError('Ocorreu um erro ao buscar os drinks.');
    } finally {
      viewModel.setLoading(false);
    }
  }

  void onToggleFavorite(Drink drink) {
    viewModel.toggleFavorite(drink);
  }
}
