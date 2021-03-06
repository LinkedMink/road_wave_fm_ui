import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/geolocation_model.dart';
import '../models/search_location_model.dart';

class SearchAutocomplete extends StatelessWidget {
  const SearchAutocomplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTrackingLocation =
        context.select<GeolocationModel, bool>((m) => m.isTrackingLocation);
    final search = context.watch<SearchLocationModel>();

    return !isTrackingLocation
        ? TextFormField(
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
                border: const UnderlineInputBorder(),
                hintText: 'Search',
                filled: true,
                fillColor: theme.cardColor),
            autofocus: true,
            onFieldSubmitted: (query) {
              debugPrint('movieTitle: ${search.currentQuery}');
              // search.search(query)
            })
        : Container();
  }
}
