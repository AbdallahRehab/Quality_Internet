
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import '../../../core/enums.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../retailer_on_map_entity.dart';

enum LoadingState {
  loaded,
  loading,
}



class MapNetState {
  late BuildContext context;
  ScreenStatus loading = ScreenStatus.init;



  GoogleMapController? mapController;
  CarouselController? carousalController = CarouselController();
  ClusterManager? clusterManager;

  Set<Marker>? markers;
  BitmapDescriptor? pinLocationIcon;
  List<InternetSpeedOnMapEntity>? internetSpeedOnMapList = [];

  Location? location = Location();
  bool? isLoading = true;
  String? searchValue = "";
  double? latCenter = 0.0;
  double? lngCenter = 0.0;
  LatLng? position = const LatLng(30.0444, 31.2357);//30.0444, 31.2357
  LatLng? userLocation;
  int? distance = 12000;
  String? categoryId = "";
  int? initialCount = 0;
  bool? isLocationFetched = false;
  double? currentZoom = 8;
  LoadingState? state = LoadingState.loading;
  int? currentIndex = 0;


}
