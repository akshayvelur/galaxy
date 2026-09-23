import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import 'custom_button.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isScrolled;
  final String activeRoute;
  final Function(String route)? onNavigate;
  final VoidCallback? onOpenDrawer;

  const Navbar({
    super.key,
    this.isScrolled = false,
    this.activeRoute = '/',
    this.onNavigate,
    this.onOpenDrawer,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    // If scrolled or not on home, solid navy/white; if top of home, glass/transparent with white text
    final bool showSolid = isScrolled || activeRoute != '/';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 80,
      decoration: BoxDecoration(
        color: showSolid
            ? AppColors.primary.withOpacity(0.96)
            : Colors.transparent,
        boxShadow: showSolid
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Brand Logo
          InkWell(
            onTap: () => onNavigate?.call('/'),
            borderRadius: BorderRadius.circular(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: AppColors.orangeGradient,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondary.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.explore_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
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
                              letterSpacing: 0.5,
                              fontSize: isMobile ? 18 : 22,
                            ),
                          ),
                          TextSpan(
                            text: ' TRAVELS',
                            style: AppTypography.headlineSmall.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                              fontSize: isMobile ? 18 : 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'PREMIUM TOURS & TRANSPORT',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white70,
                        fontSize: 9,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Desktop Navigation Links
          if (!isMobile) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildNavLink(context, 'Home', '/'),
                _buildNavLink(context, 'Packages', '/packages'),
                _buildNavLink(context, 'Destinations', '/destinations'),
                _buildNavLink(context, 'Fleet', '/fleet'),
                _buildNavLink(context, 'About', '/about'),
                _buildNavLink(context, 'Gallery', '/gallery'),
                _buildNavLink(context, 'Contact', '/contact'),
              ],
            ),
            // Prominent "Plan Your Trip" Button
            CustomButton(
              text: 'Plan Your Trip',
              icon: Icons.flight_takeoff_rounded,
              variant: ButtonVariant.primary,
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              onPressed: () => onNavigate?.call('/booking'),
            ),
          ] else ...[
            // Mobile Hamburger Menu Button
            IconButton(
              onPressed: onOpenDrawer,
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String label, String route) {
    final bool isActive = activeRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: () => onNavigate?.call(route),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  color: isActive ? AppColors.accent : Colors.white,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: isActive ? 20 : 0,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
