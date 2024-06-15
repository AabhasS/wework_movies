
import 'package:injectable/injectable.dart';

sealed class LocationService{

  Future<dynamic> getLocation();
}

@Injectable(as: LocationService)
class LocationServiceImpl implements LocationService{
  @override
  Future<dynamic> getLocation() {
    // TODO: implement getLocation
    throw UnimplementedError();
  }
}