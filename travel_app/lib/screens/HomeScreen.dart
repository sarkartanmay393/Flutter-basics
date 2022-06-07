import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/screens/PlaceAddingScreen.dart';

import '../providers/nearby_places.dart';
import '../widgets/story.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appBar = AppBar(
      backgroundColor: Colors.grey.shade300,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello, User !",
            style: Theme.of(context).textTheme.headline6?.merge(
                  const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
          Text(
            "Welcome back and Explore the world.",
            style: Theme.of(context).textTheme.caption?.merge(
                  const TextStyle(
                    color: Colors.black,
                  ),
                ),
          )
        ],
      ),
      actions: [
        AnimSearchBar(
          color: Colors.grey.shade200,
          width: 220,
          textController: searchTextController,
          onSuffixTap: () {},
          rtl: true,
        ),
        IconButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(PlaceAddingScreen.routeName),
          icon: Icon(Icons.add),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          // Stories Row
          SizedBox(
            height: 140,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (ctx, idx) => const StoryGrid(),
              itemCount: 3,
              scrollDirection: Axis.vertical,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            height: size.height - appBar.preferredSize.height - 180,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: FutureBuilder(
              future: Provider.of<NearbyPlaces>(context, listen: false)
                  .fetchAndSetPlaces(),
              builder: (ctx, ss) => ss.connectionState ==
                      ConnectionState.waiting
                  ? const Center(
                      child: Text("Database is getting start."),
                    )
                  : Consumer<NearbyPlaces>(
                      builder: (ctx, NearyPlacesData, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nearby Locations",
                            style: Theme.of(context).textTheme.bodyText1?.merge(
                                  const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          ),
                          Text(
                            "${NearyPlacesData.places.length} Locations found.",
                            style: Theme.of(context).textTheme.caption?.merge(
                                  const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                          ),
                          const Divider(),
                          SizedBox(
                            height: size.height -
                                appBar.preferredSize.height -
                                180 -
                                80,
                            child: NearyPlacesData.places.isEmpty
                                ? const Center(
                                    child: Text("No Nearby Good Locations"),
                                  )
                                : ListView.builder(
                                    itemBuilder: (ctx, idx) => ListTile(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => const Dialog(
                                            alignment:
                                                AlignmentDirectional.bottomEnd,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("U Clicked !"),
                                            ),
                                          ),
                                          useSafeArea: true,
                                        );
                                      },
                                      //leading: CircleAvatar(),
                                      title: Text(
                                          NearyPlacesData.places[idx].name),
                                      subtitle: Row(
                                        children: const [
                                          Icon(Icons.location_on, size: 14),
                                          Text(
                                            // NearyPlacesData.places[idx]
                                            //     .location.address,
                                            'unknown',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      trailing: const Text("\$123/day"),
                                    ),
                                    itemCount: NearyPlacesData.places.length,
                                  ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
