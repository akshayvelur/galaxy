import 'package:flutter/material.dart';
import '../data/destinations_data.dart';
import '../models/destination.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/destination_card.dart';
import '../widgets/section_header.dart';

class DestinationExplorerSection extends StatefulWidget {
  final Function(Destination destination) onSelectDestination;
  final VoidCallback onViewAllDestinations;

  const DestinationExplorerSection({
    super.key,
    required this.onSelectDestination,
    required this.onViewAllDestinations,
  });

  @override
  State<DestinationExplorerSection> createState() => _DestinationExplorerSectionState();
}

class _DestinationExplorerSectionState extends State<DestinationExplorerSection> {
  String _activeCategory = 'All';

  final List<String> _categories = [
    'All',
    'North India',
    'South India',
    'West India',
    'East India',
    'Northeast India',
  ];

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final filteredDestinations = DestinationsData.getByRegion(_activeCategory);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 70,
      ),
      child: Column(
        children: [
          // Header
          const SectionHeader(
            kicker: 'Incredible Destinations',
            title: 'Discover India With Us',
            subtitle:
                'From snow-draped Himalayan heights to emerald tropical backwaters and golden royal palaces.',
          ),
          const SizedBox(height: 36),

          // Filter Category Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _categories.map((category) {
                final bool isSelected = _activeCategory == category;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: InkWell(
                    onTap: () => setState(() => _activeCategory = category),
                    borderRadius: BorderRadius.circular(30),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.background,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Text(
                        category,
                        style: AppTypography.bodySmall.copyWith(
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 44),

          // Destination Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 4;
              if (constraints.maxWidth < 640) {
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
                children: filteredDestinations.take(8).map((dest) {
                  return SizedBox(
                    width: cardWidth,
                    child: DestinationCard(
                      destination: dest,
                      onExplore: () => widget.onSelectDestination(dest),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 40),

          // View all CTA
          CustomButton(
            text: 'Explore All 20+ Destinations',
            icon: Icons.travel_explore_rounded,
            variant: ButtonVariant.outline,
            onPressed: widget.onViewAllDestinations,
          ),
        ],
      ),
    );
  }
}
