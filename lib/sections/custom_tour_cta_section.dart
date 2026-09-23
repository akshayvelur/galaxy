import 'package:flutter/material.dart';
import '../services/whatsapp_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';

class CustomTourCtaSection extends StatelessWidget {
  final VoidCallback onCreateTrip;

  const CustomTourCtaSection({
    super.key,
    required this.onCreateTrip,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final double horizontalPadding = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 40,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0B192C),
              Color(0xFF1E3E62),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          image: const DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?q=80&w=1600&auto=format&fit=crop',
            ),
            fit: BoxFit.cover,
            opacity: 0.16,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 60,
          vertical: isMobile ? 48 : 64,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.secondary.withOpacity(0.4)),
              ),
              child: Text(
                'TAILOR-MADE ITINERARIES',
                style: AppTypography.badgeText.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Heading exactly as requested
            Text(
              'Your Trip. Your Route. Your Way.',
              textAlign: TextAlign.center,
              style: (isMobile
                      ? AppTypography.headlineLarge
                      : AppTypography.displayMedium)
                  .copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),

            // Text exactly as requested
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Text(
                'Planning a family trip, college tour, corporate outing, pilgrimage or friends\' adventure? We\'ll help create a journey around your plans.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: isMobile ? 14 : 17,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 36),

            // Buttons: "Create My Trip", "Talk to Us"
            Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                CustomButton(
                  text: 'Create My Trip',
                  icon: Icons.edit_calendar_rounded,
                  variant: ButtonVariant.primary,
                  height: 52,
                  fontSize: 15,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  onPressed: onCreateTrip,
                ),
                CustomButton(
                  text: 'Talk to Us',
                  icon: Icons.call_rounded,
                  variant: ButtonVariant.outline,
                  height: 52,
                  fontSize: 15,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  onPressed: () => WhatsAppService.launchWhatsApp(
                    customMessage: 'Hello Galaxy! We would like to talk to a tour planner regarding a custom group trip across India.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
