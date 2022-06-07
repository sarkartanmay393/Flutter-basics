
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location.dart';

class LocationInputAndViewer extends StatefulWidget {
  const LocationInputAndViewer({Key? key}) : super(key: key);

  @override
  State<LocationInputAndViewer> createState() => _LocationInputAndViewerState();
}

class _LocationInputAndViewerState extends State<LocationInputAndViewer> {
  String _MapPreviewImageLink = '';

  Future<void> _getCurrentLocation() async {
    final currentLocation = await Location().getLocation();
    final previewLink = LocationHelper.getStaticMapPreviewLink(
      latitude: currentLocation.latitude!,
      longitude: currentLocation.longitude!,
    );
    print(previewLink);
    setState(() {
      _MapPreviewImageLink = previewLink;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: _MapPreviewImageLink.isEmpty
                ? const Center(
                    child: Text("No Location Chosen."),
                  )
                : Image.network(
                    _MapPreviewImageLink,
                    fit: BoxFit.cover,
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on_outlined),
                label: const Text("Current Location"),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_location),
                label: const Text("Select Location"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
