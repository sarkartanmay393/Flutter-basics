import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInputAndViewer extends StatefulWidget {
  final Function ImageGetter;

  const ImageInputAndViewer(this.ImageGetter, {Key? key}) : super(key: key);

  @override
  State<ImageInputAndViewer> createState() => _ImageInputAndViewerState();
}

class _ImageInputAndViewerState extends State<ImageInputAndViewer> {
  var storedFile = false;
  late File ImageFile;

  Future<void> _pickImageFunction() async {
    final picker = ImagePicker();
    try {
      final pickImage = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
      );
      setState(() {
        ImageFile = File(pickImage!.path);
        storedFile = true;
      });
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(pickImage!.path);
      await pickImage.saveTo("${appDir.path}/$fileName");
      widget.ImageGetter(File("${appDir.path}/$fileName"));
    } catch (error) {
      print("Error : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            height: 100,
            width: 100,
            child: storedFile
                ? Image.file(
                    ImageFile,
                    fit: BoxFit.fill,
                    alignment: AlignmentDirectional.center,
                  )
                : const Center(
                    child: Text(
                      "No Image Input",
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          TextButton.icon(
            onPressed: _pickImageFunction,
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text("Camera"),
          ),
        ],
      ),
    );
  }
}
