import 'home_model.dart';

class HomeState {
  final bool isLoading;
  final String? errorMessage;
  final List<Drink> drinks;

  const HomeState({
    required this.isLoading,
    required this.errorMessage,
    required this.drinks,
  });

  factory HomeState.initial() {
    return const HomeState(
      isLoading: false,
      errorMessage: null,
      drinks: [],
    );
  }

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Drink>? drinks,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      drinks: drinks ?? this.drinks,
    );
  }
}
