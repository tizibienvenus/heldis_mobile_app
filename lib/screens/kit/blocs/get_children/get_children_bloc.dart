import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heldis/screens/kit/controller/kit_usecase.dart';
import 'package:heldis/screens/kit/model/get_all_child_response_model.dart';

part 'get_children_event.dart';
part 'get_children_state.dart';

class GetChildrenBloc extends Bloc<GetChildrenEvent, GetChildrenState> {
  final KitUseCase kitUseCase;
  GetChildrenBloc({required this.kitUseCase}) : super(GetChildrenInitial()) {
    on<GetChildrenEvent>((event, emit) {});

    on<GetChildren>((event, emit) async {
      emit(GetChildrenLoading());

      var response = await kitUseCase.getChildren();

      response.fold((l) {
        emit(GetChildrenError(message: l.message));
      }, (r) {
        emit(GetChildrenSuccess(children: r));
      });
    });
  }
}
