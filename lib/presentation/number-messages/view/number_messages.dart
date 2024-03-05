import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsms/manager/messages-bloc/message_bloc.dart';
import 'package:tsms/presentation/resources/values_manager.dart';

class NumberMessages extends StatelessWidget {
  const NumberMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const NumberMessagesBody(),
    );
  }
}

class NumberMessagesBody extends StatelessWidget {
  const NumberMessagesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
      if (state is MessageSuccess) {
        return ListView.builder(
          itemCount: state.listOfMessage.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(AppPadding.p18.spMin),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('From : ${state.listOfMessage[index].number}'),
                      Container(
                        padding: EdgeInsets.all(AppPadding.p18.spMin),
                        child: Text(state.listOfMessage[index].receivedTime),
                      ),
                    ],
                  ),
                  Text(state.listOfMessage[index].message),
                ],
              ),
            );
          },
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
