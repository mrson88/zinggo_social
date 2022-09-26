import 'package:zinggo_social/models/paging.dart';
import 'package:zinggo_social/providers/api_provider.dart';

abstract class PagingRepo<T> {
  final _apiProvider = ApiProvider();

  String get url;

  Paging? paging;

  bool get isFirstPage => (paging?.cursor ?? '') == '';

  bool get hasNext => paging?.hasNext ?? true;

  String get cursor => paging?.nextCursor ?? '';

  Future<List<T>> getData({Map<String, dynamic>? queryObj}) async {
    if (!hasNext) {
      paging!.cursor = 'a'; // make isFirstPage = false
      return <T>[];
    }

    List? data;

    final res = await _apiProvider.get(url,
        queryParameters: queryObj ?? {'cursor': cursor});

    if (res.statusCode != 200) {
      return <T>[];
    }

    if (res.data['paging'] != null) {
      paging = Paging.fromJson(res.data['paging']);
    }

    data = res.data['data'];

    return data!.map((json) => parseJSON(json)).toList();
  }

  T parseJSON(Map<String, dynamic> json);

  void refresh() {
    paging = null;
  }
}
