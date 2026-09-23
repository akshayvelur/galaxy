import '../models/gallery_item.dart';

class GalleryData {
  static const List<GalleryItem> items = [
    GalleryItem(
      id: 'g-1',
      title: '18-Seat Luxury Traveller on Munnar Ghat Road',
      category: 'Vehicles',
      imageUrl: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?q=80&w=1000&auto=format&fit=crop',
      location: 'Munnar, Kerala',
    ),
    GalleryItem(
      id: 'g-2',
      title: '26-Seat Tourist Bus on Yamuna Expressway',
      category: 'Vehicles',
      imageUrl: 'https://images.unsplash.com/photo-1464219789935-c2d9d9aba644?q=80&w=1000&auto=format&fit=crop',
      location: 'Delhi-Agra Expressway',
    ),
    GalleryItem(
      id: 'g-3',
      title: '16-Seat Executive Traveller Fleet Inspection',
      category: 'Vehicles',
      imageUrl: 'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?q=80&w=1000&auto=format&fit=crop',
      location: 'Kochi Fleet Hub',
    ),
    GalleryItem(
      id: 'g-4',
      title: 'Crossing the Atal Tunnel Gateway to Lahaul',
      category: 'Road Trips',
      imageUrl: 'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?q=80&w=1000&auto=format&fit=crop',
      location: 'Manali, Himachal Pradesh',
    ),
    GalleryItem(
      id: 'g-5',
      title: 'Coastal Drive along Konkan Highway to Goa',
      category: 'Road Trips',
      imageUrl: 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?q=80&w=1000&auto=format&fit=crop',
      location: 'Konkan Coast, Goa',
    ),
    GalleryItem(
      id: 'g-6',
      title: 'Sunset over Alleppey Palm-fringed Canals',
      category: 'Destinations',
      imageUrl: 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?q=80&w=1000&auto=format&fit=crop',
      location: 'Alleppey, Kerala',
    ),
    GalleryItem(
      id: 'g-7',
      title: 'Amber Fort Ramparts and Maota Lake',
      category: 'Destinations',
      imageUrl: 'https://images.unsplash.com/photo-1477587458883-47145ed94245?q=80&w=1000&auto=format&fit=crop',
      location: 'Jaipur, Rajasthan',
    ),
    GalleryItem(
      id: 'g-8',
      title: 'Dal Lake Shikhara Gliding on Golden Waters',
      category: 'Destinations',
      imageUrl: 'https://images.unsplash.com/photo-1598091383021-15ddea10925d?q=80&w=1000&auto=format&fit=crop',
      location: 'Srinagar, Kashmir',
    ),
    GalleryItem(
      id: 'g-9',
      title: 'Extended Family Group at Mysore Palace',
      category: 'Happy Travellers',
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1000&auto=format&fit=crop',
      location: 'Mysore, Karnataka',
    ),
    GalleryItem(
      id: 'g-10',
      title: 'Corporate Offsite Team at North Goa Beach',
      category: 'Happy Travellers',
      imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1000&auto=format&fit=crop',
      location: 'Calangute, Goa',
    ),
    GalleryItem(
      id: 'g-11',
      title: 'Bonfire Night under Himalayan Stars',
      category: 'Tour Experiences',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=1000&auto=format&fit=crop',
      location: 'Solang Valley, Manali',
    ),
    GalleryItem(
      id: 'g-12',
      title: 'Traditional Kathakali Cultural Evening Performance',
      category: 'Tour Experiences',
      imageUrl: 'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?q=80&w=1000&auto=format&fit=crop',
      location: 'Thekkady, Kerala',
    ),
  ];

  static List<GalleryItem> getByCategory(String category) {
    if (category == 'All') return items;
    return items.where((item) => item.category == category).toList();
  }
}
