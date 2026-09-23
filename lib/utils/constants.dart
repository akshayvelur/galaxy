class AppConstants {
  // Brand
  static const String appName = 'Galaxy';
  static const String appTagline = 'Premium Indian Road Trips & Group Tours';
  static const String appSubtitle =
      'Specialized tourist transportation with 16-seat, 18-seat Travellers and 26-seat luxury tourist buses across all India destinations.';

  // Contact Information (Configured centrally)
  static const String primaryPhone = '+91 98470 12345';
  static const String secondaryPhone = '+91 94460 67890';
  static const String rawPhoneNumber = '919847012345'; // For direct tel:
  static const String rawWhatsAppNumber = '919847012345'; // For WhatsApp API
  static const String email = 'bookings@galaxytravels.com';
  static const String supportEmail = 'support@galaxytravels.com';
  
  // Locations
  static const String mainOffice =
      'Galaxy Hub, Ground Floor, Gateway Expressway, Kochi & New Delhi, India';
  static const String workingHours = 'Monday – Sunday: 7:00 AM – 11:00 PM (24/7 On-Trip Assistance)';

  // Social URLs
  static const String instagramUrl = 'https://instagram.com';
  static const String facebookUrl = 'https://facebook.com';
  static const String youtubeUrl = 'https://youtube.com';

  // Default WhatsApp Messages
  static const String defaultWhatsAppMessage =
      'Hello Galaxy! I am interested in your tour packages and tourist vehicle hire. I would like to know more about availability and pricing.';

  static String packageWhatsAppMessage(String packageName) =>
      'Hello Galaxy! I am interested in booking the "$packageName" tour package. Could you please share the detailed itinerary and quote?';

  static String vehicleWhatsAppMessage(String vehicleName) =>
      'Hello Galaxy! I am looking to hire the $vehicleName for our upcoming trip across India. Please provide availability and rate details.';

  // Max content width
  static const double maxContentWidth = 1240.0;
}
