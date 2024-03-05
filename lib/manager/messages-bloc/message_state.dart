part of 'message_bloc.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessageLoading extends MessageState {}

final class MessageSuccess extends MessageState {
  final List<SmsMessage> listOfMessage;
  final List<int> pageNumber;

  MessageSuccess({required this.listOfMessage, required this.pageNumber});
}

final class MessageFailed extends MessageState {
  final String message;

  MessageFailed({required this.message});
}
