import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../shared/models/station.dart';
import '../../shared/repositories/providers.dart';
import '../pairing/station_provider.dart';

part 'session_provider.g.dart';

@riverpod
Stream<ActiveSession?> activeSession(Ref ref) {
  final stationId = ref.watch(stationIdProvider);
  if (stationId == null) return Stream.value(null);
  
  final repository = ref.watch(sessionRepositoryProvider);
  return repository.watchSession(stationId);
}
