import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zinggo_social/models/models.dart';
import '../../../providers/api_provider.dart';
import '../image_upload_item.dart';
import '../manage_group/upload_group_state_ctrl.dart';
import '../manage_group/upload_group_value.dart';
import '../upload_item.dart';

class ImageUploadGroup extends StatefulWidget {
  final int maxImage;
  final List<ImageUploadItem> listImages;
  final String folder;
  final bool isFullGrid;
  final Function(UploadGroupValue) onValueChanged;

  const ImageUploadGroup({
    Key? key,
    this.maxImage = 5,
    required this.listImages,
    required this.onValueChanged,
    this.folder = "post",
    this.isFullGrid = true,
  }) : super(key: key);

  @override
  _ImageUploadGroupState createState() => _ImageUploadGroupState();
}

class _ImageUploadGroupState extends State<ImageUploadGroup> {
  final apiProvider = ApiProvider();
  final controller = UploadGroupStateController();

  List<ImageUploadItem> _lstImageParam = <ImageUploadItem>[];

  int maxImageInRow = 3;
  int spacingItem = 8;

  int? _imgWidth;
  int? _imgHeight;

  double aspectRatio = 0.75;

  int get maxImage => widget.maxImage;

  int get realMaxImage =>
      maxImage - _lstImageParam.where((e) => e.asset == null).length;

  bool get isReady => _lstImageParam.where((e) => e.id == "").isEmpty;

  List<Asset> get _selectedAssets => _lstImageParam
      .where((e) => e.asset != null)
      .map((e) => e.asset!)
      .toList();

  @override
  void initState() {
    super.initState();

    _lstImageParam = widget.listImages;

    controller.addListener(_didChangeValue);
  }

  @override
  void dispose() {
    controller.removeListener(_didChangeValue);
    super.dispose();
  }

  void _didChangeValue() {
    widget.onValueChanged(controller.value);
  }

  @override
  Widget build(BuildContext context) {
    final screenWith = MediaQuery.of(context).size.width;
    const marginHorizontal = 16;

    _imgWidth = ((screenWith -
                (marginHorizontal * 2) -
                (spacingItem * (maxImageInRow - 1))) ~/
            maxImageInRow)
        .toInt();

    _imgHeight = (_imgWidth! ~/ aspectRatio).toInt();

    return buildGridView();
  }

  Widget buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: maxImageInRow,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.isFullGrid
          ? maxImage
          : min(_lstImageParam.length + 1, maxImage),
      itemBuilder: (context, index) {
        if (widget.isFullGrid) {
          if (index >= _lstImageParam.length) {
            return buildItemImage(image: _lstImageParam[index], index: index);
          } else {
            return buildItemImage(image: _lstImageParam[index], index: index);
          }
        } else {
          if (index < _lstImageParam.length) {
            return buildItemImage(image: _lstImageParam[index], index: index);
          }
          if (index == _lstImageParam.length) return buildItemAddImage(index);
          return Container();
        }
      },
    );
  }

  Widget buildItemImage({required ImageUploadItem image, required int index}) {
    //print("build $index");
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          //padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: UploadItem(
              controller: image.controller!,
              onDelete: () => removeImage(index),
              showDeleteButton: true,
              placeholder: image.placeHolder,
            ),
          ),
        ),
        Positioned(
          left: 5.0,
          bottom: 5.0,
          child: Material(
            color: Colors.transparent,
            child: Text(
              "${index + 1}",
              // style: StylesText.body20CenterBold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildItemAddImage(index) {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      color: Theme.of(context).primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () async {
          await chooseAndUploadImage();
          // pickImageDone();
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              left: 5.0,
              bottom: 5.0,
              child: Text(
                "${index + 1}",
              ),
            ),
            const Positioned(
              top: 5.0,
              right: 5.0,
              child: Material(
//                    color: Theme.of(context).backgroundColor,
                elevation: 3.0,
                shape: CircleBorder(),
                child: Icon(
                  Icons.add_circle,
                  // color: MyColors.orangeLight,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> chooseAndUploadImage() async {
    List<Asset> resultList = <Asset>[];
    var localListImg = <ImageUploadItem>[];

    final currentStatus = await Permission.photos.status;

    if (currentStatus == PermissionStatus.denied ||
        currentStatus == PermissionStatus.restricted) {
      await Permission.photos.request();
    } else if (currentStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: realMaxImage,
        enableCamera: true,
        selectedAssets: _selectedAssets,
        cupertinoOptions: const CupertinoOptions(
          takePhotoIcon: "chat",
          //backgroundColor: "#${Colors.black.value.toRadixString(16)}",
        ),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Dofhunt",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );

      if (resultList.isEmpty) return;

      for (int i = 0; i < resultList.length; i++) {
        var r = resultList[i];

        String? imageName = r.name;

        if (_lstImageParam.isNotEmpty) {
          var foundIdx =
              (_lstImageParam.indexWhere((x) => x.name == imageName));

          if (foundIdx != -1) {
            localListImg.add(_lstImageParam[foundIdx]);
            continue;
          }
        }

        var thumbData = await r.getThumbByteData(
            _imgWidth!.ceil() * 2, _imgHeight!.ceil() * 2,
            quality: 100);
        var placeHolder = Image.memory(thumbData.buffer.asUint8List());

        ImageUploadItem imageParam =
            ImageUploadItem(r, imageName!, placeHolder);
        localListImg.add(imageParam);

        uploadImage(imageParam);
      }

      _lstImageParam = [
        ..._lstImageParam.where((e) => e.asset == null).toList(),
        ...localListImg
      ];
      // update controller value
      controller.value = controller.value.withValue(_lstImageParam);
    } on Exception catch (e) {
      debugPrint('$e');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (resultList.isNotEmpty) {
      setState(() {});

      final copyList = _lstImageParam.toList();

      for (int i = 0; i < copyList.length; i++) {
        if (i >= _lstImageParam.length) continue;
        if (_lstImageParam[i].state == "init") uploadImage(_lstImageParam[i]);
      }
    }
  }

  void removeImage(index) {
    final imgUplItem = _lstImageParam[index];
    imgUplItem.cancelToken!.cancel();

    _lstImageParam.removeAt(index);
    // commit changes
    setState(() {});

    controller.value = controller.value.withValue(_lstImageParam);
  }

  void uploadImage(ImageUploadItem item) async {
    try {
      FormData formData;

      var originData = await item.asset!.getByteData();

      formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(originData.buffer.asUint8List(),
            filename: "${DateTime.now().millisecondsSinceEpoch}.jpg"),
        'folder': widget.folder,
      });

      var result = await apiProvider.post('/upload', data: formData,
          onSendProgress: (int sent, int total) {
        // strict: don't set process to 1.0 because server need time to
        // handle images
        if (sent == total) {
          item.controller!.progress = 0.999;
        } else {
          item.controller!.progress = sent / total;
        }
      }, cancelToken: item.cancelToken);

      item.id = result.data['data']['id'];
      item.picture = Picture.fromJson(result.data['data']['image']);
      item.controller!.progress = 1.0; // done

      // Update controller value
      controller.value = controller.value.withValue(_lstImageParam);
    } catch (e) {
      debugPrint('$e');
      item.setError(e.toString()); // not need right now

      final idx = _lstImageParam.indexOf(item);
      removeImage(idx);
    }
  }
}
