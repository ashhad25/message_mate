import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_clone/image_preview.dart';

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  String imagePath = "";
  int selectedCameraIndex = 1;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
    initializeCamera(selectedCameraIndex);
  }

  void initializeCamera(int cameraIndex) {
    controller = CameraController(cameras![cameraIndex], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void toggleFlash() async {
    if (controller != null) {
      isFlashOn = !isFlashOn;
      await controller!
          .setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);
      setState(() {});
    }
  }

  void toggleCamera() {
    if (cameras != null && cameras!.isNotEmpty) {
      selectedCameraIndex = (selectedCameraIndex == 0) ? 1 : 0;
      initializeCamera(selectedCameraIndex);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return Stack(
      children: [
        Align(
          child: Container(
            height: 500,
            child: AspectRatio(
              aspectRatio: controller!.value.aspectRatio,
              child: CameraPreview(controller!),
            ),
          ),
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.only(top: 40, left: 10),
              child: IconButton(
                  iconSize: 40,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.clear)),
            )),
        Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.only(top: 40, right: 10),
              child: IconButton(
                iconSize: 40,
                color: Colors.white,
                onPressed: toggleFlash,
                icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
              ),
            )),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 90),
              child: IconButton(
                  color: Colors.white,
                  iconSize: 50,
                  onPressed: () async {
                    try {
                      final image = await controller!.takePicture();
                      setState(() async {
                        imagePath = image.path;
                        if (imagePath != '') {
                          final bytes = await File(imagePath).readAsBytes();
                          img.Image originalImage = img.decodeImage(bytes)!;

                          // Flip the image horizontally if it's from the front camera
                          if (selectedCameraIndex == 1) {
                            originalImage = img.flipHorizontal(originalImage);
                          }

                          final tempDir = await getTemporaryDirectory();
                          final flippedImagePath =
                              '${tempDir.path}/flipped_image.jpg';
                          final flippedImageFile = File(flippedImagePath)
                            ..writeAsBytesSync(img.encodeJpg(originalImage));

                          await ImageGallerySaver.saveFile(
                              flippedImageFile.path);
                          await controller!.setFlashMode(FlashMode.off);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImagePreview(
                                      imagePath: flippedImageFile.path)));
                        }
                      });
                      setState(() {
                        isFlashOn = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: Icon(Icons.camera)),
            )),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: Container(
                child: IconButton(
                    iconSize: 50,
                    color: Colors.white,
                    onPressed: toggleCamera,
                    icon: Icon(Icons.refresh)),
              ),
            )),
      ],
    );
  }
}
