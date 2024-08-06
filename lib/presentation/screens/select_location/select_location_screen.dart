
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_tz/presentation/screens/select_location/select_location_mixin.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/data/local/entity/point_entity.dart';
import '../../../utils/location_status.dart';
import '../../blocs/select_location/select_location_bloc.dart';
import '../../blocs/select_location/select_location_event.dart';

class SelectLocationScreen extends StatefulWidget {
  final LocationStatus locationStatus;
  const SelectLocationScreen({required this.locationStatus, super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> with SelectLocationMixin {

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
                  Navigator.pop(context, PointEntity(name: "deff", latitude: 0.0, longitude: 0.0));
                },
                child: Container(
                  height: 56,
                  width: 170,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 8),
                      Text("Ortga qaytish"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: SizedBox(
                            height: 80,
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Manzil",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  addressName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF000000),
                                  ),
                                )
                              ],
                            )),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                                bottomLeft: Radius.circular(22),
                                bottomRight: Radius.circular(22),
                              ),
                              child: Stack(
                                children: [
                                  YandexMap(
                                    onMapCreated: (controller) {
                                      mapController = controller;
                                      moveToDefaultLocation();
                                    },
                                    onCameraPositionChanged: (cameraPosition, reason, finished) {
                                      changeIconSize(38.0);
                                      if (finished) {
                                        changeIconSize(32.0);
                                      }
                                    },
                                    onMapTap: (Point point) {
                                      changeIconSize(38.0);
                                    },
                                  ),
                                  if (mapDimmed)
                                    Container(
                                      color: Colors.black.withOpacity(0.3), // Dark overlay
                                    ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      context.read<SelectLocationBloc>().add(SavePoint(point: PointEntity(name: addressName, latitude: currentLat, longitude: currentLong)));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 12, right: 16),
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                        borderRadius: BorderRadius.all(Radius.circular(28)),
                                      ),
                                      child: const Icon(
                                        Icons.save_alt_sharp,
                                        color: Color(0xFF000000),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // Implement your logic here
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 28, right: 16),
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                        borderRadius: BorderRadius.all(Radius.circular(28)),
                                      ),
                                      child: const Icon(
                                        Icons.my_location_sharp,
                                        color: Color(0xFF000000),
                                        size: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                              child: Image.asset(
                                "assets/images/ic_my_loc.png",
                                width: iconSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, PointEntity(name: addressName, latitude: currentLat, longitude: currentLong));
                },
                child: Container(
                  width: double.maxFinite,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFff5c01),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Tasdiqlash",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFf1f1f1),
    );
  }
}


