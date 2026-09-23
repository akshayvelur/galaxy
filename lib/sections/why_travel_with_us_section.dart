import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../widgets/section_header.dart';

class WhyTravelWithUsSection extends StatelessWidget {
  const WhyTravelWithUsSection({super.key});

  static const List<Map<String, dynamic>> _features = [
    {
      'title': 'Comfortable Vehicles',
      'desc': 'Our 16-seat, 18-seat Travellers and 26-seat Buses feature high-back recliners, twin chiller ACs, USB ports, and clean sanitized interiors.',
      'icon': Icons.airline_seat_recline_extra_outlined,
    },
    {
      'title': 'Experienced Drivers',
      'desc': 'Certified commercial highway pilots with a minimum of 8+ years experience navigating mountain hairpins, expressways, and local shortcuts.',
      'icon': Icons.verified_user_outlined,
    },
    {
      'title': 'Custom Itineraries',
      'desc': 'Flexible travel plans designed around your family or group preferences, with no rigid timetables, allowing spontaneous roadside stops.',
      'icon': Icons.tune_outlined,
    },
    {
      'title': 'Transparent Pricing',
      'desc': 'All-inclusive itemized pricing covering state border taxes, expressway tolls, fuel, parking, and driver allowances. Zero hidden charges.',
      'icon': Icons.receipt_long_outlined,
    },
    {
      'title': 'All India Coverage',
      'desc': 'Comprehensive All India Tourist Permits (AITP) covering 28 states and transit corridors from Kashmir to Kanyakumari and Gujarat to Assam.',
      'icon': Icons.map_outlined,
    },
    {
      'title': '24/7 Travel Support',
      'desc': 'Dedicated tour managers monitoring live vehicle GPS, route weather updates, and emergency on-road mechanical assistance around the clock.',
      'icon': Icons.support_agent_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      color: AppColors.primaryDark, // Deep navy background for visual contrast
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 80,
      ),
      child: Column(
        children: [
          // Dark Header
          const SectionHeader(
            kicker: 'The Galaxy Standard',
            title: 'Why Travel With Us',
            subtitle:
                'We believe group road travel should be effortless, safe, and truly luxurious for every generation in your family.',
            isDark: true,
          ),
          const SizedBox(height: 54),

          // 6 Feature Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 3;
              if (constraints.maxWidth < 650) {
                crossAxisCount = 1;
              } else if (constraints.maxWidth < 1000) {
                crossAxisCount = 2;
              }

              final double cardWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 24)) / crossAxisCount;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: _features.map((feature) {
                  return SizedBox(
                    width: cardWidth,
                    child: _buildFeatureCard(feature),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
            ),
            child: Icon(
              feature['icon'] as IconData,
              color: AppColors.secondary,
              size: 28,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            feature['title'] as String,
            style: AppTypography.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            feature['desc'] as String,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textLightMuted,
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
