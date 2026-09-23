class GalleryItem {
  final String id;
  final String title;
  final String category; // 'Vehicles', 'Road Trips', 'Destinations', 'Happy Travellers', 'Tour Experiences'
  final String imageUrl;
  final String location;

  const GalleryItem({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.location,
  });
}
