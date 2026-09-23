import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../widgets/section_header.dart';

class TravelTimelineSection extends StatelessWidget {
  const TravelTimelineSection({super.key});

  static const List<Map<String, String>> _steps = [
    {
      'step': '01',
      'title': 'Choose Your Destination',
      'desc': 'Select from 20+ breathtaking circuits across North, South, West, East, or Northeast India.',
      'icon': 'pin',
    },
    {
      'step': '02',
      'title': 'Select Your Vehicle',
      'desc': 'Pick a 16-seat, 18-seat Traveller or 26-seat Bus tailored to your exact group size and luggage.',
      'icon': 'bus',
    },
    {
      'step': '03',
      'title': 'Customize Your Trip',
      'desc': 'Fine-tune days, pickup points, hotel stays, meal plans, and preferred scenic stopovers.',
      'icon': 'tune',
    },
    {
      'step': '04',
      'title': 'Confirm Your Journey',
      'desc': 'Receive transparent, all-inclusive pricing with instant booking confirmation and driver assignment.',
      'icon': 'check',
    },
    {
      'step': '05',
      'title': 'Enjoy India',
      'desc': 'Sit back in reclining AC comfort while our seasoned chauffeur navigates the incredible roads of India.',
      'icon': 'smile',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 75,
      ),
      child: Column(
        children: [
          const SectionHeader(
            kicker: 'How It Works',
            title: 'Your Road Trip Journey in 5 Simple Steps',
            subtitle:
                'From your initial destination idea to the scenic highway turns, we make group travel planning effortless.',
          ),
          const SizedBox(height: 56),

          LayoutBuilder(
            builder: (context, constraints) {
              final bool isNarrow = constraints.maxWidth < 950;

              if (isNarrow) {
                // Vertical Road Line with Milestones
                return Column(
                  children: _steps.asMap().entries.map((entry) {
                    final index = entry.key;
                    final step = entry.value;
                    final isLast = index == _steps.length - 1;

                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Step Indicator & Road Line
                          Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: AppColors.orangeGradient,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.secondary.withOpacity(0.35),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    step['step']!,
                                    style: AppTypography.titleMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              if (!isLast)
                                Expanded(
                                  child: Container(
                                    width: 3,
                                    margin: const EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColors.border,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 20),

                          // Text Content
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 36, top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step['title']!,
                                    style: AppTypography.headlineSmall.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    step['desc']!,
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }

              // Desktop Horizontal Highway Timeline
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Highway road line through centers
                  Positioned(
                    top: 25,
                    left: 40,
                    right: 40,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // 5 Step Milestones
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _steps.map((step) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Step Milestone circle
                              Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  gradient: AppColors.orangeGradient,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.secondary.withOpacity(0.35),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    step['step']!,
                                    style: AppTypography.titleMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                step['title']!,
                                textAlign: TextAlign.center,
                                style: AppTypography.titleMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                step['desc']!,
                                textAlign: TextAlign.center,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
