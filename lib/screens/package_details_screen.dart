import 'package:flutter/material.dart';
import '../data/tour_packages_data.dart';
import '../models/tour_package.dart';
import '../sections/footer_section.dart';
import '../services/whatsapp_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../utils/seo_helper.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge_pill.dart';
import '../widgets/custom_button.dart';
import '../widgets/floating_whatsapp_button.dart';
import '../widgets/navbar.dart';

class PackageDetailsScreen extends StatefulWidget {
  final String packageId;
  final Function(String route, {Map<String, dynamic>? arguments}) onNavigate;

  const PackageDetailsScreen({
    super.key,
    required this.packageId,
    required this.onNavigate,
  });

  @override
  State<PackageDetailsScreen> createState() => _PackageDetailsScreenState();
}

class _PackageDetailsScreenState extends State<PackageDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? _expandedDay = 1;
  int? _expandedFaq;

  @override
  void initState() {
    super.initState();
    final pkg = TourPackagesData.getById(widget.packageId);
    SeoHelper.setTitle('${pkg.title} - ${pkg.duration} Tour Package');
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final bool isMobile = Responsive.isMobile(context);
    final pkg = TourPackagesData.getById(widget.packageId);

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
                // 1. Large Destination Hero Image & Package Title
                _buildHeroBanner(context, pkg, isMobile),

                // 2. Main Content & Sticky Quote Sidebar
                Container(
                  width: double.infinity,
                  color: AppColors.background,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 50,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isNarrow = constraints.maxWidth < 950;

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildOverview(pkg),
                            const SizedBox(height: 36),
                            _buildKeyDetailsCard(pkg),
                            const SizedBox(height: 36),
                            _buildItinerary(pkg),
                            const SizedBox(height: 36),
                            _buildPlacesCovered(pkg),
                            const SizedBox(height: 36),
                            _buildVehicleOptions(pkg),
                            const SizedBox(height: 36),
                            _buildHotelsAndMeals(pkg),
                            const SizedBox(height: 36),
                            _buildInclusionsExclusions(pkg),
                            const SizedBox(height: 36),
                            _buildImportantNotes(pkg),
                            const SizedBox(height: 36),
                            _buildPackageGallery(pkg),
                            const SizedBox(height: 36),
                            _buildPackageFaqs(pkg),
                          ],
                        );
                      }

                      // Desktop: Left side details (flex 7), Right side sticky booking summary (flex 3)
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildOverview(pkg),
                                const SizedBox(height: 40),
                                _buildItinerary(pkg),
                                const SizedBox(height: 40),
                                _buildPlacesCovered(pkg),
                                const SizedBox(height: 40),
                                _buildVehicleOptions(pkg),
                                const SizedBox(height: 40),
                                _buildHotelsAndMeals(pkg),
                                const SizedBox(height: 40),
                                _buildInclusionsExclusions(pkg),
                                const SizedBox(height: 40),
                                _buildImportantNotes(pkg),
                                const SizedBox(height: 40),
                                _buildPackageGallery(pkg),
                                const SizedBox(height: 40),
                                _buildPackageFaqs(pkg),
                              ],
                            ),
                          ),
                          const SizedBox(width: 36),
                          Expanded(
                            flex: 3,
                            child: _buildKeyDetailsCard(pkg),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // 3. Bottom CTA Banner ("Interested in this Trip?")
                _buildInterestedCtaBanner(pkg, isMobile),

                // 4. Footer
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

  Widget _buildHeroBanner(BuildContext context, TourPackage pkg, bool isMobile) {
    final double horizontalPadding = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      height: isMobile ? 440 : 540,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(pkg.heroImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.black.withOpacity(0.4),
              Colors.black.withOpacity(0.85),
            ],
          ),
        ),
        padding: EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          top: 130,
          bottom: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (pkg.badge != null)
                  BadgePill(
                    text: pkg.badge!,
                    backgroundColor: AppColors.secondary,
                    textColor: Colors.white,
                  ),
                const SizedBox(width: 10),
                BadgePill(
                  text: pkg.region,
                  backgroundColor: Colors.white24,
                  textColor: Colors.white,
                  icon: Icons.map,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              pkg.title,
              style: (isMobile
                      ? AppTypography.displayMedium
                      : AppTypography.displayLarge)
                  .copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.place_outlined, color: AppColors.accent, size: 18),
                const SizedBox(width: 6),
                Text(
                  pkg.destination,
                  style: AppTypography.titleMedium.copyWith(color: Colors.white),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.schedule, color: AppColors.accent, size: 18),
                const SizedBox(width: 6),
                Text(
                  pkg.duration,
                  style: AppTypography.titleMedium.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverview(TourPackage pkg) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tour Overview', style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          Text(pkg.overview, style: AppTypography.bodyLarge.copyWith(height: 1.7)),
          const SizedBox(height: 24),
          Text('Key Highlights', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Column(
            children: pkg.highlights.map((h) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, color: AppColors.secondary, size: 18),
                    const SizedBox(width: 10),
                    Expanded(child: Text(h, style: AppTypography.bodyMedium)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyDetailsCard(TourPackage pkg) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.secondary.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Starting from', style: AppTypography.bodySmall),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('Best Price', style: AppTypography.badgeText.copyWith(color: AppColors.success)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            pkg.startingPrice,
            style: AppTypography.displayMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text('per person (inclusive of vehicle & hotel)', style: AppTypography.bodySmall),
          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 20),
          _buildInfoBullet(Icons.schedule, 'Duration', pkg.duration),
          _buildInfoBullet(Icons.hotel_outlined, 'Accommodation', '3-Star / 4-Star Resort'),
          _buildInfoBullet(Icons.directions_bus_outlined, 'Vehicle', 'Private AC Traveller / Coach'),
          _buildInfoBullet(Icons.restaurant_outlined, 'Meals', 'Daily Buffet Breakfast'),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Send Enquiry for this Tour',
            icon: Icons.send_rounded,
            variant: ButtonVariant.primary,
            isFullWidth: true,
            height: 50,
            onPressed: () => widget.onNavigate(
              '/booking',
              arguments: {'package': pkg.title},
            ),
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: 'Instant WhatsApp Quote',
            icon: Icons.chat_bubble_rounded,
            variant: ButtonVariant.outline,
            isFullWidth: true,
            height: 50,
            onPressed: () => WhatsAppService.launchWhatsApp(
              customMessage: AppConstants.packageWhatsAppMessage(pkg.title),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBullet(IconData icon, String title, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.secondary),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.bodySmall.copyWith(fontSize: 11)),
              Text(val, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItinerary(TourPackage pkg) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Day-by-Day Itinerary', style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 20),
          ...pkg.itinerary.map((day) {
            final isExpanded = _expandedDay == day.dayNumber;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isExpanded ? AppColors.background : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isExpanded ? AppColors.secondary.withOpacity(0.4) : AppColors.border,
                ),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  initiallyExpanded: isExpanded,
                  leading: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'DAY ${day.dayNumber}',
                      style: AppTypography.badgeText.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                  title: Text(
                    day.title,
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  onExpansionChanged: (exp) {
                    setState(() => _expandedDay = exp ? day.dayNumber : null);
                  },
                  childrenPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 18),
                  children: [
                    Text(day.description, style: AppTypography.bodyMedium.copyWith(height: 1.6)),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: day.activities.map((act) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text('• $act', style: AppTypography.bodySmall),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.hotel_outlined, size: 14, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text('Overnight in ${day.stayCity}', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(width: 16),
                        const Icon(Icons.restaurant_outlined, size: 14, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(day.meals, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPlacesCovered(TourPackage pkg) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Places Covered', style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: pkg.placesCovered.map((place) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondary.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.place_rounded, size: 16, color: AppColors.secondary),
                    const SizedBox(width: 8),
                    Text(place, style: AppTypography.titleMedium.copyWith(fontSize: 14, fontWeight: FontWeight.w700)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleOptions(TourPackage pkg) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vehicle Options Available', style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          Column(
            children: pkg.vehicleOptions.map((v) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.directions_bus_rounded, color: AppColors.secondary, size: 24),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(v, style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                      ),
                      const Icon(Icons.check_circle_outline, color: AppColors.success, size: 18),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelsAndMeals(TourPackage pkg) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hotel & Meals Information', style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.hotel_rounded, color: AppColors.secondary, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hotel Category', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(pkg.hotelInfo, style: AppTypography.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.restaurant_menu_rounded, color: AppColors.secondary, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Meals Plan', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(pkg.mealsInfo, style: AppTypography.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInclusionsExclusions(TourPackage pkg) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Inclusions & Exclusions', style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 20),
          Text('What is Included:', style: AppTypography.titleMedium.copyWith(color: AppColors.success, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          ...pkg.inclusions.map((inc) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 16),
                    const SizedBox(width: 10),
                    Expanded(child: Text(inc, style: AppTypography.bodyMedium)),
                  ],
                ),
              )),
          const SizedBox(height: 20),
          Text('What is Excluded:', style: AppTypography.titleMedium.copyWith(color: Colors.redAccent, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          ...pkg.exclusions.map((exc) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.cancel_rounded, color: Colors.redAccent, size: 16),
                    const SizedBox(width: 10),
                    Expanded(child: Text(exc, style: AppTypography.bodyMedium)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildImportantNotes(TourPackage pkg) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_rounded, color: AppColors.warning),
              const SizedBox(width: 10),
              Text('Important Notes for Travellers', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 14),
          ...pkg.importantNotes.map((note) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text('• $note', style: AppTypography.bodyMedium),
              )),
        ],
      ),
    );
  }

  Widget _buildPackageGallery(TourPackage pkg) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tour Photo Gallery', style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final double imgWidth = (constraints.maxWidth - 24) / 2;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: pkg.galleryImages.map((img) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: constraints.maxWidth < 500 ? constraints.maxWidth : imgWidth,
                      height: 180,
                      child: Image.network(img, fit: BoxFit.cover),
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

  Widget _buildPackageFaqs(TourPackage pkg) {
    if (pkg.faqs.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Package FAQs', style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          ...pkg.faqs.asMap().entries.map((entry) {
            final idx = entry.key;
            final f = entry.value;
            final isExp = _expandedFaq == idx;

            return ExpansionTile(
              initiallyExpanded: isExp,
              title: Text(f.question, style: AppTypography.titleMedium.copyWith(fontSize: 15)),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 12),
                  child: Text(f.answer, style: AppTypography.bodyMedium),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildInterestedCtaBanner(TourPackage pkg, bool isMobile) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryDark,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        children: [
          Text(
            'Interested in this Trip?',
            style: (isMobile ? AppTypography.headlineMedium : AppTypography.displayMedium).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Get custom pricing for your group size, travel dates, and vehicle preference.',
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              CustomButton(
                text: 'Send Enquiry',
                icon: Icons.send_rounded,
                variant: ButtonVariant.primary,
                height: 52,
                fontSize: 15,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                onPressed: () => widget.onNavigate('/booking', arguments: {'package': pkg.title}),
              ),
              CustomButton(
                text: 'WhatsApp Us',
                icon: Icons.chat_rounded,
                variant: ButtonVariant.outline,
                height: 52,
                fontSize: 15,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                onPressed: () => WhatsAppService.launchWhatsApp(
                  customMessage: AppConstants.packageWhatsAppMessage(pkg.title),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
