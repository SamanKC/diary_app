import 'package:diary_app/models/Location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationLoadingState());

  Future<void> getLocation() async {
    LocationData? locationData;
    try {
      locationData!.currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await _getAddressFromLatLng();

      emit(LocationLoadedState(locationData.currentPosition!));
    } catch (e) {
      emit(LocationErrorState('Error getting location: $e'));
    }
  }

  Future<void> _getAddressFromLatLng() async {
    LocationData? locationData;
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          locationData!.currentPosition!.latitude,
          locationData.currentPosition!.longitude);

      Placemark place = placemarks[0];

      String _currentAddress =
          "${place.locality}, ${place.postalCode}, ${place.country}";

      // Emit the address information to the state.
      emit(LocationAddressState(_currentAddress));
    } catch (e) {
      print(e);
    }
  }
}
