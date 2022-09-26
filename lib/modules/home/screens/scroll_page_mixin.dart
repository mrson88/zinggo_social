import 'package:flutter/cupertino.dart';

mixin ScrollPageMixin<T extends StatefulWidget> on State<T> {
  ScrollController get scrollController;

  void loadMoreData();

  // final BehaviorSubject<bool> _isLoadingController =
  // BehaviorSubject.seeded(false);

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // print('extendAfter: ${scrollController.position.extentAfter} - extentBefore: ${scrollController.position.extentBefore}');
      if (scrollController.position.extentAfter < 500 &&
          scrollController.position.extentBefore > 100) {
        loadMoreData();
      }
    });
  }

  @override
  void dispose() {
    // _isLoadingController.close();
    super.dispose();
  }
}
