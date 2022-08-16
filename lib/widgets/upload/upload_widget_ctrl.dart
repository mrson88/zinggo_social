import 'package:flutter/material.dart';

import 'package:zinggo_social/widgets/upload/upload_widget_value.dart';

class UploadWidgetController extends ValueNotifier<UploadWidgetValue> {
  UploadWidgetController() : super(const UploadWidgetValue());

  double get progress => value.progress ?? 0.0;

  UploadWidgetState get state {
    if (progress == 1) {
      return UploadWidgetState.done;
    } else if (progress == 0) {
      return UploadWidgetState.init;
    }

    return UploadWidgetState.uploading;
  }

  set progress(double progress) {
    value = value.copyWith(progress: progress);
  }

  void clear() {
    value = const UploadWidgetValue();
    // value =  UploadWidgetValue();
  }
}

enum UploadWidgetState {
  init,
  uploading,
  done,
}
