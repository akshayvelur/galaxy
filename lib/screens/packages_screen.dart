import 'package:flutter/material.dart';
import '../data/tour_packages_data.dart';
import '../sections/footer_section.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../utils/seo_helper.dart';
import '../widgets/app_drawer.dart';
import '../widgets/floating_whatsapp_button.dart';
import '../widgets/navbar.dart';
import '../widgets/package_card.dart';

class PackagesScreen extends StatefulWidget {
  final Function(String route, {Map<String, dynamic>? arguments}) onNavigate;
  final String? initialRegion;

  const PackagesScreen({
    super.key,
    required this.onNavigate,
    this.initialRegion,
  });

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  late String _selectedRegion;

  final List<String> _regions = [
    'All',
    'South India',
    'North India',
    'West India',
    'Northeast India',
  ];

  @override
  void initState() {
    super.initState();
    SeoHelper.setTitle('Tour Packages Across India - Heritage, Hills & Backwaters');
    _selectedRegion = widget.initialRegion ?? 'All';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final bool isMobile = Responsive.isMobile(context);

    // Filter packages
    final filtered = TourPackagesData.packages.where((pkg) {
      final matchesRegion = _selectedRegion == 'All' ||
          pkg.region.toLowerCase().contains(_selectedRegion.toLowerCase());
      final matchesQuery = _searchController.text.isEmpty ||
          pkg.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          pkg.destination.toLowerCase().contains(_searchController.text.toLowerCase());
      return matchesRegion && matchesQuery;
    }).toList();

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        activeRoute: '/packages',
        onNavigate: (route) => widget.onNavigate(route),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Banner Header
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
                          'CURATED EXPEDITIONS',
                          style: AppTypography.badgeText.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Tour Packages Across India',
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
                        constraints: const BoxConstraints(maxWidth: 680),
                        child: Text(
                          'Handcrafted itineraries operated with dedicated tourist vehicles, verified drivers, vetted accommodation, and all-inclusive pricing.',
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyLarge.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),

                      // Search & Filter Box
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (_) => setState(() {}),
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search destinations (e.g. Kerala, Manali, Rajasthan)...',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            prefixIcon: const Icon(Icons.search, color: AppColors.accent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: AppColors.secondary, width: 1.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Packages Area
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
                      // Filter Tabs
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

                      // Results Count
                      Text(
                        'Showing ${filtered.length} Tour Packages',
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Package Grid
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = 3;
                          if (constraints.maxWidth < 650) {
                            crossAxisCount = 1;
                          } else if (constraints.maxWidth < 1100) {
                            crossAxisCount = 2;
                          }

                          final double cardWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 24)) / crossAxisCount;

                          if (filtered.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(48),
                                child: Column(
                                  children: [
                                    const Icon(Icons.travel_explore, size: 64, color: AppColors.textMuted),
                                    const SizedBox(height: 16),
                                    Text('No packages found matching your criteria.', style: AppTypography.headlineSmall),
                                    const SizedBox(height: 8),
                                    Text('Try adjusting your search or region filter.', style: AppTypography.bodyMedium),
                                  ],
                                ),
                              ),
                            );
                          }

                          return Wrap(
                            spacing: 24,
                            runSpacing: 24,
                            children: filtered.map((pkg) {
                              return SizedBox(
                                width: cardWidth,
                                child: PackageCard(
                                  package: pkg,
                                  onViewPackage: () => widget.onNavigate(
                                    '/package-details',
                                    arguments: {'packageId': pkg.id},
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
              activeRoute: '/packages',
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
