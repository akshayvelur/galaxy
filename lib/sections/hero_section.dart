import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/quick_quote_card.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onExploreTours;
  final VoidCallback onPlanTrip;

  const HeroSection({
    super.key,
    required this.onExploreTours,
    required this.onPlanTrip,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double horizontalPadding = Responsive.horizontalPadding(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Image with dark gradient overlay
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: isMobile ? 680 : (screenHeight > 850 ? 820 : screenHeight),
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                // High-resolution Indian Himalayan mountain highway
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=1920&auto=format&fit=crop',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xCC070F1E),
                  const Color(0x990B192C),
                  const Color(0xF2070F1E),
                ],
              ),
            ),
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              top: isMobile ? 120 : 160,
              bottom: isMobile ? 140 : 180,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Tagline Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.accent.withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.verified_outlined, size: 16, color: AppColors.accent),
                      const SizedBox(width: 8),
                      Text(
                        'ALL INDIA TOURIST TRANSPORT & CUSTOM PACKAGES',
                        style: AppTypography.badgeText.copyWith(
                          color: AppColors.accent,
                          letterSpacing: 1.2,
                          fontSize: isMobile ? 10 : 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Main Headline
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 950),
                  child: Text(
                    'Your Journey Across India Starts Here',
                    textAlign: TextAlign.center,
                    style: (isMobile
                            ? AppTypography.displayMedium
                            : AppTypography.displayLarge)
                        .copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Subheadline
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Text(
                    'Comfortable group tours, premium travellers and buses, and unforgettable journeys across India.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyLarge.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: isMobile ? 15 : 18,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Hero CTA Buttons
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    CustomButton(
                      text: 'Explore Tours',
                      icon: Icons.explore_rounded,
                      variant: ButtonVariant.primary,
                      height: 52,
                      fontSize: 15,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      onPressed: onExploreTours,
                    ),
                    CustomButton(
                      text: 'Plan Your Trip',
                      icon: Icons.map_outlined,
                      variant: ButtonVariant.outline,
                      height: 52,
                      fontSize: 15,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      onPressed: onPlanTrip,
                    ),
                  ],
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ),

        // Floating Booking / Enquiry Card placed over hero
        Positioned(
          bottom: isMobile ? -90 : -50,
          left: horizontalPadding,
          right: horizontalPadding,
          child: const Center(
            child: QuickQuoteCard(),
          ),
        ),
      ],
    );
  }
}
