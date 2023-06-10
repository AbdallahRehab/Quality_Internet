import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as map_toolkit;

import '../../../../di/di.dart';
import '../local_package/custom_marker.dart';
import '../retailer_on_map_entity.dart';
import 'map_net_state.dart';

class MapNetProvider extends ChangeNotifier {
  final state = MapNetState();

  MapNetProvider();

  init({required BuildContext context}) async {
    state.context = context;
  }

  void initializeCluster() {
    print('state.retailersOnMapList ${state.internetSpeedOnMapList}');
    state.clusterManager = ClusterManager<InternetSpeedOnMapEntity>(
      state.internetSpeedOnMapList!,
      (v) {
        print('state.retailersOnMapList v ${v}');
        initializeMarkers(v);
      },
      // levels: [1, 4, 7, 9, 11, 13, 15, 17, 19],
      markerBuilder: markerBuilder,
    );

    notifyListeners();
  }

  void initializeMarkers(Set<Marker> markers) {
    state.markers = markers.isEmpty ? Set.from({}) : markers;
    notifyListeners();
  }

  void handleCurrentIndexEvent(int? data) {
    state.currentIndex = data;
    notifyListeners();
  }

  void handleDistanceEvent(int? data) {
    state.distance = data;
    notifyListeners();
  }

  void handlePositionEvent(LatLng? data) {
    state.position = data;
    notifyListeners();
  }

  void handleZoomEvent(double? data) {
    state.currentZoom = data;
    notifyListeners();
  }

  void handleMapSearchFiredEvent(bool data) {
    state.isLoading = data;
    notifyListeners();
  }

  void handleRetailersSearchMapEvent(
      List<InternetSpeedOnMapEntity>? retailersOnMapList, bool isLoading) {
    state.internetSpeedOnMapList = retailersOnMapList;
    state.isLoading = isLoading;
    notifyListeners();
    state.clusterManager!.setItems(state.internetSpeedOnMapList!);
    state.clusterManager!.updateMap();
  }

  Future onMapSearchFired() async {
    // handleMapSearchFiredEvent(true);

    num distance = await calculateDistance(
      position: CameraPosition(target: state.position!),
      googleMapController: state.mapController,
    );

    updatedDistance(distance: distance.toInt());

    await searchMap(
      lat: state.position!.latitude,
      lng: state.position!.longitude,
    );
    notifyListeners();
    state.clusterManager!.setItems(state.internetSpeedOnMapList!);
    state.clusterManager!.updateMap();
  }

  void updatedDistance({int? distance}) {
    handleDistanceEvent(distance);
  }

  void updatePosition({LatLng? position}) {
    handlePositionEvent(position);
  }

  void updateZoom({double? zoom}) {
    handleZoomEvent(zoom);
  }

