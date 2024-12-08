import 'package:flutter/material.dart';

// A widget for displaying a chart bar
class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });

  // Initializes a fill value for the chart bar
  // Double value represents the fill percentage of the chart bar
  final double fill;

  @override
  Widget build(BuildContext context) {
    // isDarkMode variable is a boolean value that indicates whether the device is in dark mode or not
    // It is determined by checking the platformBrightness property of the MediaQuery object, 
    // which returns a value indicating the brightness of the device's screen
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        // A widget that sizes its child to a fraction of the available space
        child: FractionallySizedBox(
          // Set the height factor based on the fill value
          heightFactor: fill,
          // A widget that decorates its child with a box decoration
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              // A conditional expression that depends on the isDarkMode variable.
              // If isDarkMode is true, the color will be the secondary color of the theme,
              // otherwise, it will be the primary color of the theme with an opacity 
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
