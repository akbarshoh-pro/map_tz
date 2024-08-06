// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';
//
// class PolylineMap extends StatefulWidget {
//   const PolylineMap({
//     super.key,
//     required this.endLocLat,
//     required this.endLocLong,
//     required this.startLocLat,
//     required this.startLocLong,
//   });
//   final double startLocLat;
//   final double startLocLong;
//   final double endLocLat;
//   final double endLocLong;
//
//   @override
//   State<PolylineMap> createState() => _PolylineMapState();
// }
//
// class _PolylineMapState extends State<PolylineMap> {
//   late YandexMapController _mapController;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _mapController.dispose();
//     super.dispose();
//   }
//
//   void _moveToDefaultLocation() {
//     final point = Point(
//       latitude: widget.startLocLat,
//       longitude: widget.startLocLong,
//     );
//     _mapController.moveCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: point, zoom: 12.0),
//       ),
//       animation: const MapAnimation(type: MapAnimationType.smooth, duration: 2.0),
//     );
//   }
//
//   Future<void> _addMarkers() async {
//     final startPoint = Point(
//       latitude: widget.startLocLat,
//       longitude: widget.startLocLong,
//     );
//     final endPoint = Point(
//       latitude: widget.endLocLat,
//       longitude: widget.endLocLong,
//     );
//
//     // Add start marker
//     await _mapController.addPlacemark(
//       Placemark(
//         point: startPoint,
//         icon: PlacemarkIcon.single(
//           PlacemarkIconStyle(
//             image: BitmapDescriptor.fromAsset('assets/images/marker_start.png'),
//             scale: 0.5,
//           ),
//         ),
//       ),
//     );
//
//     // Add end marker
//     await _mapController.addPlacemark(
//       Placemark(
//         point: endPoint,
//         icon: PlacemarkIcon.single(
//           PlacemarkIconStyle(
//             image: BitmapDescriptor.fromAsset('assets/images/marker_end.png'),
//             scale: 0.5,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 56,
//                 width: 170,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFFFFFFF),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(24),
//                     topRight: Radius.circular(24),
//                   ),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.arrow_back),
//                     SizedBox(width: 8),
//                     Text("Ortga qaytish pol"),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 4),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.all(4),
//                   decoration: BoxDecoration(
//                     color: Color(0xFFFFFFFF),
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(24),
//                       bottomRight: Radius.circular(24),
//                       bottomLeft: Radius.circular(24),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 80, child: Column()),
//                       Expanded(
//                         child: Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(4),
//                                 topRight: Radius.circular(4),
//                                 bottomLeft: Radius.circular(22),
//                                 bottomRight: Radius.circular(22),
//                               ),
//                               child: YandexMap(
//                                 onMapCreated: (controller) {
//                                   _mapController = controller;
//                                   _moveToDefaultLocation();
//                                   _addMarkers();
//                                 },
//                                 onCameraPositionChanged: (cameraPosition, reason, finished) {
//                                   // Handle camera position change if needed
//                                 },
//                                 onMapTap: (Point point) {
//                                   // Handle map tap if needed
//                                 },
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: GestureDetector(
//                                 onTap: () async {
//                                   await _mapController.toggleUserLayer(visible: true);
//                                 },
//                                 child: Container(
//                                   margin: EdgeInsets.only(bottom: 28, right: 16),
//                                   padding: EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     color: Color(0xFFFFFFFF),
//                                     borderRadius: BorderRadius.all(Radius.circular(28)),
//                                   ),
//                                   child: Icon(
//                                     Icons.my_location_sharp,
//                                     color: Color(0xFF000000),
//                                     size: 20,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         "Start: ${widget.startLocLat}, ${widget.startLocLong}\nEnd: ${widget.endLocLat}, ${widget.endLocLong}",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color(0xFF000000),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   width: double.maxFinite,
//                   height: 64,
//                   decoration: BoxDecoration(
//                     color: Color(0xFFff5c01),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Tasdiqlash",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Color(0xFFFFFFFF),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       backgroundColor: Color(0xFFf1f1f1),
//     );
//   }
// }
