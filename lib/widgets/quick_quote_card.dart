import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/enquiry_model.dart';
import '../services/enquiry_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'custom_button.dart';

class QuickQuoteCard extends StatefulWidget {
  final Function(EnquiryModel enquiry)? onQuoteRequested;

  const QuickQuoteCard({
    super.key,
    this.onQuoteRequested,
  });

  @override
  State<QuickQuoteCard> createState() => _QuickQuoteCardState();
}

class _QuickQuoteCardState extends State<QuickQuoteCard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  DateTime? _selectedDate;
  int _travellers = 12;
  String _selectedVehicle = '18-Seat Traveller';
  bool _isSubmitting = false;

  final List<String> _vehicles = [
    '16-Seat Traveller',
    '18-Seat Traveller',
    '26-Seat Tourist Bus',
  ];

  @override
  void dispose() {
    _fromController.disposeWidget();
    _toController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 7)),
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
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _handleQuote() async {
    if (_fromController.text.isEmpty || _toController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter starting location and destination.'),
          backgroundColor: AppColors.secondary,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final enquiry = EnquiryModel(
      name: 'Quick Quote Visitor',
      phone: 'Pending follow-up',
      email: 'visitor@quote.com',
      startingLocation: _fromController.text.trim(),
      destination: _toController.text.trim(),
      travelDate: _selectedDate ?? DateTime.now().add(const Duration(days: 7)),
      numberOfTravellers: _travellers,
      vehiclePreference: _selectedVehicle,
      specialRequirements: 'Generated from Hero Quick Quote Card',
    );

    await EnquiryService().submitEnquiry(enquiry);
    widget.onQuoteRequested?.call(enquiry);

    setState(() => _isSubmitting = false);

    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 28),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Quote Request Received!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thank you! Our travel team will contact you shortly.',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• Route: ${_fromController.text} ➔ ${_toController.text}', style: AppTypography.bodySmall),
                    Text('• Vehicle: $_selectedVehicle', style: AppTypography.bodySmall),
                    Text('• Group Size: $_travellers Travellers', style: AppTypography.bodySmall),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('Done'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1100),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 768;

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildFromField(),
                  const SizedBox(height: 12),
                  _buildToField(),
                  const SizedBox(height: 12),
                  _buildDateField(),
                  const SizedBox(height: 12),
                  _buildTravellersDropdown(),
                  const SizedBox(height: 12),
                  _buildVehicleDropdown(),
                  const SizedBox(height: 18),
                  CustomButton(
                    text: _isSubmitting ? 'Calculating Quote...' : 'Get a Quote',
                    icon: Icons.calculate_outlined,
                    isFullWidth: true,
                    height: 50,
                    onPressed: _isSubmitting ? null : _handleQuote,
                  ),
                ],
              );
            }

            // Desktop / Wide Layout: Multi-column responsive row
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 3, child: _buildFromField()),
                    const SizedBox(width: 12),
                    Expanded(flex: 3, child: _buildToField()),
                    const SizedBox(width: 12),
                    Expanded(flex: 3, child: _buildDateField()),
                    const SizedBox(width: 12),
                    Expanded(flex: 2, child: _buildTravellersDropdown()),
                    const SizedBox(width: 12),
                    Expanded(flex: 3, child: _buildVehicleDropdown()),
                    const SizedBox(width: 14),
                    CustomButton(
                      text: _isSubmitting ? '...' : 'Get a Quote',
                      icon: Icons.bolt_rounded,
                      height: 52,
                      fontSize: 14,
                      onPressed: _isSubmitting ? null : _handleQuote,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.directions_bus_rounded, color: AppColors.secondary, size: 20),
        ),
        const SizedBox(width: 10),
        Text(
          'Quick Road Trip & Bus Quote',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 12),
              const SizedBox(width: 4),
              Text(
                'Instant Response',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFromField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('From', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: _fromController,
          decoration: InputDecoration(
            hintText: 'e.g. Delhi / Kochi',
            prefixIcon: const Icon(Icons.trip_origin_rounded, size: 18, color: AppColors.secondary),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildToField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('To', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: _toController,
          decoration: InputDecoration(
            hintText: 'e.g. Manali / Munnar',
            prefixIcon: const Icon(Icons.location_on_outlined, size: 18, color: AppColors.secondary),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    final dateStr = _selectedDate != null
        ? DateFormat('dd MMM yyyy').format(_selectedDate!)
        : 'Select Date';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Travel Date', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        InkWell(
          onTap: _pickDate,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_month_outlined, size: 18, color: AppColors.secondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    dateStr,
                    style: AppTypography.bodySmall.copyWith(
                      color: _selectedDate != null ? AppColors.textPrimary : AppColors.textMuted,
                      fontWeight: _selectedDate != null ? FontWeight.w600 : FontWeight.normal,
                    ),
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
        Text('Travellers', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _travellers,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
              items: [8, 10, 12, 14, 16, 18, 20, 22, 24, 26].map((count) {
                return DropdownMenuItem<int>(
                  value: count,
                  child: Text(
                    '$count Seats',
                    style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
                  ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Vehicle Type', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedVehicle,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
              items: _vehicles.map((v) {
                return DropdownMenuItem<String>(
                  value: v,
                  child: Text(
                    v,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedVehicle = val);
              },
            ),
          ),
        ),
      ],
    );
  }
}

extension on TextEditingController {
  void disposeWidget() {
    dispose();
  }
}
