part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final String errorMessage;

  HomeError({required this.errorMessage});
}

final class HomeLoaded extends HomeState {
  final List<FileInfo> pdfFiles;
  HomeLoaded({required this.pdfFiles});
}
