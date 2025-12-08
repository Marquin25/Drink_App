import 'package:flutter/material.dart';

import 'home_viewmodel.dart';
import 'home_controller.dart';
import 'home_model.dart';

import 'package:meu_app/modules/drink/drink_details_view.dart';
import 'package:meu_app/modules/favorites/favorites_view.dart';

import 'package:meu_app/DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import 'package:meu_app/DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import 'package:meu_app/DesignSystem/shared/styles.dart';
import 'package:meu_app/DesignSystem/shared/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel viewModel = HomeViewModel();
  late final HomeController controller = HomeController(viewModel);

  @override
  void initState() {
    super.initState();
    viewModel.addListener(_onStateChanged);
    controller.init();
  }

  void _onStateChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    viewModel.removeListener(_onStateChanged);
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;
//cabeçalho
    return Scaffold(
      appBar: AppBar(
        backgroundColor: normalPrimaryBrandColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: darkPrimaryBaseColorDark,
        ),
        title: const Text(
          'Drinks',
          style: navbarSmallTitle,
        ),
        actions: [
          IconButton(
            tooltip: 'Favoritos',
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              final favorites = viewModel.favoriteDrinks;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesView(
                    initialFavorites: favorites,
                  ),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Perfil',
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('incomppleto ...'),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Builder(
          builder: (context) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => controller.onRefresh(),
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              );
            }

            if (state.drinks.isEmpty) {
              return const Center(
                child: Text('Nenhum drink encontrado.'),
              );
            }

            return RefreshIndicator(
              onRefresh: controller.onRefresh,
              child: GridView.builder(
                itemCount: state.drinks.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 260,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final Drink drink = state.drinks[index];

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //ft
                        Expanded(
                          child: Image.network(
                            drink.thumbnail,
                            fit: BoxFit.cover,
                            errorBuilder: (context, _, __) => const Center(
                              child: Icon(Icons.local_drink),
                            ),
                          ),
                        ),

                        //nome
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                          child: Text(
                            drink.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        //botão "Ver detalhes" e coração
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Row(
                            children: [
                              //botçao ds
                              Expanded(
                                child: ActionButton.instantiate(
                                  viewModel: ActionButtonViewModel(
                                    size: ActionButtonSize.small,
                                    style: ActionButtonStyle.primary,
                                    text: 'Ver detalhes',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => DrinkDetailsView(
                                            drinkId: drink.id,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              //coração de favorito
                              IconButton(
                                icon: Icon(
                                  viewModel.isFavorite(drink)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: viewModel.isFavorite(drink)
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onPressed: () =>
                                    controller.onToggleFavorite(drink),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
