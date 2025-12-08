import 'package:flutter/material.dart';

import '../home/home_model.dart';
import 'favorites_viewmodel.dart';
import 'favorites_controller.dart';

import 'package:meu_app/DesignSystem/shared/colors.dart';
import 'package:meu_app/DesignSystem/shared/styles.dart';

class FavoritesView extends StatefulWidget {
  final List<Drink> initialFavorites;

  const FavoritesView({
    super.key,
    required this.initialFavorites,
  });

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late final FavoritesViewModel viewModel;
  late final FavoritesController controller;

  void _onStateChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    viewModel = FavoritesViewModel();
    controller = FavoritesController(viewModel);

    viewModel.addListener(_onStateChanged);

    controller.loadFavorites(widget.initialFavorites);
  }

  @override
  void dispose() {
    viewModel.removeListener(_onStateChanged);
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = viewModel.isLoading;
    final errorMessage = viewModel.errorMessage;
    final favorites = viewModel.favorites;

    return Scaffold(
      backgroundColor: darkPrimaryBaseColorDark,
      appBar: AppBar(
        backgroundColor: normalPrimaryBrandColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: darkPrimaryBaseColorDark,
        ),
        title: const Text(
          'Favoritos',
          style: navbarSmallTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Builder(
          builder: (_) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (errorMessage != null && errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            if (favorites.isEmpty) {
              return const _EmptyFavoritesState();
            }

            return GridView.builder(
              itemCount: favorites.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final drink = favorites[index];
                return _FavoriteCard(drink: drink); //card do drink
              },
            );
          },
        ),
      ),
    );
  }
}

class _EmptyFavoritesState extends StatelessWidget {
  const _EmptyFavoritesState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_border,
            size: 48,
            color: Colors.white70,
          ),
          SizedBox(height: 12),
          Text(
            'Você ainda não tem drinks favoritos.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final Drink drink;

  const _FavoriteCard({required this.drink});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                drink.thumbnail,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(
                    Icons.local_drink,
                    color: Colors.white70,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              drink.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
