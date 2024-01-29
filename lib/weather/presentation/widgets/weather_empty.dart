import 'package:flutter/material.dart';

class WeatherEmpty extends StatelessWidget {
  const WeatherEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          // border: Border.all(width: 5, color: Colors.purple),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // at 25% it will take primary color
            // at 75% screen, it will take primarycolor's 10% brightness
            // and so on.
            stops: const [0.25, 0.75, 0.90, 1],
            colors: [
              primaryColor,
              primaryColor.brighten(),
              primaryColor.brighten(33),
              primaryColor.brighten(50),
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '🏙️',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              Text(
                'Please Select a City!',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    // if condition is false assert , gives error.
    assert(
      (percent >= 1) && (percent <= 100),
      'percentage must be between 1 and 100',
    );
    // brightness chaning based on percentage, meaning adjusting rgb values.
    // based on brightness factor.
    final p = percent / 100;
    return Color.fromARGB(
      255,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}
