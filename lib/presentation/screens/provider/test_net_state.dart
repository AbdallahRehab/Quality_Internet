
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class TestNetState {
  late BuildContext context;



  bool testInProgress = false;
  double downloadRate = 0;
  double uploadRate = 0;
  String downloadProgress = '0';
  String uploadProgress = '0';
  int downloadCompletionTime = 0;
  int uploadCompletionTime = 0;
  bool isServerSelectionInProgress = false;

  double displayPer = 0;
  double displayRate = 0;
  String displayRateTxt = '0.0';

  String? ip;
  String? asn;
  String? isp;
  String? locationT;

  String unitText = 'Mbps';

  String? typeOfConnection;
  String? telephonyInfoDisplayName;


  String? typeOfMobile;
  String? nameOfMobile;
  double? qualityOfYoutube;

  Location? location = Location();
  LatLng? position = const LatLng(30.0444, 31.2357);//30.0444, 31.2357

  int rate=0;




}
