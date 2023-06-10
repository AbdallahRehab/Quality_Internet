import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internet_speed_test/presentation/screens/map/provider/map_net_provider.dart';
import 'package:internet_speed_test/presentation/screens/map/widgets/bottom_retailer_card.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../components/once_future_builder.dart';

class GoogleMapPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  GoogleMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MapNetProvider>(
      builder: (context, provider, child) {
        return ScaffoldMessenger(
          key: _globalKey,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body: OnceFutureBuilder(
              future: () async {},
              builder: (context, snapShot) {
                return Container(
                  color: Colors.white,
                  child: mainWidget(context),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget mainWidget(BuildContext context) {
    return OnceFutureBuilder(
      future: () async {
        await context.read<MapNetProvider>().initialize(context);
        // showAlert();
      },
      builder: (ctx, snapShot) {
        if (snapShot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    onMapCreated: (c) =>
                        context.read<MapNetProvider>().onMapCreated(c),
                    buildingsEnabled: false,
                    mapToolbarEnabled: false,
                    rotateGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: context.watch<MapNetProvider>().state.position!,
                      tilt: 60,
                      zoom: 8,
                    ),
                    onCameraMove: (position) {
                      // context
                      //     .read<MapNetProvider>()
                      //     .updatePosition(position: position.target);

                      context
                          .read<MapNetProvider>()
                          .state
                          .clusterManager!
                          .onCameraMove(position);
                      context
                          .read<MapNetProvider>()
                          .updateZoom(zoom: position.zoom);
                    },
                    onCameraIdle: () {
                      context.read<MapNetProvider>().onMapSearchFired();
                    },
                    markers: context.watch<MapNetProvider>().state.markers ?? <Marker>{},
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  ),
                ),
              ],
            ),

            // // Menu
            // PositionedDirectional(
            //   top: 50,
            //   start: 30,
            //   child: InkWell(
            //     onTap: () {
            //       _scaffoldKey.currentState!.openDrawer();
            //     },
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(8),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.shade400,
            //             offset: const Offset(0, 2),
            //             blurRadius: 4,
            //           ),
            //         ],
            //       ),
            //       padding: const EdgeInsets.all(10),
            //       child: const Icon(Icons.filter_list),
            //     ),
            //   ),
            // ),

            // Back
            PositionedDirectional(
              top: 50,
              end: 30,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(Icons.arrow_forward_rounded),
                ),
              ),
            ),

            if (context.read<MapNetProvider>().state.isLoading == true)
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(),
              ),

            // List Of Retailer
            (context.watch<MapNetProvider>().state.internetSpeedOnMapList == null ||
                    context
                            .watch<MapNetProvider>()
                            .state
                            .internetSpeedOnMapList!
                            .isEmpty &&
                        context.watch<MapNetProvider>().state.isLoading ==
                            false)
                ? Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getMyLocationWidget(),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "notRetailerNearToYou",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Positioned(
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getMyLocationWidget(),
                        const SizedBox(
                          height: 6,
                        ),
                        BottomRetailerCard(
                          list: context
                              .watch<MapNetProvider>()
                              .state
                              .internetSpeedOnMapList!,
                          carousalController: context
                              .read<MapNetProvider>()
                              .state
                              .carousalController!,
                          update: (index) {
                            context.read<MapNetProvider>().updateCurrentIndex(
                                  currentIndex: index,
                                );
                            context.read<MapNetProvider>().updateRetailersOnMap(
                                  currentIndex: index,
                                );
                          },
                          onCardTap: (retailer) {
                            // context
                            //     .read<MapNetProvider>()
                            //     .navigateToRetailerPage(
                            //       retailer: retailer,
                            //       context: context,
                            //     );
                          },
                          currentIndex: context
                              .read<MapNetProvider>()
                              .state
                              .currentIndex!,
                        ),
                      ],
                    ),
                  )
          ],
        );
      },
    );
  }

  getMyLocationWidget() {
    return Consumer<MapNetProvider>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: () async {
            bool serviceEnabled;
            PermissionStatus permissionGranted;
            Position locationData;

            permissionGranted =
                await provider.state.location!.requestPermission();

            serviceEnabled = await provider.state.location!.serviceEnabled();
            if (!serviceEnabled) {
              serviceEnabled = await provider.state.location!.requestService();
              if (!serviceEnabled) {
                return;
              }
            }

            permissionGranted = await provider.state.location!.hasPermission();
            if (permissionGranted == PermissionStatus.denied) {
              permissionGranted =
                  await provider.state.location!.requestPermission();
              if (permissionGranted != PermissionStatus.granted) {
                return;
              }
            }
            // _locationData = await state.location!.getLocation();
            locationData = await Geolocator.getCurrentPosition();
            provider.state.position =
                LatLng(locationData.latitude, locationData.longitude);
            print('WWWWW ${provider.state.position}');
            await provider.state.mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: provider.state.position ??
                      const LatLng(24.730904, 46.670081),
                  zoom: 16.0,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                )
              ],
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsetsDirectional.only(start: 30),
            child: const Icon(Icons.my_location_outlined),
          ),
        );
      },
    );
  }

  void showAlert() {
    var snackBar = SnackBar(
      content: Text("map_alert_msg"),
      backgroundColor: Colors.green,
    );
    _globalKey.currentState!.showSnackBar(snackBar);
  }
}

class Place with ClusterItem {
  String? name;
  bool? isClosed;
  LatLng? latLng;

  Place({this.name, this.latLng, this.isClosed = false});

  @override
  String toString() {
    return 'Place $name (closed : $isClosed)';
  }

  @override
  LatLng get location => latLng!;
}
