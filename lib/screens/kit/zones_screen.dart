import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heldis/common/tools.dart';
import 'package:heldis/screens/kit/add_zone_screen.dart';
import 'package:heldis/screens/kit/blocs/get_children/get_children_bloc.dart';
import 'package:heldis/screens/kit/blocs/zone_handle/zone_handle_bloc.dart';
import 'package:heldis/screens/kit/model/child_zone_model.dart';
import 'package:heldis/screens/kit/model/get_all_child_response_model.dart';

class ZoneScreen extends StatefulWidget {
  const ZoneScreen({super.key, required this.childId});

  final int childId;

  @override
  State<ZoneScreen> createState() => _ZoneScreenState();
}

class _ZoneScreenState extends State<ZoneScreen> {
  List<LatLng> generatedPoints = [];
  TextEditingController dateEnd = TextEditingController();
  TextEditingController dateStart = TextEditingController();
  /* @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }
 */
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 249, 255),
      appBar: buildAppBar(),
      //bottomNavigationBar: buildBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: BlocListener<ZoneHandleBloc, ZoneHandleState>(
              listener: (context, state) {
                if (state is DeleteZoneError) {
                  showErrorSnackBar(context: context, message: state.message);
                }
                if (state is DeleteZoneSuccess) {
                  context.read<GetChildrenBloc>().add(const GetChildren());
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (context.watch<GetChildrenBloc>().state
                      is GetChildrenSuccess)
                    ...(context.watch<GetChildrenBloc>().state
                                as GetChildrenSuccess)
                            .children
                            .firstWhere(
                                (element) => element.id == widget.childId)
                            .zones
                            ?.map((e) => SaveZoneItem(
                                  zone: e,
                                ))
                            .toList() ??
                        [],
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FilledButton(
                style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(13)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddZoneScreen(
                          childId: widget.childId,
                        ),
                      ));
                },
                child: const Text("Add a Zone"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text("Safe Zones", style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class SaveZoneItem extends StatelessWidget {
  const SaveZoneItem({
    super.key,
    required this.zone,
  });

  final ChildZone zone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 2,
                  runSpacing: 5,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Lon : ${zone.lng ?? ""}",
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Lat : ${zone.lat ?? ""}",
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Radius : ${zone.radius ?? 0} m",
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      zone.zoneName ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    if ((context.watch<ZoneHandleBloc>().state
                        is DeleteZoneLoading))
                      Container(
                          height: 20,
                          width: 20,
                          padding: const EdgeInsets.all(1),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 11),
                          child: const CircularProgressIndicator(
                            color: Colors.red,
                          ))
                    else
                      IconButton(
                        onPressed: () {
                          context.read<ZoneHandleBloc>().add(DeleteZoneEvent(
                              zoneId: zone.id ?? 0,
                              childId: zone.childId ?? 0));
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      )
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
