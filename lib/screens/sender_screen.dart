import 'package:flutter/material.dart';
import '../models/models.dart';
import '../data/mock_data.dart';
import '../services/cost_calculator.dart';
import '../services/route_matcher.dart';
import '../theme/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/hub_location_card.dart';
import '../widgets/cost_comparison_widget.dart';
import '../widgets/traveler_match_card.dart';
import '../widgets/location_map_picker.dart';

class SenderScreen extends StatefulWidget {
  const SenderScreen({super.key});

  @override
  State<SenderScreen> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {
  final _formKey = GlobalKey<FormState>();
  
  String _fromLocation = 'T Nagar, Chennai';
  String _toLocation = 'Anna Nagar, Chennai';
  String _selectedSize = 'Medium';
  double _weight = 2.0;
  final double _distance = 8.0;
  
  Hub? _selectedPickupHub;
  Hub? _selectedDeliveryHub;
  
  List<Traveler> _matchedTravelers = [];
  Map<String, double>? _costBreakdown;
  List<Hub> _pickupHubs = [];
  List<Hub> _deliveryHubs = [];

  @override
  void initState() {
    super.initState();
    _updateHubs();
    _calculateCosts();
    _findTravelers();
  }

  void _updateHubs() {
    // Filter hubs based on selected locations
    final allHubs = MockData.hubs;
    final fromArea = _fromLocation.split(',')[0].trim();
    final toArea = _toLocation.split(',')[0].trim();
    
    // Get hubs near "From" location for pickup
    _pickupHubs = allHubs.where((hub) {
      return hub.address.contains(fromArea);
    }).toList();
    
    // If no exact match, show all hubs sorted by distance
    if (_pickupHubs.isEmpty) {
      _pickupHubs = List.from(allHubs)..sort((a, b) => a.distanceFromUser.compareTo(b.distanceFromUser));
      _pickupHubs = _pickupHubs.take(3).toList();
    }
    
    // Get hubs near "To" location for delivery
    _deliveryHubs = allHubs.where((hub) {
      return hub.address.contains(toArea);
    }).toList();
    
    // If no exact match, show all hubs sorted by distance
    if (_deliveryHubs.isEmpty) {
      _deliveryHubs = List.from(allHubs)..sort((a, b) => a.distanceFromUser.compareTo(b.distanceFromUser));
      _deliveryHubs = _deliveryHubs.skip(3).take(3).toList();
    }
  }

  void _calculateCosts() {
    setState(() {
      _costBreakdown = CostCalculator.getCostBreakdown(_distance);
    });
  }

  void _findTravelers() {
    // Create a temporary parcel to match travelers
    final tempParcel = Parcel(
      id: 'temp',
      from: _fromLocation,
      to: _toLocation,
      size: _selectedSize,
      weight: _weight,
      traditionalPrice: _costBreakdown?['traditionalCost'] ?? 0,
      p2pPrice: _costBreakdown?['p2pCost'] ?? 0,
      travelerEarnings: _costBreakdown?['travelerEarnings'] ?? 0,
      distance: _distance,
      pickupHub: _selectedPickupHub ?? MockData.hubs[0],
      deliveryHub: _selectedDeliveryHub ?? MockData.hubs[1],
    );
    
    setState(() {
      _matchedTravelers = RouteMatcher.matchTravelersToParcel(
        tempParcel,
        MockData.travelers,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Send Package'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Locations Card with Map
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Locations',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.map,
                                  size: 14,
                                  color: AppColors.primaryBlue,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'OpenStreetMap',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      // From Location with Map
                      const Text(
                        'From',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      LocationMapPicker(
                        initialLocation: 'T Nagar, Chennai',
                        onLocationSelected: (location) {
                          setState(() {
                            _fromLocation = location;
                            _selectedPickupHub = null;
                            _updateHubs();
                            _findTravelers();
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      // To Location
                      const Text(
                        'To',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      LocationMapPicker(
                        initialLocation: 'Anna Nagar, Chennai',
                        onLocationSelected: (location) {
                          setState(() {
                            _toLocation = location;
                            _selectedDeliveryHub = null;
                            _updateHubs();
                            _findTravelers();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Select Pickup Hub
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Select Pickup Hub',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Near ${_fromLocation.split(',')[0]}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      ..._pickupHubs.map((hub) {
                        final isSelected = _selectedPickupHub == hub;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: HubLocationCard(
                            hub: hub,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _selectedPickupHub = hub;
                              });
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Select Delivery Hub
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Select Delivery Hub',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryPurple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Near ${_toLocation.split(',')[0]}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.primaryPurple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      ..._deliveryHubs.map((hub) {
                        final isSelected = _selectedDeliveryHub == hub;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: HubLocationCard(
                            hub: hub,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _selectedDeliveryHub = hub;
                              });
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Parcel Details Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Parcel Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _selectedSize,
                              decoration: const InputDecoration(
                                labelText: 'Size',
                                prefixIcon: Icon(Icons.inventory_2_outlined),
                              ),
                              items: ['Small', 'Medium', 'Large']
                                  .map((size) => DropdownMenuItem(
                                        value: size,
                                        child: Text(size),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedSize = value;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              initialValue: _weight.toString(),
                              decoration: const InputDecoration(
                                labelText: 'Weight (kg)',
                                prefixIcon: Icon(Icons.scale_outlined),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _weight = double.tryParse(value) ?? 2.0;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Cost Comparison
              if (_costBreakdown != null)
                CostComparisonWidget(
                  traditionalCost: _costBreakdown!['traditionalCost']!,
                  p2pCost: _costBreakdown!['p2pCost']!,
                  savings: _costBreakdown!['savings']!,
                ),
              
              const SizedBox(height: 20),
              
              // Matched Travelers
              if (_matchedTravelers.isNotEmpty) ...[
                const Text(
                  'Matched Travelers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                
                ..._matchedTravelers.take(2).map((traveler) => TravelerMatchCard(
                      traveler: traveler,
                      earnings: _costBreakdown?['travelerEarnings'] ?? 0,
                    )),
              ],
              
              const SizedBox(height: 20),
              
              // Confirm Button
              CustomButton(
                text: 'CONFIRM DELIVERY',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Delivery request confirmed!'),
                      backgroundColor: AppColors.successGreen,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
