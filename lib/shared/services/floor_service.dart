import 'dart:async';

class FloorService {
  static const List<String> _allFloors = [
    'Floor 1 - Main Lobby & Concierge',
    'Floor 2 - Engineering & Developer Hub',
    'Floor 3 - Marketing, Design & Creative Lab',
    'Floor 4 - Human Resources & Finance Operations',
    'Floor 5 - Executive Suites & Boardrooms',
    'Floor 6 - Conference & Innovation Center',
    'Penthouse - Sky Lounge & Partner Offices',
    'Basement - Secure Research & Tech Vault',
  ];

  /// Simulates a query against an external API/database with a 300ms network delay.
  static Future<List<String>> fetchFloors(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (query.trim().isEmpty) {
      return List.of(_allFloors);
    }
    final normalizedQuery = query.trim().toLowerCase();
    return _allFloors
        .where((floor) => floor.toLowerCase().contains(normalizedQuery))
        .toList();
  }
}
