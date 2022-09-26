import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinggo_social/blocs/home2/post2_bloc.dart';
import 'package:zinggo_social/modules/home/screens/create_post_page.dart';
import 'package:zinggo_social/screens/home2/post_list.dart';


class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);
  static const String id = 'postpage2';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: id),
      builder: (_) => const PostPage(),
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
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreatePostPage()),
        ),
      ),
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
        create: (_) => Post2Bloc()..add(PostFetched()),
        child: const PostList(),
      ),
    );
  }
}
