import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stylish/elements.dart';
import 'package:stylish/shopInfo.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(25.0384847, 121.5297953);
  final List<ShopInfo> _shops = ShopGenerator().offices;

  ShopInfo? selectedShop;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: MainAppBar(appBar: AppBar(), theme: theme),
      body: Column(
        children: [
          Container(
            color: theme.colorScheme.secondaryContainer,
            padding: const EdgeInsets.all(5.0),
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        selectedShop = _shops[index];
                        mapController.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target: LatLng(_shops[index].latitude,
                                    _shops[index].longitude),
                                zoom: 17)));
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _shops[index].id == (selectedShop?.id ?? 'null')
                                ? theme.highlightColor
                                : null),
                    icon: const Icon(Icons.home_work),
                    label: Text(_shops[index].title));
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20.0),
              itemCount: _shops.length,
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15.0,
              ),
              onMapCreated: _onMapCreated,
              markers: [
                for (var shop in _shops)
                  MarkerGenerator().generateMarker(shop,
                      isSelected: shop.id == (selectedShop?.id ?? 'null'))
              ].toSet(),
            ),
          )
        ],
      ),
    );
  }
}
