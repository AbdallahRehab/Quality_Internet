import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../di/di.dart';
import '../widgets/success_dialog.dart';
import 'test_net_state.dart';

class TestNetProvider extends ChangeNotifier {
  final state = TestNetState();

  TestNetProvider();

  init({required BuildContext context}) async {
    state.context = context;
  }

  void protectGauge(double rate) {
    // this function prevents the needle from exceeding the maximum limit of the gauge
    if (rate > 150) {
      state.displayRateTxt = rate.toStringAsFixed(2);
    } else {
      state.displayRate = rate;
      state.displayRateTxt = state.displayRate.toStringAsFixed(2);
    }
    notifyListeners();
  }

  void reset() {
    state.testInProgress = false;
    state.downloadRate = 0;
    state.uploadRate = 0;
    state.downloadProgress = '0';
    state.displayPer = 0;
    state.uploadProgress = '0';
    state.unitText = 'Mbps';
    state.downloadCompletionTime = 0;
    state.uploadCompletionTime = 0;

    state.ip = null;
    state.asn = null;
    state.isp = null;
    state.location = null;

    state.typeOfConnection = null;

    notifyListeners();
  }

  void changeTestInProgress(value) {
    state.testInProgress = value;
    notifyListeners();
  }

  void changeIsServerSelectionInProgress(value) {
    state.isServerSelectionInProgress = value;
    notifyListeners();
  }

  void onCompletedFun(TestResult download, TestResult upload, BuildContext context) {
    state.downloadRate = download.transferRate;
    protectGauge(state.downloadRate);
    state.unitText = download.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
    state.downloadProgress = '100';
    state.displayPer = 100;
    state.downloadCompletionTime = download.durationInMillis;

    state.uploadRate = upload.transferRate;
    protectGauge(state.uploadRate);
    state.unitText = upload.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
    state.uploadProgress = '100';
    state.displayPer = 100;
    state.uploadCompletionTime = upload.durationInMillis;

    notifyListeners();

    // setDataOnFirebaseFun();
    showDialog(
      context: context,
      builder: (_) => const SuccessDialog(),
    );
  }

  void onProgressFun(double percent, TestResult data) {
    state.unitText = data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
    if (data.type == TestType.download) {
      state.downloadRate = data.transferRate;
      protectGauge(state.downloadRate);
      state.downloadProgress = percent.toStringAsFixed(2);
      state.displayPer = percent;
    } else {
      state.uploadRate = data.transferRate;
      protectGauge(state.uploadRate);
      state.uploadProgress = percent.toStringAsFixed(2);
      state.displayPer = percent;
    }

    notifyListeners();
  }

  void onDefaultServerSelectionDoneFun(Client? client) {
    state.ip = client?.ip;
    state.asn = client?.asn;
    state.isp = client?.isp;
    state.locationT = "${client?.location?.city} - ${client?.location?.country}";

    notifyListeners();
  }

  void onDownloadCompleteFun(TestResult data) {
    state.downloadRate = data.transferRate;
    protectGauge(state.downloadRate);
    state.unitText = data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
    state.downloadCompletionTime = data.durationInMillis;
    notifyListeners();
  }

  void onUploadCompleteFun(TestResult data) {
    state.uploadRate = data.transferRate;
    protectGauge(state.uploadRate);
    state.unitText = data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
    state.uploadCompletionTime = data.durationInMillis;
    notifyListeners();
  }

  void initalConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      if(state.telephonyInfoDisplayName !=null ){
        state.typeOfConnection = "Mobile Data - ${state.telephonyInfoDisplayName}";

      }else{
        state.typeOfConnection = "Mobile Data";

      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      state.typeOfConnection = "Wifi";
    }
  }

  void setTelephonyInfoDisplayName({required String newValue}){
    state.telephonyInfoDisplayName=newValue;
    notifyListeners();
  }

  void setMobileDataFun({required String typeOfMobile, required String nameOfMobile}) {
    state.typeOfMobile = typeOfMobile;
    state.nameOfMobile = nameOfMobile;
    print('WWWWW $typeOfMobile $nameOfMobile');
    notifyListeners();
  }

  void setRateFun({required int newvalue, }) {
    state.rate = newvalue;
    notifyListeners();
  }

  double setQualityOfYoutubeFun({required double downloadRate}) {

    double calculateQuality=0;
    //provider.state.downloadRate < 1?240:provider.state.downloadRate < 5?360
    if(downloadRate < 1){
      calculateQuality=240;
    }else if(downloadRate < 5){
      calculateQuality=360;
    }else if(downloadRate < 10){
      calculateQuality=480;
    }else if(downloadRate < 20){
      calculateQuality=720;
    }else if(downloadRate >= 20){
      calculateQuality=1080;
    }

    state.qualityOfYoutube=calculateQuality;
    notifyListeners();
    return calculateQuality;
  }



  void setDataOnFirebaseFun(BuildContext context) {
    final collectionRef = di<FirebaseFirestore>().collection('db');
    final newData = {
      'download_speed': state.downloadRate,
      'upload_speed': state.uploadRate,
      'latitude': state.position!.latitude,
      'longitude': state.position!.longitude,
      'quality_of_youtube': state.qualityOfYoutube,
      'name_of_mobile': state.nameOfMobile,
      'type_of_mobile': state.typeOfMobile,
      'type_of_connection': state.typeOfConnection,
      'ip': state.ip,
      'rate': state.rate,
    };

    collectionRef.add(newData);
    print('Add Row in firebase');

    Navigator.pop(context);
  }




  getMyLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    // await state.location!.requestService();
    // serviceEnabled = await state.location!.serviceEnabled();
    // if (!serviceEnabled) {
    //   serviceEnabled = await state.location!.requestService();
    //   if (!serviceEnabled) {
    //     return;
    //   }
    // }
    //
    // permissionGranted = await state.location!.hasPermission();
    // if (permissionGranted == PermissionStatus.denied) {
    //   permissionGranted = await state.location!.requestPermission();
    //   if (permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }
    if (await Geolocator.checkPermission() == LocationPermission.denied) {
      await Geolocator.requestPermission();
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


    print('WssWWWW ${state.position}');

    notifyListeners();
  }
}
