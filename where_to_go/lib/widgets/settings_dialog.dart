import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../features/theme/theme_provider.dart";

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme
        .of(context)
        .colorScheme;
    final currentTheme = ref
        .watch(themeProvider)
        .value ?? ThemeMode.system;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: .stretch,
            mainAxisSize: .min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: colors.onPrimary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Ustawienia",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colors.onPrimary,
                        fontSize: 24
                    ),
                  ),
                ],
              ),
              // Container(
              //   height: 1,
              //   width: double.infinity,
              //   margin: const EdgeInsets.symmetric(vertical: 12),
              //   decoration: BoxDecoration(color: Colors.grey[400],
              //       borderRadius: BorderRadius.circular(10)),
              // ),
              Divider(height: 24, color: Colors.grey[400],),
              Text(
                "Motyw aplikacji",
                style: TextStyle(
                  fontSize: 16,
                  color: colors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(
                    value: ThemeMode.light,
                    label: Text("Jasny"),
                    icon: Icon(Icons.light_mode, size: 12,),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    label: Text("Ciemny"),
                    icon: Icon(Icons.dark_mode, size: 12),
                  ),
                  ButtonSegment(
                    value: ThemeMode.system,
                    label: Text("System"),
                    icon: Icon(Icons.phone_android, size: 12),
                  ),
                ],
                selected: {currentTheme},
                onSelectionChanged: (selection) async {
                  await ref.read(themeProvider.notifier).setTheme(selection.first);
                },
                showSelectedIcon: false,
                style: SegmentedButton.styleFrom(
                  foregroundColor: colors.onPrimary,
                  side: BorderSide(color: colors.onPrimary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
