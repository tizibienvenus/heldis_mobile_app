import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heldis/common/tools.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';
import 'package:heldis/screens/authentification/presentation/blocs/auth/auth_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/get_user/get_user_bloc.dart';
import 'package:heldis/screens/layout/check_connection_screen.dart';
import 'package:heldis/services/session/connexion/connexion_bloc.dart';
import 'package:heldis/services/payment/blocs/get_plans/get_plans_bloc.dart';
import 'package:heldis/services/payment/blocs/payment/payment_bloc.dart';
import 'package:heldis/services/payment/data/model/plan_response_model.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  void initState() {
    super.initState();
    initPlans();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<GetPlansBloc>().state is GetPlansError) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
            "Error to get plans : ${(context.watch<GetPlansBloc>().state as GetPlansError).message}"),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => initPlans(),
          child: const Text("Refresh"),
        ),
      ]);
    }
    if (context.watch<GetPlansBloc>().state is GetPlansLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is BuyPlanError) {
          showErrorSnackBar(context: context, message: state.message);
        }
      },
      child: Builder(builder: (context) {
        return context.watch<PaymentBloc>().state is BuyPlanLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Subscribe to access to all feature!"),
                  const SizedBox(height: 20),
                  if (context
                          .watch<ConnexionBloc>()
                          .state
                          .user
                          ?.subscriptionIsActive ==
                      SubscriptionStatus.failed)
                    Container(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(children: [
                        Text(
                          "Last Payment Failed",
                          style: TextStyle(fontSize: 20),
                        ),
                      ]),
                    )
                  else if (context.watch<PaymentBloc>().state
                          is BuyPlanSuccess ||
                      context
                              .watch<ConnexionBloc>()
                              .state
                              .user
                              ?.subscriptionIsActive ==
                          SubscriptionStatus.pending)
                    BlocListener<GetUserBloc, GetUserState>(
                      listener: (context, state) {
                        if (state is GetUserError) {
                          showErrorSnackBar(
                              context: context, message: state.message);
                        }
                        if (state is GetUserSuccess) {
                          showWarningSnackBar(
                              context: context,
                              message: [
                                state.user.subscriptionIsActive.toString(),
                                state.user.subscriptions?.last.endsAt
                                    ?.toString(),
                                state.user.subscriptions?.last.startAt
                                    ?.toString(),
                              ].toString());
                          context.read<ConnexionBloc>().add(ConnexionLoadEvent(
                              user: state.user,
                              token: box.read("token"),
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString()));
                          print(context
                              .read<ConnexionBloc>()
                              .state
                              .user
                              ?.subscriptionIsActive);
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const CheckConnectionScreen(),
                          //   ),
                          //   (route) => false,
                          // );
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          context.read<GetUserBloc>().add(const GetUser());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          margin: const EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(children: [
                            const Text(
                              "Payment in progress",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text("Tap here to check status",
                                style: TextStyle(fontSize: 14)),
                            if (context.watch<GetUserBloc>().state
                                is GetUserLoading)
                              const CircularProgressIndicator()
                            else
                              const Icon(Icons.refresh, size: 25),
                          ]),
                        ),
                      ),
                    ),
                  if (context.watch<GetPlansBloc>().state is GetPlansSuccess)
                    Column(children: [
                      for (var plan in (context.watch<GetPlansBloc>().state
                              as GetPlansSuccess)
                          .plans)
                        PlanCard(
                          plan: plan,
                        ),
                    ])
                ],
              );
      }),
    );
  }

  initPlans() {
    if (context.read<GetPlansBloc>().state is! GetPlansSuccess) {
      context.read<GetPlansBloc>().add(GetPlans());
    } else {
      if ((context.read<GetPlansBloc>().state as GetPlansSuccess)
          .plans
          .isEmpty) {
        context.read<GetPlansBloc>().add(GetPlans());
      }
    }
  }
}

class PlanCard extends StatefulWidget {
  const PlanCard({
    super.key,
    required this.plan,
  });

  final PlanModel plan;

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("OM/MOMO Payment",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: phoneNumberController,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  labelStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.blue[50],
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  if (phoneNumberController.text.isEmpty) {
                    showErrorSnackBar(
                      context: context,
                      message: "Please enter your phone number",
                    );
                    return;
                  }
                  context.read<PaymentBloc>().add(BuyPlanEvent(
                        planId: widget.plan.id ?? 0,
                        phone: phoneNumberController.text,
                        amount: widget.plan.price?.toDouble() ?? 0,
                      ));
                  Navigator.pop(context);
                },
                child: const Text("Pay"),
              )
            ]),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.plan.name ?? "Free",
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Text(
              widget.plan.description ?? "",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "${widget.plan.price ?? ""} FCFA",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
