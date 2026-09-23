import 'package:flutter/material.dart';
import '../data/tour_packages_data.dart';
import '../models/tour_package.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/package_card.dart';
import '../widgets/section_header.dart';

class PopularPackagesSection extends StatelessWidget {
  final Function(TourPackage package) onSelectPackage;
  final VoidCallback onViewAllPackages;

  const PopularPackagesSection({
    super.key,
    required this.onSelectPackage,
    required this.onViewAllPackages,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final packages = TourPackagesData.packages;

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 60,
      ),
      child: Column(
        children: [
          // Section Header
          SectionHeader(
            kicker: 'Curated Itineraries',
            title: 'Popular Tour Packages Across India',
            subtitle:
                'Handcrafted journeys with dedicated tourist vehicle, verified driver, handpicked hotels, and customized sightseeing.',
            trailing: isMobile
                ? null
                : CustomButton(
                    text: 'View All Tour Packages',
                    icon: Icons.arrow_forward_rounded,
                    variant: ButtonVariant.outline,
                    onPressed: onViewAllPackages,
                  ),
          ),
          const SizedBox(height: 48),

          // Layout: Horizontal scroll on mobile/small screens, Grid on desktop
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 850) {
                // Mobile horizontal scroll
                return Column(
                  children: [
                    SizedBox(
                      height: 520,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: packages.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final pkg = packages[index];
                          return SizedBox(
                            width: 320,
                            child: PackageCard(
                              package: pkg,
                              onViewPackage: () => onSelectPackage(pkg),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'View All 8 Tour Packages',
                      icon: Icons.arrow_forward_rounded,
                      variant: ButtonVariant.outline,
                      isFullWidth: true,
                      onPressed: onViewAllPackages,
                    ),
                  ],
                );
              }

              // Desktop: 3-column / 4-column responsive grid
              final int crossAxisCount = constraints.maxWidth > 1150 ? 3 : 2;
              final double cardWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 24)) / crossAxisCount;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: packages.take(6).map((pkg) {
                  return SizedBox(
                    width: cardWidth,
                    child: PackageCard(
                      package: pkg,
                      onViewPackage: () => onSelectPackage(pkg),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
