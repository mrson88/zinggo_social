import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinggo_social/blocs/home2/post2_bloc.dart';
import 'package:zinggo_social/screens/home2/post_list.dart';
import 'package:zinggo_social/screens/screens.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);
  static const String id = 'postpage2';
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: id),
      builder: (_) => PostPage(),
    );
  }

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, CreatePostPage.id),
      ),
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
        create: (_) => Post2Bloc()..add(PostFetched()),
        child: PostList(),
      ),
    );
  }
}
