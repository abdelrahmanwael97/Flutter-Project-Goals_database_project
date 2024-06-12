part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class GetDataSuccessState extends MainState {}
class GetDataLoadingState extends MainState {}
class GetDataErrorState extends MainState {}

class InsertDataSuccessState extends MainState {}
class InsertDataLoadingState extends MainState {}
class InsertDataErrorState extends MainState {}

class RemoveDataSuccessState extends MainState {}
class RemoveDataLoadingState extends MainState {}
class RemoveDataErrorState extends MainState {}
