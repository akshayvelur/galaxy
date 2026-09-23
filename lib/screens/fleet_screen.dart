import 'package:flutter/material.dart';
import '../data/fleet_data.dart';
import '../models/vehicle.dart';
import '../sections/footer_section.dart';
import '../sections/vehicle_comparison_section.dart';
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

class FleetScreen extends StatefulWidget {
  final Function(String route, {Map<String, dynamic>? arguments}) onNavigate;

  const FleetScreen({
    super.key,
    required this.onNavigate,
  });

  @override
  State<FleetScreen> createState() => _FleetScreenState();
}

class _FleetScreenState extends State<FleetScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SeoHelper.setTitle('Fleet - 16, 18 Seat Traveller & 26 Seat Tourist Bus Rental');
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final bool isMobile = Responsive.isMobile(context);
    final vehicles = FleetData.vehicles;

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        activeRoute: '/fleet',
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
                          'PREMIUM COMMERCIAL FLEET',
                          style: AppTypography.badgeText.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Travel Together. Travel Comfortably.',
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
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: Text(
                          'Our fleet consists strictly of modern, commercial tourist-permit vehicles featuring high-back executive recliners, powerful multi-vent AC, generous luggage bays, and veteran highway chauffeurs.',
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyLarge.copyWith(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),

                // Vehicle Detailed Showcases
                Container(
                  width: double.infinity,
                  color: AppColors.background,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 60,
                  ),
                  child: Column(
                    children: vehicles.asMap().entries.map((entry) {
                      final index = entry.key;
                      final vehicle = entry.value;
                      final isEven = index % 2 == 0;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: _buildVehicleDetailedCard(vehicle, isEven, isMobile),
                      );
                    }).toList(),
                  ),
                ),

                // Comparison Matrix
                VehicleComparisonSection(
                  onChooseVehicle: (vehicle) => widget.onNavigate(
                    '/booking',
                    arguments: {'vehicle': vehicle.name},
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
              activeRoute: '/fleet',
              onNavigate: (route) => widget.onNavigate(route),
              onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),

          const FloatingWhatsAppButton(),
        ],
      ),
    );
  }

  Widget _buildVehicleDetailedCard(Vehicle vehicle, bool isEven, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isNarrow = constraints.maxWidth < 950;

            final Widget imageWidget = Stack(
              children: [
                SizedBox(
                  height: isNarrow ? 280 : 420,
                  width: double.infinity,
                  child: Image.network(
                    vehicle.heroImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: BadgePill(
                    text: '${vehicle.seatCount} SEATS',
                    backgroundColor: AppColors.secondary,
                    textColor: Colors.white,
                    icon: Icons.airline_seat_recline_extra_rounded,
                  ),
                ),
              ],
            );

            final Widget infoWidget = Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    vehicle.category,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    vehicle.name.toUpperCase(),
                    style: AppTypography.headlineMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    vehicle.fullDescription,
                    style: AppTypography.bodyMedium.copyWith(height: 1.6),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Vehicle Specifications:',
                    style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  ...vehicle.keyFeatures.map((feat) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle_outline, size: 16, color: AppColors.success),
                            const SizedBox(width: 8),
                            Expanded(child: Text(feat, style: AppTypography.bodySmall)),
                          ],
                        ),
                      )),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    children: [
                      CustomButton(
                        text: 'Enquire for ${vehicle.name}',
                        icon: Icons.send_rounded,
                        variant: ButtonVariant.primary,
                        onPressed: () => widget.onNavigate(
                          '/booking',
                          arguments: {'vehicle': vehicle.name},
                        ),
                      ),
                      CustomButton(
                        text: 'WhatsApp Quote',
                        icon: Icons.chat_rounded,
                        variant: ButtonVariant.outline,
                        onPressed: () => WhatsAppService.launchWhatsApp(
                          customMessage: AppConstants.vehicleWhatsAppMessage(vehicle.name),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageWidget,
                  infoWidget,
                ],
              );
            }

            return Row(
              children: isEven
                  ? [
                      Expanded(flex: 5, child: imageWidget),
                      Expanded(flex: 6, child: infoWidget),
                    ]
                  : [
                      Expanded(flex: 6, child: infoWidget),
                      Expanded(flex: 5, child: imageWidget),
                    ],
            );
          },
        ),
      ),
    );
  }
}
