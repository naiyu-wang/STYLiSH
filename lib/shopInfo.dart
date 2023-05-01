import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerGenerator {
  Marker generateMarker(ShopInfo info, {bool isSelected = false}) {
    return Marker(
        markerId: MarkerId(info.id),
        position: LatLng(info.latitude, info.longitude),
        icon: isSelected
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
            : BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: info.title));
  }

  List<Marker> generateMarkers(List<ShopInfo> shops) {
    List<Marker> markers = List.empty();

    for (var shop in shops) {
      markers.add(generateMarker(shop));
    }

    return markers;
  }
}

class ShopGenerator {
  List<ShopInfo> offices = [
    ShopInfo('MainOffice', '總店', 25.0384847, 121.5297953),
    ShopInfo('XinyiBranch', '信義分店', 25.0424777, 121.5623045),
    ShopInfo('FuxingBranch', '復興分店', 25.0520785, 121.5414341),
    ShopInfo('RenaiBranch', '仁愛分店', 25.0296587, 121.525987)
  ];
}

class ShopInfo {
  final String id;
  final String title;
  final double latitude;
  final double longitude;

  ShopInfo(this.id, this.title, this.latitude, this.longitude);
}
