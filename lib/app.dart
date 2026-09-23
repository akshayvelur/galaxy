import 'package:flutter/material.dart';
import 'screens/about_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/destinations_screen.dart';
import 'screens/fleet_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/home_screen.dart';
import 'screens/package_details_screen.dart';
import 'screens/packages_screen.dart';
import 'theme/app_theme.dart';

class GalaxyApp extends StatefulWidget {
  const GalaxyApp({super.key});

  @override
  State<GalaxyApp> createState() => _GalaxyAppState();
}

class _GalaxyAppState extends State<GalaxyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void _navigateTo(String route, {Map<String, dynamic>? arguments}) {
    _navigatorKey.currentState?.pushNamed(
      route,
      arguments: arguments,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galaxy | Tourist Travellers & India Tour Packages',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      navigatorKey: _navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '/');
        final args = settings.arguments as Map<String, dynamic>? ?? {};

        Widget page;

        switch (uri.path) {
          case '/packages':
            page = PackagesScreen(
              onNavigate: _navigateTo,
              initialRegion: args['region'],
            );
            break;

          case '/package-details':
            final packageId = args['packageId'] ?? uri.queryParameters['id'] ?? 'kerala-explorer';
            page = PackageDetailsScreen(
              packageId: packageId,
              onNavigate: _navigateTo,
            );
            break;

          case '/fleet':
            page = FleetScreen(
              onNavigate: _navigateTo,
            );
            break;

          case '/destinations':
            page = DestinationsScreen(
              onNavigate: _navigateTo,
            );
            break;

          case '/about':
            page = AboutScreen(
              onNavigate: _navigateTo,
            );
            break;

          case '/gallery':
            page = GalleryScreen(
              onNavigate: _navigateTo,
            );
            break;

          case '/contact':
            page = ContactScreen(
              onNavigate: _navigateTo,
            );
            break;

          case '/booking':
            page = BookingScreen(
              onNavigate: _navigateTo,
              preselectedPackage: args['package'],
              preselectedVehicle: args['vehicle'],
            );
            break;

          case '/':
          default:
            page = HomeScreen(
              onNavigate: _navigateTo,
            );
            break;
        }

        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 220),
        );
      },
    );
  }
}
