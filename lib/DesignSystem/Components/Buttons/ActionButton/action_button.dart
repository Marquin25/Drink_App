import 'package:flutter/material.dart';
import 'action_button_view_model.dart';
import '../../../shared/colors.dart';
import '../../../shared/styles.dart';

class ActionButton extends StatelessWidget {
  final ActionButtonViewModel viewModel;

  const ActionButton._({super.key, required this.viewModel});

  static Widget instantiate({required ActionButtonViewModel viewModel}) {
    return ActionButton._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = 32;
    double verticalPadding = 12;
    double iconSize = 24;
    TextStyle buttonTextStyle = button3Semibold;
    Color buttonColor = lightPrimaryBrandColor;
    Color textColor = normalPrimaryBaseColorDark; // cor padrão do texto

    // ====== TAMANHO ======
    switch (viewModel.size) {
      case ActionButtonSize.large:
        buttonTextStyle = button1Bold;
        iconSize = 24;
        break;
      case ActionButtonSize.medium:
        buttonTextStyle = button2Semibold;
        iconSize = 24;
        break;
      case ActionButtonSize.small:
        buttonTextStyle = button3Semibold;
        horizontalPadding = 16;
        iconSize = 16;
        break;
      default:
    }

    // ====== ESTILO (cores) ======
    switch (viewModel.style) {
      case ActionButtonStyle.primary:
        buttonColor = lightPrimaryBrandColor;
        textColor = lightTertiaryBaseColorLight; // branco pro texto (Login, etc.)
        break;
      case ActionButtonStyle.secondary:
        buttonColor = lightSecondaryBrandColor;
        textColor = lightTertiaryBaseColorLight; // também branco
        break;
      case ActionButtonStyle.tertiary:
        buttonColor = lightTertiaryBrandColor;
        textColor = lightTertiaryBaseColorLight;
        break;
      default:
    }

    return ElevatedButton(
      onPressed: viewModel.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: textColor, // cor aplicada em texto e ícone
        textStyle: buttonTextStyle.copyWith(color: textColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
      ),
      child: viewModel.icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  viewModel.icon,
                  size: iconSize,
                ),
                const SizedBox(width: 8),
                Text(viewModel.text),
              ],
            )
          : Text(viewModel.text),
    );
  }
}
