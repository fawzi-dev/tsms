import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:tsms/presentation/number-messages/view_model/message.dart';
part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial()) {
    on<MessageEvent>((event, emit) async {
      if (event is ChooseNumber) {
        try {
          emit(MessageLoading());
          var response = await http.get(Uri.parse(event.url));

          var document = parser.parse(response.body);
          List<SmsMessage> messages = [];

          var rows = document.querySelectorAll('.messagesTable tbody tr');
          for (var row in rows) {
            var number =
                row.querySelector('td:nth-child(1)')?.text.trim() ?? '';
            var receivedTime =
                row.querySelector('td:nth-child(3)')?.text.trim() ?? '';
            var message =
                row.querySelector('td:nth-child(5)')?.text.trim() ?? '';

            var pages = document.querySelectorAll('.pagination a');
            final Set<int> listOfPageNumber = {};

            if (pages.isNotEmpty) {
              for (var i in pages) {
                var page = i.text;

                int? pageIndex = int.tryParse(page);

                if (pageIndex != null) {
                  listOfPageNumber.add(pageIndex);
                }
              }
            }

            //print('$receivedTime , $number, $message');

            messages.add(
              SmsMessage(
                  number: number, receivedTime: receivedTime, message: message),
            );

            messages.isNotEmpty
                ? emit(
                    MessageSuccess(
                      listOfMessage: messages,
                      pageNumber: listOfPageNumber.toList()..sort(),
                    ),
                  )
                : [];
          }
        } catch (e) {
          emit(
            MessageFailed(message: 'Something went wrong, Please try again.'),
          );
        }
      }
    });
  }
}
