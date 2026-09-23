import 'package:flutter/material.dart';
import '../data/travel_types_data.dart';
import '../models/travel_type.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../widgets/section_header.dart';

class TravelTypesSection extends StatelessWidget {
  final Function(TravelType type) onSelectType;

  const TravelTypesSection({
    super.key,
    required this.onSelectType,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final types = TravelTypesData.travelTypes;

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
            kicker: 'Tailored Experiences',
            title: 'Tours Crafted for Every Travel Style',
            subtitle:
                'Whether you are travelling with children, seniors, college buddies or corporate colleagues, our vehicles and itineraries adapt to you.',
          ),
          const SizedBox(height: 50),

          // 8 Travel Types Grid
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 4;
              if (constraints.maxWidth < 600) {
                crossAxisCount = 1;
              } else if (constraints.maxWidth < 950) {
                crossAxisCount = 2;
              } else if (constraints.maxWidth < 1200) {
                crossAxisCount = 3;
              }

              final double cardWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 20)) / crossAxisCount;

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: types.map((item) {
                  return SizedBox(
                    width: cardWidth,
                    child: _buildTypeCard(item),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTypeCard(TravelType item) {
    return InkWell(
      onTap: () => onSelectType(item),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(item.icon, color: AppColors.secondary, size: 24),
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: AppColors.textMuted,
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              item.title,
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.description,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
