import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinggo_social/blocs/blocs.dart';
import 'package:zinggo_social/repositories/repositories.dart';

class HomeTest2 extends StatefulWidget {
  const HomeTest2({Key? key}) : super(key: key);
  static const String id = 'Home_Test2';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: id),
      builder: (_) => const HomeTest2(),
    );
  }

  @override
  State<HomeTest2> createState() => _HomeTest2();
}

class _HomeTest2 extends State<HomeTest2> {
  late final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
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
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  {
                    print(state.model.length);

                    return index >= state.model.length
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                            ),
                          )
                        : ListTile(
                            leading: Text(
                              '${state.model[index].user.firstName}',
                              style: const TextStyle(color: Colors.blueGrey),
                            ),
                          );
                  }
                },
                controller: _scrollController,
                itemCount: state.model.length >= 25
                    ? state.model.length
                    : state.model.length + 1,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _onScroll() {
    print(
        'extendAfter: ${_scrollController.position.extentAfter} - extentBefore: ${_scrollController.position.extentBefore}');
    if (_scrollController.position.extentBefore > 300) {
      loadMoreData();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

@override
void loadMoreData() => PostRepository().useHttp();
