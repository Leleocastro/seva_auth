import 'package:flutter/material.dart';
import 'package:seva_auth/ui/components/main_button.dart';

class MainErrorTryAgain extends StatelessWidget {
  final VoidCallback onTryAgain;
  final bool notShowButton;
  final String? title;
  final String? description;
  final String? buttonText;
  const MainErrorTryAgain({
    required this.onTryAgain,
    this.notShowButton = false,
    this.title,
    this.description,
    this.buttonText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          const Icon(
            Icons.warning_amber_rounded,
            size: 80,
            color: Colors.redAccent,
          ),
          const SizedBox(height: 20),
          Text(
            title ?? 'Serviço indisponível no momento',
            textAlign: TextAlign.center,
            style: theme.primaryTextTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          Text(
            description ??
                'Serviço indisponível no momento, por favor, tente novamente mais tarde',
            textAlign: TextAlign.center,
            style: theme.primaryTextTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          MainButton(
            label: buttonText ?? 'TENTAR NOVAMENTE',
            onPressed: onTryAgain,
          ),
        ],
      ),
    );
  }
}
