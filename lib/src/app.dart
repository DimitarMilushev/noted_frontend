import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:noted_frontend/src/dashboard/presentation/views/dashboard.view.dart';
import 'package:noted_frontend/src/settings/settings_view.dart';
import 'package:noted_frontend/src/shared/providers/auth/session.provider.dart';
import 'package:noted_frontend/src/shared/router.provider.dart';
import 'package:noted_frontend/src/shared/settings.provider.dart';

/// The Widget that configures your application.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    ref.read(settingsControllerProvider).loadSettings();
    ref.watch(sessionProvider);
    return ListenableBuilder(
      listenable: ref.watch(settingsControllerProvider),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(useMaterial3: true),
          darkTheme: ThemeData.dark(),
          routerConfig: ref.watch(routerProvider),
          builder: (context, child) => Scaffold(
              body: ref.watch(sessionProvider.notifier).isLoggedIn
                  ? _getLoggedInView(child!)
                  : child),
        );
      },
    );
  }

  Widget _getLoggedInView(Widget child) => Row(children: [
        const _SideMenu(),
        Expanded(child: child),
      ]);
}

class _SideMenu extends ConsumerWidget {
  const _SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = SideMenuController();
    String selectedRoute = '';

    ref.listen(routerProvider.select((x) => x.currentPath), (prev, next) {
      selectedRoute = next;
      print(selectedRoute);
    });

    return SideMenu(
      controller: controller,
      mode: SideMenuMode.compact,
      hasResizer: false,
      hasResizerToggle: true,
      resizerToggleData: const ResizerToggleData(
        opacity: 0.7,
        iconSize: 32,
      ),
      backgroundColor: Theme.of(context).splashColor,
      builder: (data) => SideMenuData(
        header: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: 24,
            horizontal: 8,
          ),
          child: Text("Noted v1.0"),
        ),
        items: [
          SideMenuItemDataTile(
            isSelected: selectedRoute == DashboardView.route,
            onTap: () {
              ref.read(routerProvider).go(DashboardView.route);
            },
            title: 'Dashboard',
            icon: const Icon(Icons.home),
          ),
          SideMenuItemDataTile(
            isSelected: selectedRoute == SettingsView.routeName,
            onTap: () {
              ref.read(routerProvider).go(SettingsView.routeName);
            },
            title: 'Settings',
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
