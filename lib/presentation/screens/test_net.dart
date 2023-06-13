import 'dart:io';

import 'package:carrier_info/carrier_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:internet_speed_test/presentation/screens/provider/test_net_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../components/progressBar.dart';
import '../components/speedLabels.dart';
import '../constants/palette.dart';
import '../routes/app_routes.dart';

class TestNet extends StatefulWidget {
  const TestNet({Key? key}) : super(key: key);

  @override
  State<TestNet> createState() => _TestNetState();
}

class _TestNetState extends State<TestNet> {
  final internetSpeedTest = FlutterInternetSpeedTest()..enableLog();

  final ProgressBar progressBar = ProgressBar();

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  var deviceData = <String, dynamic>{};


  IosCarrierData? _iosInfo;
  IosCarrierData? get iosInfo => _iosInfo;
  set iosInfo(IosCarrierData? iosInfo) {
    setState(() => _iosInfo = iosInfo);
  }

  AndroidCarrierData? _androidInfo;
  AndroidCarrierData? get androidInfo => _androidInfo;
  set androidInfo(AndroidCarrierData? carrierInfo) {
    setState(() => _androidInfo = carrierInfo);
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<TestNetProvider>().reset();
      context.read<TestNetProvider>().getMyLocation();

      initPlatformState();

      try{
        if (Platform.isAndroid) {

          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo,context);
        } else if (Platform.isIOS) {
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo,context);
        }

      } on PlatformException {
        deviceData = <String, dynamic>{
          'Error:': 'Failed to get platform version.'
        };
      }


    });
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Ask for permissions before requesting data
    await [
      Permission.locationWhenInUse,
      Permission.phone,
      Permission.sms,
    ].request();




    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      if (Platform.isAndroid) androidInfo = await CarrierInfo.getAndroidInfo();
      if (Platform.isIOS) iosInfo = await CarrierInfo.getIosInfo();
      if (Platform.isAndroid && androidInfo != null && androidInfo!.telephonyInfo.isNotEmpty) context.read<TestNetProvider>().setTelephonyInfoDisplayName(newValue: androidInfo!.telephonyInfo[0].displayName);
      if (Platform.isIOS && iosInfo != null)  context.read<TestNetProvider>().setTelephonyInfoDisplayName(newValue: iosInfo!.carrierData[0].carrierName);

    } catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build, BuildContext context) {
    context.read<TestNetProvider>().setMobileDataFun(typeOfMobile: "Android",nameOfMobile: "${build.brand} - ${build.device}");
    print('ssss ${build.device}');
    print('ssss ${build.brand}');
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
      ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data, BuildContext context) {
    context.read<TestNetProvider>().setMobileDataFun(typeOfMobile: "Ios",nameOfMobile:"${data.model} - ${data.name}");
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: bgCol,
      appBar: AppBar(
        title: const Text('Spider Net'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<TestNetProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: progressBar.showBar(provider.state.displayPer),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      showLabel('Download', provider.state.downloadRate,
                          provider.state.unitText),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      showLabel('Upload', provider.state.uploadRate,
                          provider.state.unitText),
                    ],
                  ),
                  SfRadialGauge(
                      title: const GaugeTitle(
                          text: ' ',
                          textStyle: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0,
                            maximum: 150,
                            axisLabelStyle: GaugeTextStyle(
                              color: txtCol,
                            ),
                            ranges: <GaugeRange>[
                              GaugeRange(
                                  startValue: 0,
                                  endValue: 50,
                                  color: gaugeRange1,
                                  startWidth: 10,
                                  endWidth: 10),
                              GaugeRange(
                                  startValue: 50,
                                  endValue: 100,
                                  color: gaugeRange2,
                                  startWidth: 10,
                                  endWidth: 10),
                              GaugeRange(
                                  startValue: 100,
                                  endValue: 150,
                                  color: gaugeRange1,
                                  startWidth: 10,
                                  endWidth: 10)
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(
                                value: provider.state.displayRate,
                                enableAnimation: true,
                                needleColor: needleCol,
                              )
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget: Text(
                                    '${provider.state.displayRate.toStringAsFixed(2)} ${provider.state.unitText}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: txtCol,
                                    ),
                                  ),
                                  angle: 90,
                                  positionFactor: 0.5)
                            ])
                      ]),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16.0, left: 8, right: 8),
                    child: Text(
                        provider.state.isServerSelectionInProgress
                            ? 'Selecting Server...'
                            : 'IP: ${provider.state.ip ?? '--'} | ASP: ${provider.state.asn ?? '--'} ',
                        style: const TextStyle(color: Colors.blueAccent)),
                  ),
                  SizedBox(height: 8,),
                  provider.state.typeOfConnection !=null ? Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                        "Type of Connection :  ${provider.state.typeOfConnection ?? ""}",
                        style: TextStyle(color: Colors.blueAccent)),
                  ):const SizedBox(),
                  SizedBox(height: 8,),

                  provider.state.qualityOfYoutube != null?
                  Text(
                      "Quality of Youtube :  ${provider.state.qualityOfYoutube!.round()}P",
                      style: const TextStyle(color: Colors.blueAccent)):SizedBox(),
                  const SizedBox(height: 8,),
                  if (!provider.state.testInProgress) ...{
                    ElevatedButton(
                      child: const Text('Start Testing'),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueAccent),
                          fixedSize: MaterialStateProperty.all<Size>(Size(40.w, 6.h)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                      onPressed: () async {
                        provider.reset();
                        await internetSpeedTest.startTesting(onStarted: () {
                          provider.changeTestInProgress(true);
                        }, onCompleted:
                            (TestResult download, TestResult upload) async {
                          if (kDebugMode) {
                            print(
                                'the transfer rate ${download.transferRate}, ${upload.transferRate}');
                          }

                          provider.onCompletedFun(download, upload,context);
                          provider.changeTestInProgress(false);



                        }, onProgress: (double percent, TestResult data) {
                          if (kDebugMode) {
                            print(
                                'the transfer rate $data.transferRate, the percent $percent');
                          }
                          provider.onProgressFun(percent, data);
                        }, onError:
                            (String errorMessage, String speedTestError) {
                          if (kDebugMode) {
                            print(
                                'the errorMessage $errorMessage, the speedTestError $speedTestError');
                          }
                          provider.reset();
                        }, onDefaultServerSelectionInProgress: () {
                          provider.changeIsServerSelectionInProgress(true);
                        }, onDefaultServerSelectionDone: (Client? client) {
                          provider.changeIsServerSelectionInProgress(false);
                          provider.onDefaultServerSelectionDoneFun(client);
                        }, onDownloadComplete: (TestResult data) {
                          provider.onDownloadCompleteFun(data);
                          provider.setQualityOfYoutubeFun(downloadRate: provider.state.downloadRate);
                        }, onUploadComplete: (TestResult data) {
                          provider.onUploadCompleteFun(data);
                        }, onCancel: () {
                          provider.reset();
                        });

                        provider.initalConnectivity();
                        provider.getMyLocation();


                      },
                    )
                  } else ...{
                    const CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(
                        onPressed: () => internetSpeedTest.cancelTest(),
                        icon: const Icon(Icons.cancel_rounded),
                        label: const Text('Cancel'),
                      ),
                    )
                  },
                  SizedBox(
                    height: 3.h,
                  ),
                  ElevatedButton(
                    child: const Text('Go to Map'),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueAccent),
                        fixedSize: MaterialStateProperty.all<Size>(Size(40.w, 6.h)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ))),
                    onPressed: ()  {
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (context) =>  GoogleMapPage()));

                      Navigator.of(context).pushNamed(AppRoutes.googleMapPage);
                    },
                  ),


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
