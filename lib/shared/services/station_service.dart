import 'dart:async';

class StationService {
  static final List<String> _mockStations = [
    'Lobby A - Main Entrance',
    'Lobby B - East Tower',
    'Floor 2 Reception',
    'Floor 5 Executive Reception',
    'R&D Lab Reception',
  ];

  static Future<List<String>> fetchStations(String query) async {
    // Simulate API request network latency of 300ms
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (query.isEmpty) {
      return _mockStations;
    }
    
    return _mockStations
        .where((station) => station.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
