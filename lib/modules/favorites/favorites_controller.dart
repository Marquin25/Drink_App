import '../home/home_model.dart';
import 'favorites_viewmodel.dart';

class FavoritesController {
  final FavoritesViewModel viewModel;

  FavoritesController(this.viewModel);

  void loadFavorites(List<Drink> drinks) {
    viewModel.setLoading(true);
    viewModel.setError(null);

    try {
      viewModel.setFavorites(drinks);
    } catch (e) {
      viewModel.setError('Ocorreu um erro ao carregar seus favoritos.');
    } finally {
      viewModel.setLoading(false);
    }
  }
}
