import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zinggo_social/themes/app_color.dart';
import '../../themes/app_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinggo_social/home/bloc/post_bloc.dart';
import 'package:zinggo_social/home/repository/post_repository.dart';

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);
  static String id = 'Home_2';

  @override
  State<Home2> createState() => _Home2();
}

// String hour = ['created_at'].toString().split(':')[1];
// String minute = ['created_at'].toString().split(':')[2];

class _Home2 extends State<Home2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: getBody(),
    );
  }

  Widget getBody() {
    return BlocProvider(
      create: (context) => PostBloc(
        RepositoryProvider.of<PostRepository>(context),
      )..add(LoadApiEvent()),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoadingState) {
            return (const Center(
              child: CircularProgressIndicator(),
            ));
          }
          if (state is PostLoadedState) {
            return ListView(children: [
              Container(
                margin: const EdgeInsets.only(top: 18, left: 14, right: 15),
                child: CupertinoSearchTextField(
                  itemColor: AppColors.white,
                  itemSize: 26,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColors.blur),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, bottom: 24),
                child: Text(
                  "What's new?",
                  style: AppStyles.h1,
                ),
              ),
              _scrollViewHorizontal(state),
              _scrollViewVetical(state, context)
            ]);
          }
          return Container();
        },
      ),
    );
  }
}

SingleChildScrollView _scrollViewHorizontal(users) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: users.model.isNotEmpty
        ? Row(
            children: List.generate(users.model.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 18, left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 135,
                                width: 135,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            users.model[index].user.avatar.url),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(users
                                                  .model[index]
                                                  .user
                                                  .avatar
                                                  .url),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        ('${users.model[index].user.firstName} ${users.model[index].user.lastName}'),
                                        style: AppStyles.h5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // user[index]['status'].toString() == 'online'
                          //     ? Positioned(
                          //         top: 45,
                          //         left: 42,
                          //         child: Container(
                          //           width: 15,
                          //           height: 15,
                          //           decoration: BoxDecoration(
                          //             color: Colors.green,
                          //             shape: BoxShape.circle,
                          //             border: Border.all(
                          //                 color: AppColors.textColor,
                          //                 width: 2.5),
                          //           ),
                          //         ),
                          //       )
                          //     : Container()
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          )
        : Container(),
  );
}

Widget _scrollViewVetical(users, context) {
  // String hour(int index) {
  //   return chatUser[index]['created_at'].toString().split(':')[1];
  // }
  //
  // String minute(int index) {
  //   return chatUser[index]['created_at'].toString().split(':')[2].split('.')[0];
  // }

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
          users.model.length,
          (index) => Container(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: AppColors.darkGray,
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    users.model[index].user.avatar.url),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${users.model[index].user.firstName}'
                              ' ${users.model[index].user.lastName}',
                              style: AppStyles.h3,
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: const Text(
                                '',
                                // int.parse(hour(index = index)) < 12
                                //     ? '${hour(index = index)} '
                                //         ': ${minute(index = index)} AM'
                                //     : '0${int.parse(hour(index = index)) - 12} '
                                //         ': ${minute(index = index)} PM',
                                // style: AppStyles.h4,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Image(
                              image: NetworkImage(
                                  users.model[index].photos[0].image.url),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Image(
                              image: NetworkImage(
                                  users.model[index].user.avatar.url),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Wrap(
                            spacing: 5.0,
                            runSpacing: 5.0,
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                '${users.model[index].description}',
                                style: AppStyles.h4,
                                maxLines: 4,
                              ),
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
