import '../models/models.dart';

class MockData {
  // Mock Hubs - Chennai Locations
  static final List<Hub> hubs = [
    Hub(
      id: 'hub1',
      name: 'Marina Beach Cafe Hub',
      type: 'Cafe',
      address: 'T Nagar, Chennai',
      latitude: 13.0418,
      longitude: 80.2341,
      distanceFromUser: 0.3,
    ),
    Hub(
      id: 'hub2',
      name: 'Anna Express Hub',
      type: 'Shop',
      address: 'Anna Nagar, Chennai',
      latitude: 13.0850,
      longitude: 80.2101,
      distanceFromUser: 0.7,
    ),
    Hub(
      id: 'hub3',
      name: 'Kapaleeshwarar Books Hub',
      type: 'Shop',
      address: 'Mylapore, Chennai',
      latitude: 13.0339,
      longitude: 80.2619,
      distanceFromUser: 0.9,
    ),
    Hub(
      id: 'hub4',
      name: 'Adyar Riverside Hub',
      type: 'Community Center',
      address: 'Adyar, Chennai',
      latitude: 13.0067,
      longitude: 80.2570,
      distanceFromUser: 1.2,
    ),
    Hub(
      id: 'hub5',
      name: 'Velachery Tech Park Hub',
      type: 'Office',
      address: 'Velachery, Chennai',
      latitude: 12.9750,
      longitude: 80.2200,
      distanceFromUser: 2.1,
    ),
    Hub(
      id: 'hub6',
      name: 'Pondy Bazaar Market Hub',
      type: 'Shop',
      address: 'Nungambakkam, Chennai',
      latitude: 13.0569,
      longitude: 80.2417,
      distanceFromUser: 1.5,
    ),
    Hub(
      id: 'hub7',
      name: 'Saravana Bhavan Express Hub',
      type: 'Restaurant',
      address: 'T Nagar, Chennai',
      latitude: 13.0425,
      longitude: 80.2350,
      distanceFromUser: 0.5,
    ),
    Hub(
      id: 'hub8',
      name: 'Phoenix Mall Hub',
      type: 'Mall',
      address: 'Velachery, Chennai',
      latitude: 12.9800,
      longitude: 80.2220,
      distanceFromUser: 2.3,
    ),
    Hub(
      id: 'hub9',
      name: 'Chennai Central Station Hub',
      type: 'Transport',
      address: 'Anna Nagar, Chennai',
      latitude: 13.0820,
      longitude: 80.2090,
      distanceFromUser: 0.8,
    ),
    Hub(
      id: 'hub10',
      name: 'Thiruvanmiyur Beach Hub',
      type: 'Cafe',
      address: 'Adyar, Chennai',
      latitude: 13.0100,
      longitude: 80.2600,
      distanceFromUser: 1.8,
    ),
  ];

  // Mock Travelers
  static final List<Traveler> travelers = [
    Traveler(
      id: 'traveler1',
      name: 'Aman G.',
      avatarUrl: 'https://i.pravatar.cc/150?img=33',
      rating: 4.8,
      totalDeliveries: 142,
      route: RouteInfo(from: 'T Nagar', to: 'Anna Nagar'),
      totalEarnings: 2840.0,
    ),
    Traveler(
      id: 'traveler2',
      name: 'Priya K.',
      avatarUrl: 'https://i.pravatar.cc/150?img=45',
      rating: 4.9,
      totalDeliveries: 198,
      route: RouteInfo(from: 'Koramangala', to: 'Indiranagar'),
      totalEarnings: 3960.0,
    ),
    Traveler(
      id: 'traveler3',
      name: 'Rahul S.',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      rating: 4.7,
      totalDeliveries: 87,
      route: RouteInfo(from: 'Adyar', to: 'Mylapore'),
      totalEarnings: 1740.0,
    ),
    Traveler(
      id: 'traveler4',
      name: 'Sneha M.',
      avatarUrl: 'https://i.pravatar.cc/150?img=47',
      rating: 5.0,
      totalDeliveries: 234,
      route: RouteInfo(from: 'Velachery', to: 'Nungambakkam'),
      totalEarnings: 4680.0,
    ),
  ];

  // Mock Parcels
  static List<Parcel> getParcels() {
    return [
      Parcel(
        id: 'parcel1',
        from: 'Anna Nagar',
        to: 'T Nagar',
        size: 'Medium',
        weight: 2.0,
        traditionalPrice: 120.0,
        p2pPrice: 35.0,
        travelerEarnings: 25.0,
        distance: 8.0,
        pickupHub: hubs[1],
        deliveryHub: hubs[0],
      ),
      Parcel(
        id: 'parcel2',
        from: 'Adyar',
        to: 'Mylapore',
        size: 'Small',
        weight: 1.0,
        traditionalPrice: 80.0,
        p2pPrice: 25.0,
        travelerEarnings: 18.0,
        distance: 6.0,
        pickupHub: hubs[2],
        deliveryHub: hubs[3],
      ),
      Parcel(
        id: 'parcel3',
        from: 'Velachery',
        to: 'Nungambakkam',
        size: 'Large',
        weight: 4.0,
        traditionalPrice: 180.0,
        p2pPrice: 50.0,
        travelerEarnings: 30.0,
        distance: 10.0,
        pickupHub: hubs[4],
        deliveryHub: hubs[5],
      ),
      Parcel(
        id: 'parcel4',
        from: 'T Nagar',
        to: 'Anna Nagar',
        size: 'Medium',
        weight: 2.5,
        traditionalPrice: 200.0,
        p2pPrice: 55.0,
        travelerEarnings: 35.0,
        distance: 15.0,
        pickupHub: hubs[0],
        deliveryHub: hubs[1],
      ),
    ];
  }

  // Mock Statistics
  static Statistics getStatistics() {
    return Statistics(
      totalSavings: 45200.0,
      totalDeliveries: 892,
      co2Saved: 234.0,
      activeTravelers: 24,
      availableParcels: 18,
    );
  }

  // Success Stories
  static final List<Map<String, dynamic>> successStories = [
    {
      'name': 'Priya Sharma',
      'avatarUrl': 'https://i.pravatar.cc/150?img=47',
      'rating': 5.0,
      'quote':
          'Saved ₹500 this month! This app is incredibly efficient and helps connect the community.',
    },
    {
      'name': 'Arjun Patel',
      'avatarUrl': 'https://i.pravatar.cc/150?img=13',
      'rating': 5.0,
      'quote':
          'As a daily commuter, I earn ₹300-400 extra per week just by delivering parcels on my route!',
    },
    {
      'name': 'Meera Reddy',
      'avatarUrl': 'https://i.pravatar.cc/150?img=32',
      'rating': 4.5,
      'quote':
          'The hub system makes pickup and delivery so convenient. No more waiting for couriers!',
    },
  ];
}
