import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QrCode extends StatefulWidget {
  const QrCode({
    super.key,
  });

  // const QrCode({Key? key}) : super(key: key);

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  final _screenshotController = ScreenshotController();

  Future<Image>? image;
  String qrString = "Add Data";

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create QR Code"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null)
            Center(
                child: Screenshot(
                    controller: _screenshotController,
                    child: _buildQRImage(qrString))),
          ElevatedButton(
              onPressed: () async {
                await _captureAndSaveQRCode();
              },
              child: const Text("Capture qr code")),
          SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: TextField(
              onChanged: (val) {
                setState(() {
                  qrString = val;
                });
              },
              decoration: const InputDecoration(
                hintText: "Enter you data here",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Text(user.uid.toString()),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  qrString = user.uid;
                });
              },
              child: const Text("Creat my qrcode")),
        ],
      ),
    );
  }

  Widget _buildQRImage(String data) {
    return QrImage(
      data: data,
      size: 250.0,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.H,
      gapless: false,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    );
  }

  Future<String> get imagePath async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    return '$directory/qr.png';
  }

  Future<Image> _loadImage() async {
    return await imagePath.then((imagePath) => Image.asset(imagePath));
  }

  Future<void> _captureAndSaveQRCode() async {
    final imageDirectory = await imagePath;

    _screenshotController.captureAndSave(imageDirectory);
    setState(() {
      image = _loadImage();
      print(imageDirectory);
    });
  }

  @override
  void initState() {
    image = _loadImage();
    super.initState();
  }
}
