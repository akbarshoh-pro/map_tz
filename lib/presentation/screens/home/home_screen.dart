import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_tz/core/data/local/entity/point_entity.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../utils/location_status.dart';
import '../../blocs/saved_locations/saved_locations_bloc.dart';
import '../../blocs/saved_locations/saved_locations_event.dart';
import '../../blocs/select_location/select_location_bloc.dart';
import '../saved_locations/saved_locations_screen.dart';
import '../select_location/select_location_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PointEntity myLocation = PointEntity(name: "My location", latitude: 0.0, longitude: 0.0);
  PointEntity nextLocation = PointEntity(name: "Next location", latitude: 0.0, longitude: 0.0);

  Future<void> _getPermissions() async {
    final locationPermissionIsGranted =
    await Permission.location.request().isGranted;

    if (locationPermissionIsGranted) {

    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Нет доступа к местоположению пользователя'),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    _getPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFf1f1f1),
        title: const Text(
            "Generate road"
        )
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 24),
              InkWell(
                onTap: () async {
                  var data = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx){
                        return BlocProvider(
                          create: (contextB) => SelectLocationBloc(),
                          child: const SelectLocationScreen(locationStatus: LocationStatus.currentLocation),
                        );
                      })
                  ) as PointEntity;
                  if(data.name != "deff") {
                    setState(() {
                      myLocation = data;
                    });
                  }
                },
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child:  Text(myLocation.name),
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () async {
                  var name = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx){
                        return BlocProvider(
                          create: (contextB) => SelectLocationBloc(),
                          child: const SelectLocationScreen(locationStatus: LocationStatus.nextLocation),
                        );
                      })
                  ) as PointEntity;
                  if(name != "deff") {
                    setState(() {
                      nextLocation = name;
                    });
                  }
                },
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Text(nextLocation.name),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx){
                        return BlocProvider(
                          create: (contextB) => SavedLocationsBloc()..add(GetAllPoints()),
                          child: const SavedLocationsScreen(),
                        );
                      })
                  );
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)
                  ),
                  child: Icon(Icons.save_alt_outlined),
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {

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
                    "Yo'l chizish",
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
