import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/constants.dart';
import '../services/whatsapp_service.dart';
import 'custom_button.dart';

class AppDrawer extends StatelessWidget {
  final String activeRoute;
  final Function(String route) onNavigate;

  const AppDrawer({
    super.key,
    required this.activeRoute,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryDark,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppColors.orangeGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.explore_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'GALAXY',
                              style: AppTypography.headlineSmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            TextSpan(
                              text: ' TRAVELS',
                              style: AppTypography.headlineSmall.copyWith(
                                color: AppColors.accent,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'PREMIUM TOURS & FLEET',
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.white54,
                          fontSize: 10,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white12),

            // Navigation items list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  _buildDrawerItem(context, 'Home', '/', Icons.home_rounded),
                  _buildDrawerItem(context, 'Tour Packages', '/packages', Icons.card_travel_rounded),
                  _buildDrawerItem(context, 'Destinations', '/destinations', Icons.map_rounded),
                  _buildDrawerItem(context, 'Our Fleet', '/fleet', Icons.directions_bus_rounded),
                  _buildDrawerItem(context, 'About Us', '/about', Icons.info_outline_rounded),
                  _buildDrawerItem(context, 'Photo Gallery', '/gallery', Icons.photo_library_rounded),
                  _buildDrawerItem(context, 'Contact & Support', '/contact', Icons.headset_mic_rounded),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Plan Your Trip',
                    icon: Icons.flight_takeoff_rounded,
                    variant: ButtonVariant.primary,
                    isFullWidth: true,
                    onPressed: () {
                      Navigator.pop(context);
                      onNavigate('/booking');
                    },
                  ),
                ],
              ),
            ),

            // Drawer Footer with Quick WhatsApp & Call
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chat, color: Color(0xFF25D366)),
                        onPressed: () => WhatsAppService.launchWhatsApp(),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.phone_in_talk, color: AppColors.accent),
                        onPressed: () => WhatsAppService.makePhoneCall(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppConstants.workingHours,
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white38,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    String route,
    IconData icon,
  ) {
    final bool isActive = activeRoute == route;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: isActive ? AppColors.secondary.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isActive
            ? Border.all(color: AppColors.secondary.withOpacity(0.4), width: 1)
            : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? AppColors.secondary : Colors.white70,
          size: 22,
        ),
        title: Text(
          title,
          style: AppTypography.bodyMedium.copyWith(
            color: isActive ? AppColors.secondary : Colors.white,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          onNavigate(route);
        },
      ),
    );
  }
}
