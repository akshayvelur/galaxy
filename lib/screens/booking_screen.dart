import 'package:flutter/material.dart';
import '../sections/footer_section.dart';
import '../sections/quick_enquiry_section.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../utils/seo_helper.dart';
import '../widgets/app_drawer.dart';
import '../widgets/floating_whatsapp_button.dart';
import '../widgets/navbar.dart';

class BookingScreen extends StatefulWidget {
  final Function(String route, {Map<String, dynamic>? arguments}) onNavigate;
  final String? preselectedPackage;
  final String? preselectedVehicle;

  const BookingScreen({
    super.key,
    required this.onNavigate,
    this.preselectedPackage,
    this.preselectedVehicle,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SeoHelper.setTitle('Plan Your Trip - Custom Itinerary & Vehicle Quotation');
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        activeRoute: '/booking',
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
                          'YOUR ROAD TRIP. YOUR WAY.',
                          style: AppTypography.badgeText.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Plan Your Trip Across India',
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
                          'Let us know your route, travel dates, and group size. We will configure the best 16-seat, 18-seat Traveller or 26-seat Coach with an itemized, transparent quote.',
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyLarge.copyWith(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),

                // Booking / Enquiry Form Section
                QuickEnquirySection(
                  preselectedPackage: widget.preselectedPackage,
                  preselectedVehicle: widget.preselectedVehicle,
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
              activeRoute: '/booking',
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
