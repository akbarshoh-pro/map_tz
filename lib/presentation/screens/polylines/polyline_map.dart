import 'package:flutter/material.dart';
import 'package:map_tz/core/data/local/entity/point_entity.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PolylineMap extends StatefulWidget {
  const PolylineMap({
    super.key,
    required this.myLocation,
    required this.nextLocation,
  });
  final PointEntity myLocation;
  final PointEntity nextLocation;

  @override
  State<PolylineMap> createState() => _PolylineMapState();
}

class _PolylineMapState extends State<PolylineMap> {
  late YandexMapController _mapController;
  final List<MapObject> _mapObjects = [];

  @override
  void initState() {
    super.initState();
    _addMarkers();
    _addPolyline(); // Call this method to add the polyline
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _addMarkers() {
    final myLocationPlacemark = PlacemarkMapObject(
      mapId: MapObjectId('my_location'),
      point: Point(latitude: widget.myLocation.latitude, longitude: widget.myLocation.longitude),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage('assets/images/ic_my_loc.png'),
        scale: 0.3,
      )),
    );

    final nextLocationPlacemark = PlacemarkMapObject(
      mapId: MapObjectId('next_location'),
      point: Point(latitude: widget.nextLocation.latitude, longitude: widget.nextLocation.longitude),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage('assets/images/ic_my_loc.png'),
        scale: 0.3,
      )),
    );

    setState(() {
      _mapObjects.add(myLocationPlacemark);
      _mapObjects.add(nextLocationPlacemark);
    });
  }

  void _addPolyline() {
    final polyline = PolylineMapObject(
      mapId: MapObjectId('route_line'),
      polyline: Polyline(points: [Point(latitude: widget.myLocation.latitude, longitude: widget.myLocation.longitude), Point(latitude: widget.nextLocation.latitude, longitude: widget.nextLocation.longitude),]),
      strokeColor: Colors.blue.withOpacity(0.8),
      strokeWidth: 5.0,
    );

    setState(() {
      _mapObjects.add(polyline);
    });
  }

  void _moveToDefaultLocation() {
    final point = Point(latitude: 41.311081, longitude: 69.240562);
    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: 12.0),
      ),
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 2.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 56,
                  width: 170,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 8),
                      Text("Ortga qaytish pol"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(22),
                            bottomLeft: Radius.circular(22),
                            bottomRight: Radius.circular(22),
                          ),
                          child: YandexMap(
                            mapObjects: _mapObjects,
                            onMapCreated: (controller) async {
                              _mapController = controller;
                              _moveToDefaultLocation();
                            },
                            onCameraPositionChanged: (cameraPosition, reason, finished) {
                              // Handle camera position change if needed
                            },
                            onMapTap: (Point point) {
                              // Handle map tap if needed
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFf1f1f1),
    );
  }
}
