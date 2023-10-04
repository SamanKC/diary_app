part of 'location_cubit.dart';

abstract class LocationState {}

class LocationLoadingState extends LocationState {}

class LocationLoadedState extends LocationState {
  final Position position;

  LocationLoadedState(this.position);
}

class LocationAddressState extends LocationState {
  LocationAddressState(String currentAddress);
}

class LocationErrorState extends LocationState {
  final String error;

  LocationErrorState(this.error);
}
