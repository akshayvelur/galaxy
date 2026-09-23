import 'package:flutter/material.dart';
import '../sections/footer_section.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../utils/seo_helper.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/floating_whatsapp_button.dart';
import '../widgets/navbar.dart';
import '../widgets/section_header.dart';

class AboutScreen extends StatefulWidget {
  final Function(String route, {Map<String, dynamic>? arguments}) onNavigate;

  const AboutScreen({
    super.key,
    required this.onNavigate,
  });

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SeoHelper.setTitle('About Us - Premium Indian Tourist Transportation & Expeditions');
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        activeRoute: '/about',
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
                          'OUR STORY & MISSION',
                          style: AppTypography.badgeText.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Redefining Group Travel Across India',
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
                          'Galaxy was born with a single mission: to provide comfortable, safe, and truly luxurious group road trips and tourist transportation throughout India.',
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyLarge.copyWith(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),

                // Statistics Counter Strip
                Container(
                  width: double.infinity,
                  color: AppColors.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 36,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 700;
                      final List<Map<String, String>> stats = [
                        {'value': '15,000+', 'label': 'Happy Travellers'},
                        {'value': '850+', 'label': 'Tours Completed'},
                        {'value': '100%', 'label': 'AITP Licensed Fleet'},
                        {'value': '4.95 ★', 'label': 'Average Rating'},
                      ];

                      if (isNarrow) {
                        return Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.spaceAround,
                          children: stats.map((s) => _buildStat(s['value']!, s['label']!)).toList(),
                        );
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: stats.map((s) => _buildStat(s['value']!, s['label']!)).toList(),
                      );
                    },
                  ),
                ),

                // Story Content & Values
                Container(
                  width: double.infinity,
                  color: AppColors.background,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 70,
                  ),
                  child: Column(
                    children: [
                      // Story Section
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isNarrow = constraints.maxWidth < 950;
                          final Widget textCol = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SectionHeader(
                                kicker: 'Built for the Open Road',
                                title: 'Not Just a Bus Operator. A Travel Partner.',
                                isCentered: false,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Most bus operators treat road travel as merely moving passengers from point A to point B. At Galaxy, we view the journey as the soul of the travel experience.',
                                style: AppTypography.bodyLarge.copyWith(height: 1.7),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'From winding mountain passes in Himachal to serene coastal coconut groves in Kerala and golden desert highways in Rajasthan, we curate your entire journey. We operate dedicated 16-Seat Force Travellers, 18-Seat Extended Travellers, and 26-Seat Luxury Tourist Buses — equipped with reclining pushback seats, twin climate control, generous luggage space, and vetted chauffeurs.',
                                style: AppTypography.bodyLarge.copyWith(height: 1.7),
                              ),
                              const SizedBox(height: 24),
                              CustomButton(
                                text: 'Plan a Custom Tour',
                                icon: Icons.explore_rounded,
                                onPressed: () => widget.onNavigate('/booking'),
                              ),
                            ],
                          );

                          final Widget imgCol = ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?q=80&w=1200&auto=format&fit=crop',
                              height: 420,
                              fit: BoxFit.cover,
                            ),
                          );

                          if (isNarrow) {
                            return Column(
                              children: [
                                imgCol,
                                const SizedBox(height: 36),
                                textCol,
                              ],
                            );
                          }

                          return Row(
                            children: [
                              Expanded(flex: 6, child: textCol),
                              const SizedBox(width: 48),
                              Expanded(flex: 5, child: imgCol),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 80),

                      // Safety & Standards Strip
                      const SectionHeader(
                        kicker: 'Our Commitment',
                        title: 'Safety & Chauffeur Standards',
                        subtitle: 'Every trip is backed by rigorous vehicle maintenance and chauffeur screening.',
                      ),
                      const SizedBox(height: 40),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = 3;
                          if (constraints.maxWidth < 650) {
                            crossAxisCount = 1;
                          } else if (constraints.maxWidth < 1000) {
                            crossAxisCount = 2;
                          }

                          final cardWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 20)) / crossAxisCount;

                          final List<Map<String, dynamic>> standards = [
                            {
                              'title': 'Vetted Highway Chauffeurs',
                              'desc': 'Our drivers hold commercial licenses with at least 8 years of interstate highway and ghat road driving experience.',
                              'icon': Icons.badge_rounded,
                            },
                            {
                              'title': '100% Commercial Permits',
                              'desc': 'Every traveller and coach operates with legitimate All India Tourist Permits (AITP) and comprehensive passenger insurance.',
                              'icon': Icons.security_rounded,
                            },
                            {
                              'title': 'Pre-Trip Vehicle Audit',
                              'desc': 'Brakes, tyre tread, suspension, cooling systems, and emergency equipment are inspected prior to every departure.',
                              'icon': Icons.car_repair_rounded,
                            },
                          ];

                          return Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: standards.map((s) {
                              return Container(
                                width: cardWidth,
                                padding: const EdgeInsets.all(26),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(s['icon'] as IconData, size: 36, color: AppColors.secondary),
                                    const SizedBox(height: 16),
                                    Text(s['title'] as String, style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 8),
                                    Text(s['desc'] as String, style: AppTypography.bodySmall.copyWith(height: 1.5)),
                                  ],
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
              activeRoute: '/about',
              onNavigate: (route) => widget.onNavigate(route),
              onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),

          const FloatingWhatsAppButton(),
        ],
      ),
    );
  }

  Widget _buildStat(String val, String label) {
    return Column(
      children: [
        Text(
          val,
          style: AppTypography.headlineLarge.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
