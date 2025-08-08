import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themed_app/theme_manager.dart';

class ThemeColorPicker extends StatelessWidget {
  const ThemeColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();

    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(2),
      children: List.generate(Colors.primaries.length, (index) {
        final color = Colors.primaries[index];
        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
          margin: EdgeInsets.all(2),
          child: GestureDetector(
            onTap: () {
              debugPrint("Tapped");
              themeManager.updateSeedColor(color);
            },
            child:
                color.toARGB32() == themeManager.seedColor.toARGB32()
                    ? Center(child: Icon(Icons.check))
                    : null,
          ),
        );
      }),
    );
  }
}
