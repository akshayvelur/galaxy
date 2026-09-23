import 'package:flutter/material.dart';
import '../sections/footer_section.dart';
import '../sections/quick_enquiry_section.dart';
import '../services/whatsapp_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../utils/seo_helper.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/floating_whatsapp_button.dart';
import '../widgets/navbar.dart';

class ContactScreen extends StatefulWidget {
  final Function(String route, {Map<String, dynamic>? arguments}) onNavigate;

  const ContactScreen({
    super.key,
    required this.onNavigate,
  });

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SeoHelper.setTitle('Contact Us - Booking & 24/7 Road Trip Assistance');
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        activeRoute: '/contact',
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
                          '24/7 CUSTOMER CONCIERGE',
                          style: AppTypography.badgeText.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Get in Touch With Galaxy',
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
                          'Have a question regarding vehicle capacity, interstate permits, or need an immediate custom quote? Our travel specialists are available 7 days a week.',
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyLarge.copyWith(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),

                // Contact Cards & Details
                Container(
                  width: double.infinity,
                  color: AppColors.background,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 60,
                  ),
                  child: Column(
                    children: [
                      // 3 Contact Info Cards (Call, WhatsApp, Directions)
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = 3;
                          if (constraints.maxWidth < 650) {
                            crossAxisCount = 1;
                          } else if (constraints.maxWidth < 1000) {
                            crossAxisCount = 2;
                          }

                          final cardWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 20)) / crossAxisCount;

                          return Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              // Card 1: Call
                              _buildContactActionCard(
                                cardWidth: cardWidth,
                                icon: Icons.phone_in_talk_rounded,
                                title: 'Call Travel Team',
                                info: '${AppConstants.primaryPhone}\n${AppConstants.secondaryPhone}',
                                buttonText: 'Call Now',
                                onAction: () => WhatsAppService.makePhoneCall(),
                              ),
                              // Card 2: WhatsApp
                              _buildContactActionCard(
                                cardWidth: cardWidth,
                                icon: Icons.chat_rounded,
                                title: 'WhatsApp Chat',
                                info: 'Fast response within 5-10 minutes\nPre-filled route quotations',
                                buttonText: 'WhatsApp',
                                onAction: () => WhatsAppService.launchWhatsApp(),
                              ),
                              // Card 3: Directions
                              _buildContactActionCard(
                                cardWidth: cardWidth,
                                icon: Icons.map_rounded,
                                title: 'Main Office',
                                info: AppConstants.mainOffice,
                                buttonText: 'Get Directions',
                                onAction: () => WhatsAppService.openMapLocation(),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 50),

                      // Google Maps Placeholder & Working Hours Card
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final isNarrow = constraints.maxWidth < 850;

                            final mapWidget = Container(
                              height: 320,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://images.unsplash.com/photo-1524492412937-b28074a5d7da?q=80&w=1200&auto=format&fit=crop',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.place_rounded, color: Colors.redAccent, size: 24),
                                          const SizedBox(width: 8),
                                          Text('Gateway Towers, Delhi & Kochi Hubs', style: AppTypography.titleMedium.copyWith(fontSize: 14)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            final hoursWidget = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Operational Hours', style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.w800)),
                                const SizedBox(height: 12),
                                _buildHourRow('Monday – Friday', '7:00 AM – 11:00 PM'),
                                _buildHourRow('Saturday – Sunday', '7:00 AM – 11:00 PM'),
                                _buildHourRow('Active On-Trip Chauffeur SOS', '24 Hours / 7 Days'),
                                const SizedBox(height: 20),
                                const Divider(),
                                const SizedBox(height: 16),
                                Text('Direct Inquiries', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                                const SizedBox(height: 6),
                                Text('Bookings: ${AppConstants.email}', style: AppTypography.bodySmall),
                                Text('Support: ${AppConstants.supportEmail}', style: AppTypography.bodySmall),
                              ],
                            );

                            if (isNarrow) {
                              return Column(
                                children: [
                                  mapWidget,
                                  const SizedBox(height: 28),
                                  hoursWidget,
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(flex: 6, child: mapWidget),
                                const SizedBox(width: 36),
                                Expanded(flex: 5, child: hoursWidget),
                              ],
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 60),

                      // Enquiry Form
                      const QuickEnquirySection(),
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
              activeRoute: '/contact',
              onNavigate: (route) => widget.onNavigate(route),
              onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),

          const FloatingWhatsAppButton(),
        ],
      ),
    );
  }

  Widget _buildContactActionCard({
    required double cardWidth,
    required IconData icon,
    required String title,
    required String info,
    required String buttonText,
    required VoidCallback onAction,
  }) {
    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.secondary, size: 26),
          ),
          const SizedBox(height: 18),
          Text(title, style: AppTypography.headlineSmall.copyWith(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(info, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary, height: 1.5)),
          const SizedBox(height: 20),
          CustomButton(
            text: buttonText,
            variant: ButtonVariant.primary,
            isFullWidth: true,
            onPressed: onAction,
          ),
        ],
      ),
    );
  }

  Widget _buildHourRow(String days, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(days, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
          Text(time, style: AppTypography.bodySmall.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
