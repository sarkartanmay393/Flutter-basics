import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/nearby_places.dart';
import '../widgets/image_setup.dart';
import '../widgets/location_setup.dart';

class PlaceAddingScreen extends StatefulWidget {
  static const routeName = "AddNew";

  const PlaceAddingScreen({Key? key}) : super(key: key);

  @override
  State<PlaceAddingScreen> createState() => _PlaceAddingScreenState();
}

class _PlaceAddingScreenState extends State<PlaceAddingScreen> {
  // final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  late File _pickedImage;

  void ImageGetter(File pi) {
    _pickedImage = pi;
  }

  void _onSaved() {
    if (_titleController.text == null || _pickedImage == null) {
      return;
    }
    Provider.of<NearbyPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage,
    );
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text(
            "New Place has been Added.",
            style: TextStyle(fontSize: 12),
          ),
          titlePadding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 2,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              "Enter Location Information :",
              style: Theme.of(context).textTheme.bodyLarge?.merge(
                    const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Title",
                    ),
                    controller: _titleController,
                  ),
                  ImageInputAndViewer(ImageGetter),
                  LocationInputAndViewer(),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: MaterialStateProperty.all(0),
              ),
              onPressed: _onSaved,
              icon: const Icon(Icons.save_outlined),
              label: const Text("Save Location"),
              clipBehavior: Clip.hardEdge,
            ),
          ],
        ),
      ),
    );
  }
}
