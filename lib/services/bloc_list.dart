import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/auth/auth_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/get_user/get_user_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/register_kit/register_kit_bloc.dart';
import 'package:heldis/screens/history/blocs/get_coordinate_history/get_coordinate_history_bloc.dart';
import 'package:heldis/screens/home/blocs/bloc/get_last_position_bloc.dart';
import 'package:heldis/screens/kit/blocs/get_children/get_children_bloc.dart';
import 'package:heldis/screens/kit/blocs/handle_child/handle_child_bloc.dart';
import 'package:heldis/screens/kit/blocs/zone_handle/zone_handle_bloc.dart';
import 'package:heldis/screens/profile/blocs/handle_profile/handle_profile_bloc.dart';
import 'package:heldis/services/session/connexion/connexion_bloc.dart';
import 'package:heldis/services/payment/blocs/get_plans/get_plans_bloc.dart';
import 'package:heldis/services/payment/blocs/payment/payment_bloc.dart';
import 'package:heldis/services/services_injection.dart';
import 'package:heldis/services/session/selected_kit/selected_kit_bloc.dart';

List blocProviderList = [
  BlocProvider(create: (context) => sl<AuthBloc>()),
  BlocProvider(create: (context) => sl<RegisterKitBloc>()),
  BlocProvider(create: (context) => sl<GetUserBloc>()),
  BlocProvider(create: (context) => sl<GetPlansBloc>()),
  BlocProvider(create: (context) => sl<PaymentBloc>()),
  BlocProvider(create: (context) => sl<ConnexionBloc>()),
  BlocProvider(create: (context) => sl<GetChildrenBloc>()),
  BlocProvider(create: (context) => sl<ZoneHandleBloc>()),
  BlocProvider(create: (context) => sl<SelectedKitBloc>()),
  BlocProvider(create: (context) => sl<GetCoordinateHistoryBloc>()),
  BlocProvider(create: (context) => sl<GetLastPositionBloc>()),
  BlocProvider(create: (context) => sl<HandleProfileBloc>()),
  BlocProvider(create: (context) => sl<HandleChildBloc>()),
];
