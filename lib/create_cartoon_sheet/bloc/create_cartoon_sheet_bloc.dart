import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hawktoons/create_cartoon_sheet/bloc/bloc.dart';

export 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';

class CreateCartoonSheetBloc extends Bloc<
    CreateCartoonSheetEvent, CreateCartoonSheetState> {
  CreateCartoonSheetBloc() : super(
    CreateCartoonSheetState.initial()
  );


  @override
  Stream<CreateCartoonSheetState> mapEventToState(
      CreateCartoonSheetEvent event,
      ) async* {
    if (event is UpdateFile) {
      yield* _mapUpdateFileToState();
    }
  }

  Stream<CreateCartoonSheetState> _mapUpdateFileToState() async* {

  }
}
