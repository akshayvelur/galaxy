import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';

class QuickTrustSection extends StatelessWidget {
  const QuickTrustSection({super.key});

  static const List<Map<String, dynamic>> _trustItems = [
    {
      'title': 'Comfortable Vehicles',
      'subtitle': '16, 18 & 26 seaters with AC',
      'icon': Icons.airline_seat_recline_extra_rounded,
    },
    {
      'title': 'Experienced Drivers',
      'subtitle': 'Vetted highway & hill pilots',
      'icon': Icons.badge_rounded,
    },
    {
      'title': 'All India Tours',
      'subtitle': 'National tourist permit routes',
      'icon': Icons.explore_rounded,
    },
    {
      'title': 'Custom Tour Packages',
      'subtitle': 'Tailored to your itinerary',
      'icon': Icons.tune_rounded,
    },
    {
      'title': 'Group Travel Specialists',
      'subtitle': 'Family, corporate & friends',
      'icon': Icons.groups_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final double horizontalPadding = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        // Generous top padding to accommodate the floating card above
        top: isMobile ? 120 : 80,
        bottom: 40,
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 900) {
                // Mobile / Tablet: Wrap or 2-column grid
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: _trustItems.map((item) {
                    return SizedBox(
                      width: constraints.maxWidth < 500
                          ? (constraints.maxWidth - 20)
                          : (constraints.maxWidth / 2 - 20),
                      child: _buildTrustItem(item),
                    );
                  }).toList(),
                );
              }

              // Desktop: 5 horizontal columns
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _trustItems.map((item) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _buildTrustItem(item),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 30),
          const Divider(color: AppColors.border),
        ],
      ),
    );
  }

  Widget _buildTrustItem(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withOpacity(0.8)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item['icon'] as IconData,
              color: AppColors.secondary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, size: 14, color: AppColors.success),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item['title'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.titleMedium.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  item['subtitle'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
