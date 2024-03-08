import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsms/manager/messages-bloc/message_bloc.dart';
import 'package:tsms/presentation/resources/style.dart';
import 'package:tsms/presentation/resources/values_manager.dart';

class NumberMessages extends StatelessWidget {
  const NumberMessages({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<MessageBloc>(context).add(
              ChooseNumber(
                url: url,
              ),
            );
          },
          child: NumberMessagesBody(url: url)),
    );
  }
}

// ignore: must_be_immutable
class NumberMessagesBody extends StatelessWidget {
  NumberMessagesBody({super.key, required this.url});

  final String url;

  // page
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
      if (state is MessageSuccess) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.listOfMessage.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(AppPadding.p16.spMin),
                    margin: const EdgeInsets.all(AppMargin.m16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s4),
                      color: Colors.white,
                      boxShadow: AppStyles.shadows,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('From : ${state.listOfMessage[index].number}'),
                            Container(
                              padding: EdgeInsets.all(AppPadding.p18.spMin),
                              child:
                                  Text(state.listOfMessage[index].receivedTime),
                            ),
                          ],
                        ),
                        Text(
                          state.listOfMessage[index].message.trim(),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            state.pageNumber.isNotEmpty
                ? SizedBox(
                    height: 60.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () => _goToPrevious(
                              context, state.pageNumber.first, url),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text(
                          '$page page of  ${state.pageNumber.last}  page(s)',
                        ),
                        IconButton(
                          onPressed: () => _goToNextPage(
                              context, state.pageNumber.last, url),
                          icon: const Icon(
                            Icons.arrow_forward,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  _goToPrevious(BuildContext context, int firstPageIndex, url) {
    print(page);
    if (page != firstPageIndex) {
      page--;
      BlocProvider.of<MessageBloc>(context)
          .add(ChooseNumber(url: '$url?page=$page'));
    }
  }

  _goToNextPage(BuildContext context, int lastPageIndex, url) {
    if (page != lastPageIndex) {
      page++;
      BlocProvider.of<MessageBloc>(context)
          .add(ChooseNumber(url: '$url?page=$page'));
    }
  }
}
