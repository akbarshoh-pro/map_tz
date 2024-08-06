
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/local/entity/point_entity.dart';
import '../../../utils/screen_state.dart';
import '../../blocs/saved_locations/saved_locations_bloc.dart';
import '../../blocs/saved_locations/saved_locations_event.dart';
import '../../blocs/saved_locations/saved_locations_state.dart';

class SavedLocationsScreen extends StatefulWidget {
  const SavedLocationsScreen({super.key});

  @override
  State<SavedLocationsScreen> createState() => _SavedLocationsScreenState();
}

class _SavedLocationsScreenState extends State<SavedLocationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SavedLocationsBloc, SavedLocationsState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    return SafeArea(
          child: Padding(
            padding:  const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                  //  Navigator.pushNamed(context, );
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 56,
                      width: 170,
                      decoration:  const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24)
                          )
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 8),
                          Text(
                            "Ortga qaytish",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(child: state.screenState == ScreenState.success ?
                ListView.separated(
                    itemBuilder: (context, index) {
                      return SavedItem(point: state.points![index], itemClick: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return DialogDelete(
                                point: state.points![index],
                                deleteClick: () {
                                  context.read<SavedLocationsBloc>().add(DeletePoint(index: index, point: state.points![index]));
                                  Navigator.pop(dialogContext);
                                  },
                                dismissClick: () {
                                  Navigator.pop(dialogContext);
                                });
                            },
                        );
                      });
                      },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: state.points!.length
          ) : Container(
                  alignment: Alignment.center,
                  child:  const Icon(Icons.hourglass_empty, size: 100),
                )
    ),
              ],
            ),
          )
      );
  },
),
      backgroundColor: const Color(0xFFf1f1f1),
    );
  }
}

class SavedItem extends StatelessWidget {
  final PointEntity point;
  final VoidCallback itemClick;
  const SavedItem({
    required this.point, 
    required this.itemClick,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 56,
      decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Row(
        children: [
          Text(
            point.name,
            style: const TextStyle(
                fontSize: 18
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: itemClick,
              child: const Icon(Icons.delete,
                  color: Color(0xFFFF6262)
              )
          )
        ],
      ),
    );
  }
}

class DialogDelete extends StatelessWidget {
  final PointEntity point;
  final VoidCallback deleteClick;
  final VoidCallback dismissClick;
  const DialogDelete({
    required this.point,
    required this.deleteClick,
    required this.dismissClick,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        height: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${point.name}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: deleteClick,
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFD6C6C),
                        borderRadius: BorderRadius.circular(8), // Added border radius for consistency
                      ),
                      child: const Text(
                        "O'chirish",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: dismissClick,
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB6B6B6),
                        borderRadius: BorderRadius.circular(8), // Added border radius for consistency
                      ),
                      child: const Text(
                        "Bekor qilish",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


