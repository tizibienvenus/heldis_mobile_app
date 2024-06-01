import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/kit/blocs/get_children/get_children_bloc.dart';
import 'package:heldis/screens/kit/blocs/handle_child/handle_child_bloc.dart';
import 'package:heldis/screens/kit/model/get_all_child_response_model.dart';
import 'package:heldis/screens/kit/update_child_info_screen.dart';
import 'package:heldis/screens/kit/zones_screen.dart';
import 'package:heldis/services/session/selected_kit/selected_kit_bloc.dart';

class GPSKitDetailsScreen extends StatefulWidget {
  const GPSKitDetailsScreen({
    super.key,
    required this.child,
  });
  final ChildModel child;
  @override
  State<GPSKitDetailsScreen> createState() => _GPSKitDetailsScreenState();
}

class _GPSKitDetailsScreenState extends State<GPSKitDetailsScreen> {
  late ChildModel _child;
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

    _child = widget.child;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetChildrenBloc, GetChildrenState>(
      listener: (context, state) {
        if (state is GetChildrenSuccess) {
          setState(() {
            _child =
                state.children.firstWhere((element) => element.id == _child.id);
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 249, 255),
        appBar: buildAppBar(),
        //bottomNavigationBar: buildBottomNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_child.avatar != null && _child.avatar!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.memory(
                        base64Decode(_child.avatar!),
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Image.asset(
                      "assets/heldis.png",
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _child.gps?.simNumber ?? "",
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  Text(
                    _child.name ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Additional Information",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    _child.description ?? "None",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.all(13)),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed:
                              context.watch<SelectedKitBloc>().state.kitId ==
                                      _child.id
                                  ? null
                                  : () {
                                      context.read<SelectedKitBloc>().add(
                                          ChangeSelectedKitEvent(
                                              kit: _child.id ?? 0));
                                    },
                          child: Text(
                              context.watch<SelectedKitBloc>().state.kitId ==
                                      _child.id
                                  ? "You Use This GPS Kit"
                                  : "Use This GPS Kit",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          style: ButtonStyle(
                              padding: const MaterialStatePropertyAll(
                                  EdgeInsets.all(13)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ZoneScreen(
                                  childId: _child.id ?? 0,
                                ),
                              ),
                            );
                          },
                          child: const Text("Safe Zones",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          style: ButtonStyle(
                              padding: const MaterialStatePropertyAll(
                                  EdgeInsets.all(13)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateChildInfoScreen(
                                  child: _child,
                                ),
                              ),
                            );
                          },
                          child: const Text("Update Kit Information",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text("GPS Kit Details",
          style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
