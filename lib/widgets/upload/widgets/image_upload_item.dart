import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zinggo_social/models/models.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import '../manage_one_item/upload_ctrl.dart';

class ImageUploadItem {
  Asset? _asset;
  String? _name;
  Widget? _placeHolder;
  CancelToken? cancelToken; // for canceling upload request

  String id = "";
  Picture? picture;
  UploadController? controller;

  Asset? get asset => _asset;

  String? get assetName => _asset!.name;

  String? get name => _name;

  Widget? get placeHolder => _placeHolder;

  bool isUploading = false;

  String get state {
    if (id != "" || picture != null) return "Done";
    if (!isUploading) return "init";

    return "Uploading";
  }

  setError(String err) {
    debugPrint(err);
  }

  ImageUploadItem(Asset asset, String name, Image placeHolder) {
    _asset = asset;
    _name = name;
    _placeHolder = placeHolder;
    controller = UploadController();
    cancelToken = CancelToken();
  }
}
