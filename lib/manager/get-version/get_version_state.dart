part of 'get_version_bloc.dart';

@immutable
sealed class GetVersionState {}

final class GetVersionInitial extends GetVersionState {}

final class GetVersionLoading extends GetVersionState {}

final class GetVersionSuccess extends GetVersionState {
  final bool isFirebaseInit;
  final double version;

  GetVersionSuccess({required this.isFirebaseInit, required this.version});
}

final class GetVersionFailure extends GetVersionState {}
