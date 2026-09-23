class EnquiryModel {
  final String? id;
  final String name;
  final String phone;
  final String email;
  final String startingLocation;
  final String destination;
  final DateTime? travelDate;
  final DateTime? returnDate;
  final int numberOfTravellers;
  final String vehiclePreference;
  final String? tourPackage;
  final String? specialRequirements;
  final DateTime createdAt;
  final String status;

  EnquiryModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.startingLocation,
    required this.destination,
    this.travelDate,
    this.returnDate,
    required this.numberOfTravellers,
    required this.vehiclePreference,
    this.tourPackage,
    this.specialRequirements,
    DateTime? createdAt,
    this.status = 'Pending',
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'startingLocation': startingLocation,
      'destination': destination,
      'travelDate': travelDate?.toIso8601String(),
      'returnDate': returnDate?.toIso8601String(),
      'numberOfTravellers': numberOfTravellers,
      'vehiclePreference': vehiclePreference,
      'tourPackage': tourPackage,
      'specialRequirements': specialRequirements,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }

  factory EnquiryModel.fromMap(Map<String, dynamic> map, [String? docId]) {
    return EnquiryModel(
      id: docId ?? map['id'],
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      startingLocation: map['startingLocation'] ?? '',
      destination: map['destination'] ?? '',
      travelDate: map['travelDate'] != null ? DateTime.tryParse(map['travelDate']) : null,
      returnDate: map['returnDate'] != null ? DateTime.tryParse(map['returnDate']) : null,
      numberOfTravellers: map['numberOfTravellers'] ?? 1,
      vehiclePreference: map['vehiclePreference'] ?? '16-Seat Traveller',
      tourPackage: map['tourPackage'],
      specialRequirements: map['specialRequirements'],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      status: map['status'] ?? 'Pending',
    );
  }
}
