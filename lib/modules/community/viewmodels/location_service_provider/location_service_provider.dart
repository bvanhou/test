import 'dart:developer';
import 'dart:async';

import 'package:deliverzler/core/services/location_service.dart';
import 'package:deliverzler/core/utils/constants.dart';
import 'package:deliverzler/modules/community/utils/location_error.dart';
import 'package:deliverzler/modules/community/viewmodels/location_change_callbacks_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:deliverzler/core/viewmodels/main_core_provider.dart';
import 'package:deliverzler/modules/community/viewmodels/location_service_provider/location_service_state.dart';
import 'package:geolocator/geolocator.dart';

final locationServiceProvider =
    StateNotifierProvider<LocationServiceNotifier, LocationServiceState>((ref) {
  return LocationServiceNotifier(ref);
});

class LocationServiceNotifier extends StateNotifier<LocationServiceState> {
  LocationServiceNotifier(this.ref)
      : super(const LocationServiceState.loading()) {
    _mainCoreProvider = ref.watch(mainCoreProvider);
    getCurrentLocation();
  }

  final Ref ref;
  late MainCoreProvider _mainCoreProvider;

  StreamSubscription? _currentLocationSubscription;
  Timer? _locationChangeTimer;
  bool _isEnableOnLocationChanged = true;

  Future getCurrentLocation() async {
    state = const LocationServiceState.loading();

    bool _enabled = await _mainCoreProvider.enableLocationService();
    if (!_enabled) {
      toggleError(LocationError.notEnabledLocation);
      return;
    }
    bool _locationGranted = await _mainCoreProvider.requestLocationPermission();
    if (!_locationGranted) {
      toggleError(LocationError.notGrantedTrackingPermission);
      return;
    }
    bool _trackingGranted = await _mainCoreProvider.requestTrackingPermission();
    if (!_trackingGranted) {
      toggleError(LocationError.notGrantedTrackingPermission);
      return;
    }

    final _currentLocation = await _mainCoreProvider.getCurrentUserLocation();
    if (_currentLocation == null) {
      toggleError(LocationError.getLocationTimeout);
      return;
    } else {
      state = LocationServiceState.available(_currentLocation);
      handleSuccessfulGetLocation();
    }
  }

  handleSuccessfulGetLocation() async {
    initLocationStream();
  }

  initLocationStream() {
    if (_currentLocationSubscription != null) return;

    initLocationChangeTimer();
    _currentLocationSubscription = Geolocator.getPositionStream(
      locationSettings: LocationService.instance.getLocationSettings(),
    ).listen(
      (newLoc) async {
        if (_isEnableOnLocationChanged) {
          _isEnableOnLocationChanged = false;
          state = LocationServiceState.available(newLoc);
          ref.watch(locationChangeCallbacksViewModel).executeCallBacks(newLoc);
        }
      },
      onError: ((error) {
        toggleError(LocationError.notEnabledLocation);
        log(error.toString());
      }),
    );
  }

  initLocationChangeTimer() {
    _locationChangeTimer = Timer.periodic(
      const Duration(seconds: locationChangeInterval),
      (_) {
        _isEnableOnLocationChanged = true;
      },
    );
  }

  toggleError(LocationError error) {
    state = LocationServiceState.error(error);
  }

  @override
  void dispose() {
    _currentLocationSubscription?.cancel();
    _locationChangeTimer?.cancel();
    super.dispose();
  }
}
