import 'package:flutter/material.dart';
import 'package:zinggo_social/widgets/upload/image_upload_item.dart';
import 'package:zinggo_social/widgets/upload/manage_group/upload_group_value.dart';

class UploadGroupStateController extends ValueNotifier<UploadGroupValue> {
  UploadGroupStateController()
      : super(const UploadGroupValue(<ImageUploadItem>[]));

  set state(UploadGroupValue state) {
    value = state;
  }
}
