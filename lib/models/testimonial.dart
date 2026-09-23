class Testimonial {
  final String id;
  final String authorName;
  final String city;
  final String destinationVisited;
  final double rating;
  final String review;
  final String vehicleUsed;
  final String date;
  final String? avatarUrl;

  const Testimonial({
    required this.id,
    required this.authorName,
    required this.city,
    required this.destinationVisited,
    this.rating = 5.0,
    required this.review,
    required this.vehicleUsed,
    required this.date,
    this.avatarUrl,
  });
}
