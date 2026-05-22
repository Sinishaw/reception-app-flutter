// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'9ce5d3a1d8e34e1852c77b7a602fe3158dd8f0ca';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeProvider<SharedPreferences>.internal(
      sharedPreferences,
      name: r'sharedPreferencesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sharedPreferencesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = AutoDisposeProviderRef<SharedPreferences>;
String _$stationIdHash() => r'e3283ea1a35bc69e0094748ed5831664cdc9ead9';

/// See also [StationId].
@ProviderFor(StationId)
final stationIdProvider =
    AutoDisposeNotifierProvider<StationId, String?>.internal(
      StationId.new,
      name: r'stationIdProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$stationIdHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$StationId = AutoDisposeNotifier<String?>;
String _$assignedFloorHash() => r'5a1768da4708ae185e48c3a451784acb818a48b0';

/// See also [AssignedFloor].
@ProviderFor(AssignedFloor)
final assignedFloorProvider =
    AutoDisposeNotifierProvider<AssignedFloor, String?>.internal(
      AssignedFloor.new,
      name: r'assignedFloorProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$assignedFloorHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AssignedFloor = AutoDisposeNotifier<String?>;
String _$pairingTimeHash() => r'23bd1ad64e6a0d1cd2b9b639ea1a0597c1316813';

/// See also [PairingTime].
@ProviderFor(PairingTime)
final pairingTimeProvider =
    AutoDisposeNotifierProvider<PairingTime, String?>.internal(
      PairingTime.new,
      name: r'pairingTimeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pairingTimeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PairingTime = AutoDisposeNotifier<String?>;
String _$sessionIdHash() => r'58a0ef5edcbb70dd7de5e9883c5f6d930dd3a84c';

/// See also [SessionId].
@ProviderFor(SessionId)
final sessionIdProvider =
    AutoDisposeNotifierProvider<SessionId, String?>.internal(
      SessionId.new,
      name: r'sessionIdProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sessionIdHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SessionId = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