  Future<void> initialize(BuildContext context) async {
    state.context = context;
    state.categoryId = "";

    initializeCluster();

    try {
      await onMapSearchFired();
    } on Exception catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<Marker> Function(Cluster<InternetSpeedOnMapEntity>)
      get markerBuilder => (Cluster<InternetSpeedOnMapEntity> cluster) async {
            return Marker(
              markerId: MarkerId(cluster.getId()),
              consumeTapEvents: true,
              icon: await MapMarker.downloadResizePictureCircle(
                cluster.items.elementAt(0).typeOfConnection! == "Wifi"?"https://img.freepik.com/free-icon/wifi_318-1573.jpg":"https://static.thenounproject.com/png/2811966-200.png",
                borderColor: Colors.green,
                addBorder: true,
                size: 120,
              ),
              position: cluster.location,
              infoWindow: const InfoWindow(title: ""),
              onTap: () {
                try {
                  updateCurrentIndex(
                    currentIndex: state.internetSpeedOnMapList!.indexWhere(
                      (element) => element.ip == cluster.items.elementAt(0).ip,
                    ),
                  );
                } on Exception catch (e) {
                  debugPrint("Error: $e");
                }
                try {
                  state.carousalController!.animateToPage(
                    state.internetSpeedOnMapList!.indexWhere(
                      (element) => element.ip == cluster.items.elementAt(0).ip,
                    ),
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    curve: Curves.easeInOut,
                  );
                } on Exception catch (e) {
                  debugPrint("Error: $e");
                }
              },
            );
          };

  Future<void> onMapCreated(GoogleMapController controller) async {
    state.mapController = controller;
    state.clusterManager!.setMapId(controller.mapId);

    if (await Geolocator.checkPermission() == LocationPermission.whileInUse ||
        await Geolocator.checkPermission() == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      debugPrint("NMNMNM:${position.toJson()}");

      state.position = LatLng(position.latitude, position.longitude);
      debugPrint(
        'LLLLL ${LatLng(position.latitude, position.longitude).toString()}',
      );
    }
    debugPrint('LLLLLSS ${state.position.toString()}');

    await state.mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: state.position ?? const LatLng(24.730904, 46.670081),
          zoom: (await Geolocator.checkPermission() ==
                      LocationPermission.whileInUse ||
                  await Geolocator.checkPermission() ==
                      LocationPermission.always)
              ? 16.0
              : 6.0,
        ),
      ),
    );
  }

  updateCurrentIndex({int? currentIndex}) {
    handleCurrentIndexEvent(currentIndex);
  }

  updateRetailersOnMap({int? currentIndex}) {
    for (int i = 0; i < state.internetSpeedOnMapList!.length; i++) {
      if (i == currentIndex) {
        state.internetSpeedOnMapList![i].isSelected = true;
      } else {
        state.internetSpeedOnMapList![i].isSelected = false;
      }
    }
  }

  // Search on map
  Future searchMap({
    double? lat,
    double? lng,
  }) async {

    final querySnapshot = await di<FirebaseFirestore>().collection('db').get();

    final List<DocumentSnapshot> documents = querySnapshot.docs;
    // state.markers!.clear();
    state.internetSpeedOnMapList!.clear();
    for (var document in documents) {
      final data = document.data() as Map<String, dynamic>;
      // Do something with the data
      print('EEE ${data.toString()}');

      state.internetSpeedOnMapList!.add(InternetSpeedOnMapEntity(
        ip: data["ip"],
        nameOfMobile: data["name_of_mobile"],
        typeOfMobile: data["type_of_mobile"],
        downloadSpeed: data["download_speed"],
        qualityOfYoutube: data["quality_of_youtube"],
        typeOfConnection: data["type_of_connection"],
        uploadSpeed: data["upload_speed"],
        latitude: data["latitude"],
        longitude: data["longitude"],
        rate: data["rate"],
        isSelected: false,
      ));
    }
    print('get data from firebase');

    // state.markers!.clear();
    // state.internetSpeedOnMapList!.clear();
    // state.internetSpeedOnMapList = [
    //   InternetSpeedOnMapEntity(
    //     ip: "1",
    //     typeOfConnection: "tessst",
    //     typeOfMobile:
    //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgWy3DLSoDNZxaoOiVo3G9I7-fXtRAztlpB8YtYejl&s",
    //     nameOfMobile:
    //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgWy3DLSoDNZxaoOiVo3G9I7-fXtRAztlpB8YtYejl&s",
    //     isSelected: false,
    //     latitude: 30.0444,
    //     longitude: 31.2357,
    //     downloadSpeed: 10.0,
    //     uploadSpeed: 0,
    //   ),
    //   InternetSpeedOnMapEntity(
    //     ip: "2",
    //     typeOfConnection: "tessst2",
    //     typeOfMobile:
    //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgWy3DLSoDNZxaoOiVo3G9I7-fXtRAztlpB8YtYejl&s",
    //     nameOfMobile:
    //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgWy3DLSoDNZxaoOiVo3G9I7-fXtRAztlpB8YtYejl&s",
    //     isSelected: false,
    //     latitude: 30.8054246,
    //     longitude: 31.834231,
    //     downloadSpeed: 10.0,
    //     uploadSpeed: 0,
    //   ),
    //   InternetSpeedOnMapEntity(
    //     ip: "3",
    //     typeOfConnection: "tessst3",
    //     typeOfMobile:
    //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgWy3DLSoDNZxaoOiVo3G9I7-fXtRAztlpB8YtYejl&s",
    //     nameOfMobile:
    //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgWy3DLSoDNZxaoOiVo3G9I7-fXtRAztlpB8YtYejl&s",
    //     isSelected: false,
    //     latitude: 30.8054246,
    //     longitude: 30.834231,
    //     downloadSpeed: 10.0,
    //     uploadSpeed: 0,
    //   ),
    // ];
    if (state.internetSpeedOnMapList != null &&
        state.internetSpeedOnMapList!.isNotEmpty) {
      state.internetSpeedOnMapList![0].isSelected = true;
    }
    handleRetailersSearchMapEvent(state.internetSpeedOnMapList, false);

    notifyListeners();
  }

  getMyLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    await state.location!.requestService();
    serviceEnabled = await state.location!.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await state.location!.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await state.location!.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await state.location!.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    if (await Geolocator.checkPermission() == LocationPermission.whileInUse ||
        await Geolocator.checkPermission() == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      debugPrint("NMNMNM:${position.toJson()}");

      state.position = LatLng(position.latitude, position.longitude);
      debugPrint(
        'LLLLL ${LatLng(position.latitude, position.longitude).toString()}',
      );
    }

    print('WWWWW ${state.position}');

    notifyListeners();
  }

  Future<num> calculateDistance({
    CameraPosition? position,
    GoogleMapController? googleMapController,
  }) async {
    var center = position!.target;
    // var bounds = await googleMapController!.getVisibleRegion();
    var bounds = googleMapController == null
        ? LatLngBounds(northeast: center, southwest: center)
        : await googleMapController.getVisibleRegion();
    var ne = bounds.northeast;
    var lat = ne.latitude;
    var lng = ne.longitude;
    state.latCenter = double.parse(center.latitude.toStringAsFixed(7));
    state.lngCenter = double.parse(center.longitude.toStringAsFixed(7));
    map_toolkit.LatLng fromLatLng = map_toolkit.LatLng(lat, lng);
    map_toolkit.LatLng toLatLng =
        map_toolkit.LatLng(state.latCenter!, state.lngCenter!);

    return map_toolkit.SphericalUtil.computeDistanceBetween(
      fromLatLng,
      toLatLng,
    );
  }
}
