import 'package:heldis/screens/authentification/presentation/blocs/get_user/get_user_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/register_kit/register_kit_bloc.dart';
import 'package:heldis/screens/history/blocs/get_coordinate_history/get_coordinate_history_bloc.dart';
import 'package:heldis/screens/history/controller/history_remote_datasource.dart';
import 'package:heldis/screens/history/controller/history_usecase.dart';
import 'package:heldis/screens/home/blocs/bloc/get_last_position_bloc.dart';
import 'package:heldis/screens/kit/blocs/get_children/get_children_bloc.dart';
import 'package:heldis/screens/kit/blocs/handle_child/handle_child_bloc.dart';
import 'package:heldis/screens/kit/blocs/zone_handle/zone_handle_bloc.dart';
import 'package:heldis/screens/kit/controller/kit_remote_datasource.dart';
import 'package:heldis/screens/kit/controller/kit_usecase.dart';
import 'package:heldis/screens/profile/blocs/handle_profile/handle_profile_bloc.dart';
import 'package:heldis/screens/profile/controller/profile_remote_datasource.dart';
import 'package:heldis/screens/profile/controller/profile_usecase.dart';
import 'package:heldis/services/session/connexion/connexion_bloc.dart';
import 'package:heldis/services/payment/blocs/get_plans/get_plans_bloc.dart';
import 'package:heldis/services/payment/blocs/payment/payment_bloc.dart';
import 'package:heldis/services/payment/data/payment_remote_datasource.dart';
import 'package:heldis/services/payment/domain/payment_usecase.dart';
import 'package:heldis/services/session/selected_kit/selected_kit_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heldis/screens/authentification/data/datasource/auth_remote_datasource.dart';
import 'package:heldis/screens/authentification/domain/usecase/auth_usecase.dart';
import 'package:heldis/screens/authentification/presentation/blocs/auth/auth_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initServices() async {
  await GetStorage.init();
  sl
    ..registerFactory<AuthBloc>(() => AuthBloc(authUsecase: sl()))
    ..registerLazySingleton<AuthUsecase>(
        () => AuthUsecase(authRemoteDataSource: sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(client: sl()))
    ..registerLazySingleton(http.Client.new);
  sl
    ..registerFactory<RegisterKitBloc>(
        () => RegisterKitBloc(authUsecase: sl()));

  sl.registerFactory<GetUserBloc>(() => GetUserBloc(authUsecase: sl()));

  sl
    ..registerFactory<GetPlansBloc>(() => GetPlansBloc(paymentUsecase: sl()))
    ..registerLazySingleton<PaymentUsecase>(
        () => PaymentUsecase(paymentRemoteDataSource: sl()))
    ..registerLazySingleton<PaymentRemoteDataSource>(
        () => PaymentRemoteDataSourceImpl(client: sl()));

  sl.registerFactory<PaymentBloc>(() => PaymentBloc(paymentUsecase: sl()));
  sl.registerFactory<ConnexionBloc>(() => ConnexionBloc());
  sl
    ..registerFactory<GetChildrenBloc>(() => GetChildrenBloc(kitUseCase: sl()))
    ..registerLazySingleton<KitUseCase>(
        () => KitUseCase(kitRemoteDataSource: sl()))
    ..registerLazySingleton<KitRemoteDataSource>(
        () => KitRemoteDataSourceImpl(client: sl()));
  sl.registerFactory<HandleChildBloc>(() => HandleChildBloc(kitUsecase: sl()));
  sl
    ..registerFactory<GetCoordinateHistoryBloc>(
        () => GetCoordinateHistoryBloc(historyUseCase: sl()))
    ..registerLazySingleton<HistoryUseCase>(
        () => HistoryUseCase(historyRemoteDataSource: sl()))
    ..registerLazySingleton<HistoryRemoteDataSource>(
        () => HistoryRemoteDataSourceImpl(client: sl()));
  sl
    ..registerFactory<HandleProfileBloc>(
        () => HandleProfileBloc(profileUseCase: sl()))
    ..registerLazySingleton<ProfileUseCase>(
        () => ProfileUseCase(profileRemoteDataSource: sl()))
    ..registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(client: sl()));
  sl.registerFactory<GetLastPositionBloc>(
      () => GetLastPositionBloc(historyUseCase: sl()));
  sl.registerFactory<ZoneHandleBloc>(() => ZoneHandleBloc(kitUseCase: sl()));
  sl.registerFactory<SelectedKitBloc>(() => SelectedKitBloc());
}
