part of 'message_bloc.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessageLoading extends MessageState {}

final class MessageSuccess extends MessageState {
  final List<SmsMessage> listOfMessage;

  MessageSuccess({required this.listOfMessage});
}

final class MessageFailed extends MessageState {
  final String message;

  MessageFailed({required this.message});
}
