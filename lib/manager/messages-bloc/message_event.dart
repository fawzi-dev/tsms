part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {}

class ChooseNumber extends MessageEvent {
  final String url;

  ChooseNumber({required this.url});
}
