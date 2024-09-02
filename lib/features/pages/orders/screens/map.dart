import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';

class GMap extends StatefulWidget {
  const GMap({super.key});

  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:DecoratedContainer(color: AppColorManager.error,child: GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(22, 22))),) ,)
    
    
    
    
    ;
  }
}