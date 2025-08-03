import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1Ijoid2FyZW5qc20yOSIsImEiOiJjbWR2M3dhaWExaG9oMmxxMjloanRvdnNzIn0.pbrGRm_F17q_kNJ9lU91YQ';

class MapScreen extends StatefulWidget {
  final String name;
  final String surname;
  final double latitude;
  final double longitude;

  const MapScreen({
    super.key,
    required this.name,
    required this.surname,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String locationInfo = "";

  @override
  void initState() {
    super.initState();
    _getLocationName();
  }

  Future<void> _getLocationName() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(widget.latitude, widget.longitude);
      final place = placemarks.first;
      setState(() {
        locationInfo =
            "${place.locality ?? ''}, ${place.country ?? ''}".trim();
      });
    } catch (e) {
      setState(() {
        locationInfo = "Ubicación no encontrada";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLng point = LatLng(widget.latitude, widget.longitude);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: point,
          initialZoom: 14,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: const {
              'accessToken': MAPBOX_ACCESS_TOKEN,
              'id': 'mapbox/streets-v12',
            },
            userAgentPackageName: 'com.example.geoapp',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: point,
                width: 40,
                height: 40,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Información"),
                        content: Text(
                          "Nombre: ${widget.name}\n"
                          "Apellido: ${widget.surname}\n"
                          "Ubicación: $locationInfo",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cerrar"),
                          )
                        ],
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
