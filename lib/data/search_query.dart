import 'package:flutter/foundation.dart';

@immutable
class SearchQuery {
  final double lat;
  final double lng;
  final List<String> formatIds;

  const SearchQuery(this.lat, this.lng, this.formatIds);

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode ^ formatIds.hashCode;

  @override
  bool operator ==(Object other) =>
      other is SearchQuery &&
      other.lat == lat &&
      other.lng == lng &&
      other.formatIds.length == formatIds.length &&
      other.formatIds.every((id) => formatIds.contains(id));

  Map<String, dynamic> toQueryParams() =>
      {'lat': lat.toString(), 'lng': lng.toString(), 'formatIds': formatIds};
}
