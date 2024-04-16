import 'package:flutter/material.dart';
import 'package:heldis/constants/constants.dart';

class HistoryCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -0),
              blurRadius: 11,
              spreadRadius: 5,
              color: Color(0xFF000000).withOpacity(0.1),
            ),
          ],
        ),
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(11),
              decoration: const BoxDecoration(
                color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Image.asset(
                      "assets/images/avatar-1.png",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ecole Ange et Noe",
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(
                        "Yaoundé, Cradat",
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return kPrimaryColor.withOpacity(0);
                          }
                          return kPrimaryColor
                              .withOpacity(0); // Use the component's default.
                        },
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return kPrimaryColor;
                          }
                          return kPrimaryColor; // Use the component's default.
                        },
                      ),
                    ),
                    icon: const Icon(
                      Icons.message_rounded,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return kPrimaryColor.withOpacity(0);
                          }
                          return kPrimaryColor
                              .withOpacity(0); // Use the component's default.
                        },
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return kPrimaryColor;
                          }
                          return kPrimaryColor; // Use the component's default.
                        },
                      ),
                    ),
                    icon: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 0.5,
              color: Color(0xFFF7F7F7),
            ),
            Container(
              padding: EdgeInsets.all(11),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Upcoming",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: kPrimaryColor),
                      ),
                      Text("Jan 28 2023, 10:45 AM"),
                    ],
                  ),
                  Spacer(),

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Distance",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        "2.8Km",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Time",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                      Text("28 min"),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Price",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                      Text("Olembe"),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: (){},
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return kPrimaryColor.withOpacity(0);
                          }
                          return kPrimaryColor
                              .withOpacity(0); // Use the component's default.
                        },
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return kPrimaryColor;
                          }
                          return kPrimaryColor; // Use the component's default.
                        },
                      ),
                      side: MaterialStateProperty.resolveWith<BorderSide?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return BorderSide(
                                width: 0.0, color: Colors.lightBlue.shade50);
                          }
                          return BorderSide(
                              width: 0.0,
                              color: Colors.lightBlue
                                  .shade50); // Use the component's default.
                        },
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: (){},
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return kPrimaryColor.withOpacity(0);
                          }
                          return kPrimaryColor
                              .withOpacity(0); // Use the component's default.
                        },
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return kPrimaryColor;
                          }
                          return kPrimaryColor; // Use the component's default.
                        },
                      ),
                      side: MaterialStateProperty.resolveWith<BorderSide?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return BorderSide(
                                width: 0.0, color: Colors.lightBlue.shade50);
                          }
                          return BorderSide(
                              width: 0.0,
                              color: Colors.lightBlue
                                  .shade50); // Use the component's default.
                        },
                      ),
                    ),
                    child: Text("Accept Order",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}