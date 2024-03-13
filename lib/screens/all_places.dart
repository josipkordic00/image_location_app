import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllPlaces extends ConsumerStatefulWidget {
  const AllPlaces({super.key});

  @override
  ConsumerState<AllPlaces> createState() {
    return _AllPlacesState();
  }
}

class _AllPlacesState extends ConsumerState<AllPlaces> {
  late Future<void> _placesData;
  @override
  void initState() {
    super.initState();

    _placesData = ref.read(placesProvider.notifier).loadData();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);
    Widget content;

    if (places.isEmpty) {
      content = Center(
        child: Text(
          'No items here, add some!',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold),
        ),
      );
    } else {
      content = Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: FutureBuilder(
            future: _placesData,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: places.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 16),
                          child: ListTile(
                            key: ValueKey(places[index]),
                            leading: CircleAvatar(
                              radius: 26,
                              backgroundImage: FileImage(places[index].image),
                            ),
                            title: Text(places[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontWeight: FontWeight.bold)),
                            subtitle: Text(places[index].location.address,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    )),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => PlaceDetails(
                                    place: places[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const AddPlace(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: content,
    );
  }
}
