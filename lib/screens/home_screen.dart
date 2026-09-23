import 'package:flutter/material.dart';
import '../sections/custom_tour_cta_section.dart';
import '../sections/destination_explorer_section.dart';
import '../sections/faq_section.dart';
import '../sections/fleet_showcase_section.dart';
import '../sections/footer_section.dart';
import '../sections/gallery_preview_section.dart';
import '../sections/hero_section.dart';
import '../sections/popular_packages_section.dart';
import '../sections/quick_enquiry_section.dart';
import '../sections/quick_trust_section.dart';
import '../sections/testimonials_section.dart';
import '../sections/travel_timeline_section.dart';
import '../sections/travel_types_section.dart';
import '../sections/vehicle_comparison_section.dart';
import '../sections/why_travel_with_us_section.dart';
import '../utils/seo_helper.dart';
import '../widgets/app_drawer.dart';
import '../widgets/floating_whatsapp_button.dart';
import '../widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  final Function(String route, {Map<String, dynamic>? arguments}) onNavigate;

  const HomeScreen({
    super.key,
    required this.onNavigate,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    SeoHelper.setTitle('Home - India Tour Packages & Tourist Traveller Hire');
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        activeRoute: '/',
        onNavigate: (route) => widget.onNavigate(route),
      ),
      body: Stack(
        children: [
          // Main Scrollable Body
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // 1. Hero Section
                HeroSection(
                  onExploreTours: () => widget.onNavigate('/packages'),
                  onPlanTrip: () => widget.onNavigate('/booking'),
                ),

                // 2. Quick Trust Strip (Immediately below hero)
                const QuickTrustSection(),

                // 3. Featured Tour Packages
                PopularPackagesSection(
                  onSelectPackage: (pkg) => widget.onNavigate(
                    '/package-details',
                    arguments: {'packageId': pkg.id},
                  ),
                  onViewAllPackages: () => widget.onNavigate('/packages'),
                ),

                // 4. Fleet Section (16, 18 Traveller & 26 Bus)
                FleetShowcaseSection(
                  onEnquireVehicle: (vehicle) => widget.onNavigate(
                    '/booking',
                    arguments: {'vehicle': vehicle.name},
                  ),
                  onViewFullFleet: () => widget.onNavigate('/fleet'),
                ),

                // 5. Vehicle Comparison Table
                VehicleComparisonSection(
                  onChooseVehicle: (vehicle) => widget.onNavigate(
                    '/booking',
                    arguments: {'vehicle': vehicle.name},
                  ),
                ),

                // 6. Destination Explorer (North, South, West, East, Northeast)
                DestinationExplorerSection(
                  onSelectDestination: (dest) => widget.onNavigate(
                    '/packages',
                    arguments: {'region': dest.region},
                  ),
                  onViewAllDestinations: () => widget.onNavigate('/destinations'),
                ),

                // 7. Why Travel With Us (6 features)
                const WhyTravelWithUsSection(),

                // 8. Travel Experience Timeline (01 to 05 Road trip steps)
                const TravelTimelineSection(),

                // 9. Custom Tour CTA ("Your Trip. Your Route. Your Way.")
                CustomTourCtaSection(
                  onCreateTrip: () => widget.onNavigate('/booking'),
                ),

                // 10. Travel Types (Family, Friends, Corporate, College...)
                TravelTypesSection(
                  onSelectType: (type) => widget.onNavigate('/booking'),
                ),

                // 11. Gallery Preview Section
                GalleryPreviewSection(
                  onViewFullGallery: () => widget.onNavigate('/gallery'),
                ),

                // 12. Customer Testimonials / Reviews (5-star ratings)
                const TestimonialsSection(),

                // 13. Expandable FAQ Accordion
                const FaqSection(),

                // 14. Booking / Quick Enquiry Form
                const QuickEnquirySection(),

                // 15. Premium Dark Footer
                FooterSection(
                  onNavigate: (route) => widget.onNavigate(route),
                ),
              ],
            ),
          ),

          // Sticky Navbar Over Hero (Transparent -> Solid on scroll)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              isScrolled: _isScrolled,
              activeRoute: '/',
              onNavigate: (route) => widget.onNavigate(route),
              onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),

          // Floating WhatsApp CTA with pre-filled message
          const FloatingWhatsAppButton(),
        ],
      ),
    );
  }
}
