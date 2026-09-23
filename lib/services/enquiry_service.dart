import 'package:flutter/foundation.dart';
import '../models/enquiry_model.dart';

class EnquiryService extends ChangeNotifier {
  static final EnquiryService _instance = EnquiryService._internal();
  factory EnquiryService() => _instance;
  EnquiryService._internal();

  final List<EnquiryModel> _enquiries = [];

  List<EnquiryModel> get enquiries => List.unmodifiable(_enquiries);

  /// Submits an enquiry. Prepared for Cloud Firestore integration:
  /// e.g. FirebaseFirestore.instance.collection('enquiries').add(enquiry.toMap());
  Future<bool> submitEnquiry(EnquiryModel enquiry) async {
    try {
      // Simulate brief network delay for realism
      await Future.delayed(const Duration(milliseconds: 600));

      final newEnquiry = EnquiryModel(
        id: 'ENQ-${DateTime.now().millisecondsSinceEpoch}',
        name: enquiry.name,
        phone: enquiry.phone,
        email: enquiry.email,
        startingLocation: enquiry.startingLocation,
        destination: enquiry.destination,
        travelDate: enquiry.travelDate,
        returnDate: enquiry.returnDate,
        numberOfTravellers: enquiry.numberOfTravellers,
        vehiclePreference: enquiry.vehiclePreference,
        tourPackage: enquiry.tourPackage,
        specialRequirements: enquiry.specialRequirements,
        createdAt: DateTime.now(),
        status: 'Pending',
      );

      _enquiries.insert(0, newEnquiry);
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error submitting enquiry: $e');
      }
      return false;
    }
  }
}
