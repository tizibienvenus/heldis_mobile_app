import 'package:flutter/material.dart';
import 'package:heldis/constants/constants.dart';

class PremiumCard extends StatelessWidget{
  const PremiumCard({super.key});
  @override
  Widget build(BuildContext context){
    return Container(
      //margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding / 3),
        gradient: const LinearGradient(
                begin: Alignment(0, -3),
                end: Alignment(1, 3),
                colors: [
                  kEmailPrimaryColor, 
                  kPrimaryColor
                ],
              ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Premium",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),
              ),
              Text(
                "XAF 2000",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding,),
          Text(
            "Unlock all our features to be in complete control of your Experience",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),
          ),
          const SizedBox(height: kDefaultPadding,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Upgrade now",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}