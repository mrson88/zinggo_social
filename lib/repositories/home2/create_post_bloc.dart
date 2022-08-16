import 'create_post_repo.dart';

class CreatePostBloc {
  Future<bool> createPost(String des, List<String> ids) async {
    try {
      final data = {"description": des, "img_upload_ids": ids};

      return CreatePostRepo().postData(data);
    } catch (e) {
      rethrow;
    }
  }
}
