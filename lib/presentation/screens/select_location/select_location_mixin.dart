
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_tz/presentation/screens/select_location/select_location_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

mixin SelectLocationMixin on State<SelectLocationScreen> {
  YandexMapController? mapController;
  double iconSize = 32.0;
  String addressName = "";
  bool mapDimmed = false;
  double currentLat = 0.0;
  double currentLong = 0.0;

  Future<void> _getPermissions() async {
    final locationPermissionIsGranted = await Permission.location.request().isGranted;

    if (!locationPermissionIsGranted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Нет доступа к местоположению пользователя'),
            ),
          );
        }
      });
    }
  }

  @override
  void initState() {
    _getPermissions();
    super.initState();
  }

  void moveToDefaultLocation() {
    final point = const Point(latitude: 41.311081, longitude: 69.240562);
    mapController!.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: 16.0),
      ),
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 2.0),
    );
  }

  void changeIconSize(double size) {
    if (!mounted) return; // Ensure widget is still mounted
    setState(() {
      iconSize = size;
      mapDimmed = (size == 38.0);
    });
    if (size == 32.0) {
      getAddressFromIconLocation();
    }
  }

  Future<void> getAddressFromIconLocation() async {
    if (!mounted || mapController == null) return;
    try {
      final cameraPosition = await mapController!.getCameraPosition();
      final point = cameraPosition.target;

      await getUserLocation(point.latitude, point.longitude);
    } catch (e) {
      if (mounted) {
        setState(() {
          addressName = "Error: $e";
        });
      }
    }
  }

  Future<void> getUserLocation(double lat, double long) async {
    try {
      currentLat = lat;
      currentLong = long;
      List<Placemark> placeMarks = await placemarkFromCoordinates(lat, long);
      if (placeMarks.isNotEmpty) {
        final place = placeMarks[0];
        if (mounted) {
          setState(() {
            addressName = place.street ?? "Unknown address";
          });
        }
      } else {
        if (mounted) {
          setState(() {
            addressName = "No address found";
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          addressName = "Error: $e";
        });
      }
    }
  }
}