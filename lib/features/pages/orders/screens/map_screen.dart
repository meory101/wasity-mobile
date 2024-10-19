import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: depend_on_referenced_packages
import 'package:permission_handler/permission_handler.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/button/main_button.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class MapScreen extends StatefulWidget {
  final String? lat;
  final String? long;
  const MapScreen({super.key, this.lat, this.long});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Position? cl;
  // ignore: prefer_typing_uninitialized_variables
  var lat;
  // ignore: prefer_typing_uninitialized_variables
  var long;
  CameraPosition? _kGooglePlex;
  late Set<Marker> mymarker;

  getLocation() async { 
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.denied) {
      await Geolocator.requestPermission();
    }
    if (status == PermissionStatus.granted) {
      await getLatLong();
    }
  }

  getLatLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => (value));
    if (widget.lat != null) {
      lat = double.parse(widget.lat!);
      long = double.parse(widget.long!);
    } else {
      lat = cl?.latitude;
      long = cl?.longitude;
    }
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 10.4746,
    );
    setState(() {
      mymarker = {
        Marker(markerId: const MarkerId("1"), position: LatLng(lat, long)),
        Marker(
            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names, avoid_print
            onDragEnd: ((LatLng) => {print(LatLng)}),
            markerId: const MarkerId("1"),
            position: LatLng(lat, long))
      };
    });
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  onDoneClicked() async {
    Navigator.of(context).pop({
      'lat': lat,
      'long': long,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _kGooglePlex != null
            ? Stack(
                children: [
                  GoogleMap(
                    // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                    onTap: (LatLng) {
                      setState(() {
                        mymarker.add(Marker(
                            markerId: const MarkerId("1"), position: LatLng));
                        lat = LatLng.latitude;
                        long = LatLng.longitude;
                      });
                    },
                    markers: mymarker,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex!,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: MainAppButton(
                        alignment: Alignment.center,
                        onTap: () {
                          onDoneClicked();
                        },
                        width: AppWidthManager.w70,
                        height: AppHeightManager.h6,
                        color: AppColorManager.blackShadow,
                        child: const AppTextWidget(
                          text: 'Done',
                          color: AppColorManager.white,
                        )),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: AppColorManager.red,
                ),
              ),
      ),
    );
  }
}
