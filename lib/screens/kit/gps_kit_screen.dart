import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heldis/common/tools.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/authentification/presentation/kit_screen.dart';
import 'package:heldis/screens/kit/blocs/get_children/get_children_bloc.dart';
import 'package:heldis/screens/kit/gps_kit_details_screen.dart';
import 'package:heldis/screens/kit/model/get_all_child_response_model.dart';
import 'package:heldis/services/session/selected_kit/selected_kit_bloc.dart';

class GPSKitScreen extends StatefulWidget {
  const GPSKitScreen({super.key});

  @override
  State<GPSKitScreen> createState() => _GPSKitScreenState();
}

class _GPSKitScreenState extends State<GPSKitScreen> {
  /* @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }
 */
  @override
  void initState() {
    super.initState();
    initChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 249, 255),
      appBar: buildAppBar(),
      //bottomNavigationBar: buildBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: BlocListener<GetChildrenBloc, GetChildrenState>(
          listener: (context, state) {
            if (state is GetChildrenError) {
              showErrorSnackBar(context: context, message: state.message);
            }
          },
          child: context.watch<GetChildrenBloc>().state is GetChildrenLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () async {
                    context.read<GetChildrenBloc>().add(const GetChildren());
                  },
                  child: ListView.builder(
                    itemCount: (context.watch<GetChildrenBloc>().state
                            is GetChildrenSuccess)
                        ? (context.watch<GetChildrenBloc>().state
                                as GetChildrenSuccess)
                            .children
                            .length
                        : 0,
                    itemBuilder: (context, index) {
                      ChildModel child = (context.watch<GetChildrenBloc>().state
                              as GetChildrenSuccess)
                          .children[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: SelectedGPSKitItem(
                          child: child,
                          isSelected:
                              context.watch<SelectedKitBloc>().state.kitId ==
                                  child.id,
                        ),
                      );
                    },
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
                        builder: (context) => const KitScreen(
                          canPop: true,
                        ),
                      ));
                },
                child: const Text("Add GPS Kit"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  initChildren() {
    if (context.read<GetChildrenBloc>().state is GetChildrenSuccess) {
      if ((context.read<GetChildrenBloc>().state as GetChildrenSuccess)
          .children
          .isNotEmpty) {
        return;
      }
    }
    context.read<GetChildrenBloc>().add(const GetChildren());
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text("GPS Kit Profiles",
          style: Theme.of(context).textTheme.titleMedium),
      leading: const SizedBox(),
    );
  }
}

class SelectedGPSKitItem extends StatelessWidget {
  const SelectedGPSKitItem({
    super.key,
    this.isSelected = false,
    required this.child,
  });

  final bool isSelected;
  final ChildModel child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return GPSKitDetailsScreen(child: child);
        }));
      },
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            padding: const EdgeInsets.all(15),
            child: Row(children: [
              if (child.avatar != null && child.avatar!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.memory(
                    base64Decode(child.avatar!),
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Image.asset(
                  "assets/heldis.png",
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          child.gps?.simNumber ?? "",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        child.name ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
          if (isSelected)
            const Positioned(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 25,
                  color: Colors.green,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
