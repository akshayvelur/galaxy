import 'package:flutter/material.dart';
import '../services/whatsapp_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';

class FooterSection extends StatelessWidget {
  final Function(String route) onNavigate;

  const FooterSection({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      color: AppColors.primaryDark,
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        top: 80,
        bottom: 30,
      ),
      child: Column(
        children: [
          // Multi-Column Grid
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 750) {
                // Stack vertically on mobile
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCompanyColumn(),
                    const SizedBox(height: 36),
                    _buildLinksColumn('Tours', [
                      {'label': 'Kerala Explorer (5D/4N)', 'route': '/packages'},
                      {'label': 'Rajasthan Heritage (7D/6N)', 'route': '/packages'},
                      {'label': 'Kashmir Paradise (6D/5N)', 'route': '/packages'},
                      {'label': 'Himachal Adventure (7D/6N)', 'route': '/packages'},
                      {'label': 'Tamil Nadu Temples (5D/4N)', 'route': '/packages'},
                      {'label': 'Northeast Explorer (8D/7N)', 'route': '/packages'},
                    ]),
                    const SizedBox(height: 36),
                    _buildLinksColumn('Fleet', [
                      {'label': '16 Seat Force Traveller', 'route': '/fleet'},
                      {'label': '18 Seat Extended Traveller', 'route': '/fleet'},
                      {'label': '26 Seat Tourist Coach Bus', 'route': '/fleet'},
                      {'label': 'Vehicle Comparison', 'route': '/fleet'},
                      {'label': 'Fleet Safety Standards', 'route': '/about'},
                    ]),
                    const SizedBox(height: 36),
                    _buildLinksColumn('Destinations', [
                      {'label': 'North India Tours', 'route': '/destinations'},
                      {'label': 'South India Circuits', 'route': '/destinations'},
                      {'label': 'West India & Rajasthan', 'route': '/destinations'},
                      {'label': 'Northeast India Holidays', 'route': '/destinations'},
                    ]),
                    const SizedBox(height: 36),
                    _buildSupportColumn(),
                    const SizedBox(height: 36),
                    _buildContactColumn(),
                  ],
                );
              }

              // Desktop: Multi-column horizontal distribution
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildCompanyColumn()),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 2,
                    child: _buildLinksColumn('Tours', [
                      {'label': 'Kerala Explorer', 'route': '/packages'},
                      {'label': 'Rajasthan Heritage', 'route': '/packages'},
                      {'label': 'Kashmir Paradise', 'route': '/packages'},
                      {'label': 'Himachal Adventure', 'route': '/packages'},
                      {'label': 'Tamil Nadu Temples', 'route': '/packages'},
                      {'label': 'Northeast Explorer', 'route': '/packages'},
                    ]),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: _buildLinksColumn('Fleet', [
                      {'label': '16 Seat Traveller', 'route': '/fleet'},
                      {'label': '18 Seat Traveller', 'route': '/fleet'},
                      {'label': '26 Seat Tourist Bus', 'route': '/fleet'},
                      {'label': 'Vehicle Comparison', 'route': '/fleet'},
                      {'label': 'Safety & Chauffeurs', 'route': '/about'},
                    ]),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: _buildLinksColumn('Destinations', [
                      {'label': 'North India', 'route': '/destinations'},
                      {'label': 'South India', 'route': '/destinations'},
                      {'label': 'West India', 'route': '/destinations'},
                      {'label': 'East & Northeast', 'route': '/destinations'},
                    ]),
                  ),
                  const SizedBox(width: 24),
                  Expanded(flex: 2, child: _buildSupportColumn()),
                  const SizedBox(width: 24),
                  Expanded(flex: 3, child: _buildContactColumn()),
                ],
              );
            },
          ),
          const SizedBox(height: 60),
          const Divider(color: Colors.white12),
          const SizedBox(height: 24),

          // Bottom Bar with Copyright and Social Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2026 Galaxy Travels & Expeditions. All Rights Reserved.',
                style: AppTypography.bodySmall.copyWith(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  _buildSocialIcon(Icons.camera_alt_outlined, () => WhatsAppService.launchWhatsApp()),
                  const SizedBox(width: 12),
                  _buildSocialIcon(Icons.facebook_outlined, () => WhatsAppService.launchWhatsApp()),
                  const SizedBox(width: 12),
                  _buildSocialIcon(Icons.smart_display_outlined, () => WhatsAppService.launchWhatsApp()),
                  const SizedBox(width: 12),
                  _buildSocialIcon(Icons.chat_bubble_outline_rounded, () => WhatsAppService.launchWhatsApp()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: AppColors.orangeGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.explore_rounded, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'GALAXY',
                    style: AppTypography.headlineSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(
                    text: ' TRAVELS',
                    style: AppTypography.headlineSmall.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Specialist in comfortable tourist transportation across India. Operating 16-seat, 18-seat luxury Force Travellers and 26-seat modern tourist buses with national tourist permits.',
          style: AppTypography.bodySmall.copyWith(
            color: Colors.white70,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildLinksColumn(String title, List<Map<String, String>> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: AppTypography.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () => onNavigate(link['route']!),
                child: Text(
                  link['label']!,
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildSupportColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SUPPORT',
          style: AppTypography.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 16),
        _buildSupportLink('Terms & Conditions', '/about'),
        _buildSupportLink('Privacy Policy', '/about'),
        _buildSupportLink('Cancellation Policy', '/about'),
        _buildSupportLink('Driver Vetting Rules', '/about'),
        _buildSupportLink('FAQs', '/contact'),
      ],
    );
  }

  Widget _buildSupportLink(String label, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => onNavigate(route),
        child: Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildContactColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONTACT',
          style: AppTypography.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on_outlined, size: 16, color: AppColors.secondary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                AppConstants.mainOffice,
                style: AppTypography.bodySmall.copyWith(color: Colors.white70, height: 1.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.phone_outlined, size: 16, color: AppColors.secondary),
            const SizedBox(width: 8),
            Text(AppConstants.primaryPhone, style: AppTypography.bodySmall.copyWith(color: Colors.white70)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.email_outlined, size: 16, color: AppColors.secondary),
            const SizedBox(width: 8),
            Text(AppConstants.email, style: AppTypography.bodySmall.copyWith(color: Colors.white70)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            AppConstants.workingHours,
            style: AppTypography.bodySmall.copyWith(color: AppColors.accent, fontSize: 11),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.white70),
      ),
    );
  }
}
