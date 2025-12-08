import 'package:flutter/material.dart';
import 'package:meu_app/DesignSystem/shared/styles.dart';
import 'package:meu_app/DesignSystem/shared/colors.dart';

import 'drink_details_model.dart';
import 'drink_details_service.dart';

class DrinkDetailsView extends StatefulWidget {
  final String drinkId;

  const DrinkDetailsView({
    super.key,
    required this.drinkId,
  });

  @override
  State<DrinkDetailsView> createState() => _DrinkDetailsViewState();
}

class _DrinkDetailsViewState extends State<DrinkDetailsView> {
  late Future<DrinkDetails> _futureDetails;

  @override
  void initState() {
    super.initState();
    _futureDetails = DrinkDetailsService().fetchDetails(widget.drinkId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: normalPrimaryBrandColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: darkPrimaryBaseColorDark,
        ),
        title: const Text(
          'Detalhes do Drink',
          style: navbarSmallTitle,
        ),
        actions: [
          IconButton(
            tooltip: 'Favoritar',
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Incompleto...'),
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
                  content: Text('Incompleto ...'),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<DrinkDetails>(
        future: _futureDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text('Erro ao carregar detalhes do drink'),
            );
          }

          final drink = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //ft grande
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    drink.thumbnail,
                    width: double.infinity,
                    height: 260,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 20),

                //nome
                Text(
                  drink.name,
                  style: heading5Regular,
                ),

                const SizedBox(height: 16),

                //ingredientes
                Text(
                  'Ingredientes',
                  style: subtitle1Regular,
                ),
                const SizedBox(height: 8),
                ...drink.ingredients.map(
                  (ing) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      '• $ing',
                      style: paragraph1Regular,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                //modo de preparo
                Text(
                  'Modo de preparo',
                  style: subtitle1Regular,
                ),
                const SizedBox(height: 8),
                Text(
                  drink.instructions,
                  style: paragraph1Regular,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
