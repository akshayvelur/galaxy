import 'package:flutter/material.dart';
import '../data/destinations_data.dart';
import '../sections/footer_section.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../utils/seo_helper.dart';
import '../widgets/app_drawer.dart';
import '../widgets/destination_card.dart';
import '../widgets/floating_whatsapp_button.dart';
import '../widgets/navbar.dart';

class DestinationsScreen extends StatefulWidget {
  final Function(String route, {Map<String, dynamic>? arguments}) onNavigate;

  const DestinationsScreen({
    super.key,
    required this.onNavigate,
  });

  @override
  State<DestinationsScreen> createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedRegion = 'All';

  final List<String> _regions = [
    'All',
    'North India',
    'South India',
    'West India',
    'East India',
    'Northeast India',
  ];

  @override
  void initState() {
    super.initState();
    SeoHelper.setTitle('Destinations Across India - North, South, West, East & Northeast');
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final bool isMobile = Responsive.isMobile(context);
    final filtered = DestinationsData.getByRegion(_selectedRegion);

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        activeRoute: '/destinations',
        onNavigate: (route) => widget.onNavigate(route),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Header Banner
                Container(
                  width: double.infinity,
                  color: AppColors.primaryDark,
                  padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    top: 130,
                    bottom: 60,
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
                          'PAN-INDIA DESTINATIONS',
                          style: AppTypography.badgeText.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Explore the Soul of India',
                        textAlign: TextAlign.center,
                        style: (isMobile
                                ? AppTypography.headlineLarge
                                : AppTypography.displayMedium)
                            .copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 700),
                        child: Text(
                          'From the frozen beauty of Gulmarg to the spice trails of Kerala and living root bridges of Meghalaya, we provide private, comfortable group transportation across 20+ premier Indian destinations.',
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyLarge.copyWith(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),

                // Region Tabs & Grid
                Container(
                  width: double.infinity,
                  color: AppColors.background,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 50,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _regions.map((region) {
                            final isSelected = _selectedRegion == region;
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () => setState(() => _selectedRegion = region),
                                borderRadius: BorderRadius.circular(24),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.primary : Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: isSelected ? AppColors.primary : AppColors.border,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.02),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    region,
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
                      const SizedBox(height: 36),

                      Text(
                        'Showing ${filtered.length} Incredible Destinations in $_selectedRegion',
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Grid of all 20+ Destination Cards
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = 4;
                          if (constraints.maxWidth < 640) {
                            crossAxisCount = 1;
                          } else if (constraints.maxWidth < 950) {
                            crossAxisCount = 2;
                          } else if (constraints.maxWidth < 1250) {
                            crossAxisCount = 3;
                          }

                          final double cardWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 20)) / crossAxisCount;

                          return Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: filtered.map((dest) {
                              return SizedBox(
                                width: cardWidth,
                                child: DestinationCard(
                                  destination: dest,
                                  onExplore: () => widget.onNavigate(
                                    '/packages',
                                    arguments: {'region': dest.region},
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Footer
                FooterSection(onNavigate: (route) => widget.onNavigate(route)),
              ],
            ),
          ),

          // Sticky Top Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              isScrolled: true,
              activeRoute: '/destinations',
              onNavigate: (route) => widget.onNavigate(route),
              onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),

          const FloatingWhatsAppButton(),
        ],
      ),
    );
  }
}
