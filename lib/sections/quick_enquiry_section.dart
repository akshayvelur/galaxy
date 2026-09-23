import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/fleet_data.dart';
import '../data/tour_packages_data.dart';
import '../models/enquiry_model.dart';
import '../services/enquiry_service.dart';
import '../services/whatsapp_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/section_header.dart';

class QuickEnquirySection extends StatefulWidget {
  final String? preselectedPackage;
  final String? preselectedVehicle;

  const QuickEnquirySection({
    super.key,
    this.preselectedPackage,
    this.preselectedVehicle,
  });

  @override
  State<QuickEnquirySection> createState() => _QuickEnquirySectionState();
}

class _QuickEnquirySectionState extends State<QuickEnquirySection> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _startLocationController = TextEditingController();
  final _destinationController = TextEditingController();
  final _specialReqController = TextEditingController();

  DateTime? _travelDate;
  DateTime? _returnDate;
  int _travellers = 14;
  String _vehiclePreference = '18 Seat Traveller';
  String _selectedPackage = 'Customized Itinerary';

  bool _isSubmitting = false;
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    if (widget.preselectedVehicle != null) {
      _vehiclePreference = widget.preselectedVehicle!;
    }
    if (widget.preselectedPackage != null) {
      _selectedPackage = widget.preselectedPackage!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _startLocationController.dispose();
    _destinationController.dispose();
    _specialReqController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(bool isReturn) async {
    final now = DateTime.now();
    final initialDate = isReturn
        ? (_travelDate != null ? _travelDate!.add(const Duration(days: 4)) : now.add(const Duration(days: 10)))
        : now.add(const Duration(days: 7));

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.secondary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isReturn) {
          _returnDate = picked;
        } else {
          _travelDate = picked;
        }
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    final enquiry = EnquiryModel(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      startingLocation: _startLocationController.text.trim(),
      destination: _destinationController.text.trim(),
      travelDate: _travelDate,
      returnDate: _returnDate,
      numberOfTravellers: _travellers,
      vehiclePreference: _vehiclePreference,
      tourPackage: _selectedPackage,
      specialRequirements: _specialReqController.text.trim(),
    );

    await EnquiryService().submitEnquiry(enquiry);

    setState(() {
      _isSubmitting = false;
      _isSubmitted = true;
    });
  }

  void _resetForm() {
    setState(() {
      _isSubmitted = false;
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _startLocationController.clear();
      _destinationController.clear();
      _specialReqController.clear();
      _travelDate = null;
      _returnDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 80,
      ),
      child: Column(
        children: [
          const SectionHeader(
            kicker: 'Fast Quotation',
            title: 'Request a Detailed Tour & Vehicle Quote',
            subtitle:
                'Fill in your trip details below. Our travel experts will calculate the optimal route, recommend vehicle options, and send an itemized quote.',
          ),
          const SizedBox(height: 48),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.04),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: _isSubmitted ? _buildSuccessView() : _buildFormView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle_rounded,
            color: AppColors.success,
            size: 64,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Enquiry Submitted Successfully!',
          style: AppTypography.headlineMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Thank you! Our travel team will contact you shortly.',
          textAlign: TextAlign.center,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We have received your group travel itinerary and vehicle preference. A dedicated tour coordinator will prepare your quotation within 15 minutes.',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            CustomButton(
              text: 'Connect on WhatsApp Now',
              icon: Icons.chat_rounded,
              variant: ButtonVariant.primary,
              onPressed: () => WhatsAppService.launchWhatsApp(
                customMessage: 'Hello Galaxy! I have just submitted an enquiry for ${_destinationController.text.isNotEmpty ? _destinationController.text : "India Tour"}. Please check and provide the quote.',
              ),
            ),
            CustomButton(
              text: 'Submit Another Enquiry',
              variant: ButtonVariant.outline,
              onPressed: _resetForm,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Name & Phone
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isNarrow = constraints.maxWidth < 600;

              if (isNarrow) {
                return Column(
                  children: [
                    _buildNameField(),
                    const SizedBox(height: 16),
                    _buildPhoneField(),
                    const SizedBox(height: 16),
                    _buildEmailField(),
                  ],
                );
              }

              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildNameField()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildPhoneField()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildEmailField(),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Row 2: Starting Location & Destination
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isNarrow = constraints.maxWidth < 600;

              if (isNarrow) {
                return Column(
                  children: [
                    _buildStartLocationField(),
                    const SizedBox(height: 16),
                    _buildDestinationField(),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: _buildStartLocationField()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDestinationField()),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Row 3: Travel Date & Return Date
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isNarrow = constraints.maxWidth < 600;

              if (isNarrow) {
                return Column(
                  children: [
                    _buildDateField(false),
                    const SizedBox(height: 16),
                    _buildDateField(true),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: _buildDateField(false)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDateField(true)),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Row 4: Number of Travellers, Vehicle Preference & Tour Package
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isNarrow = constraints.maxWidth < 700;

              if (isNarrow) {
                return Column(
                  children: [
                    _buildTravellersDropdown(),
                    const SizedBox(height: 16),
                    _buildVehicleDropdown(),
                    const SizedBox(height: 16),
                    _buildPackageDropdown(),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(flex: 2, child: _buildTravellersDropdown()),
                  const SizedBox(width: 14),
                  Expanded(flex: 3, child: _buildVehicleDropdown()),
                  const SizedBox(width: 14),
                  Expanded(flex: 3, child: _buildPackageDropdown()),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Special Requirements
          Text('Special Requirements & Route Notes', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          TextFormField(
            controller: _specialReqController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'e.g., Senior citizen friendly stops, rooftop luggage carrier needed, specific hotel requirements...',
            ),
          ),
          const SizedBox(height: 28),

          // Submit Button: "Request a Quote"
          CustomButton(
            text: _isSubmitting ? 'Submitting Enquiry...' : 'Request a Quote',
            icon: Icons.send_rounded,
            variant: ButtonVariant.primary,
            isFullWidth: true,
            height: 52,
            fontSize: 16,
            onPressed: _isSubmitting ? null : _submitForm,
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Full Name *', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        TextFormField(
          controller: _nameController,
          validator: (v) => (v == null || v.isEmpty) ? 'Please enter your name' : null,
          decoration: const InputDecoration(
            hintText: 'e.g. Ramesh Kumar',
            prefixIcon: Icon(Icons.person_outline, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone Number (WhatsApp) *', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          validator: (v) => (v == null || v.length < 8) ? 'Enter a valid phone number' : null,
          decoration: const InputDecoration(
            hintText: '+91 98470 XXXXX',
            prefixIcon: Icon(Icons.phone_outlined, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email Address *', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
          decoration: const InputDecoration(
            hintText: 'name@example.com',
            prefixIcon: Icon(Icons.email_outlined, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildStartLocationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Starting Location / City *', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        TextFormField(
          controller: _startLocationController,
          validator: (v) => (v == null || v.isEmpty) ? 'Please specify starting point' : null,
          decoration: const InputDecoration(
            hintText: 'e.g. Cochin, Delhi, Bangalore',
            prefixIcon: Icon(Icons.trip_origin_rounded, size: 20, color: AppColors.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Destination / Circuit *', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        TextFormField(
          controller: _destinationController,
          validator: (v) => (v == null || v.isEmpty) ? 'Please specify destination' : null,
          decoration: const InputDecoration(
            hintText: 'e.g. Munnar, Manali, Rajasthan',
            prefixIcon: Icon(Icons.place_outlined, size: 20, color: AppColors.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(bool isReturn) {
    final date = isReturn ? _returnDate : _travelDate;
    final label = isReturn ? 'Return Date' : 'Travel Date *';
    final dateStr = date != null ? DateFormat('dd MMM yyyy').format(date) : 'Select Date';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        InkWell(
          onTap: () => _pickDate(isReturn),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_month_outlined, size: 20, color: AppColors.secondary),
                const SizedBox(width: 10),
                Text(
                  dateStr,
                  style: AppTypography.bodyMedium.copyWith(
                    color: date != null ? AppColors.textPrimary : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTravellersDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Number of Travellers', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _travellers,
              isExpanded: true,
              items: [4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 30].map((c) {
                return DropdownMenuItem<int>(
                  value: c,
                  child: Text('$c Persons', style: AppTypography.bodyMedium),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _travellers = val);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleDropdown() {
    final vehicleNames = FleetData.vehicles.map((v) => v.name).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Vehicle Preference', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _vehiclePreference,
              isExpanded: true,
              items: vehicleNames.map((v) {
                return DropdownMenuItem<String>(
                  value: v,
                  child: Text(v, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTypography.bodyMedium),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _vehiclePreference = val);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPackageDropdown() {
    final packageTitles = ['Customized Itinerary', ...TourPackagesData.packages.map((p) => p.title)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tour Package', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: packageTitles.contains(_selectedPackage) ? _selectedPackage : packageTitles.first,
              isExpanded: true,
              items: packageTitles.map((p) {
                return DropdownMenuItem<String>(
                  value: p,
                  child: Text(p, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTypography.bodyMedium),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedPackage = val);
              },
            ),
          ),
        ),
      ],
    );
  }
}
