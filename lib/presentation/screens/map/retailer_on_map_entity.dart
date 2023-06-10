import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InternetSpeedOnMapEntity with ClusterItem {
  InternetSpeedOnMapEntity({
    this.ip,
    this.typeOfConnection,
    this.typeOfMobile,
    this.nameOfMobile,
    this.downloadSpeed,
    this.latitude,
    this.longitude,
    this.qualityOfYoutube,
    this.uploadSpeed,
    this.isSelected=false,
    this.rate,
  });

  final String? ip;
  final String? typeOfConnection;
  final String? typeOfMobile;
  final String? nameOfMobile;
  final double? qualityOfYoutube;
  final double? uploadSpeed;
  final double? downloadSpeed;
  final double? latitude;
  final double? longitude;
  final int? rate;
  bool? isSelected;

  factory InternetSpeedOnMapEntity.empty() {
    return InternetSpeedOnMapEntity(
      ip: '',
      typeOfConnection: '',
      typeOfMobile: '',
      nameOfMobile: '',
      latitude: 0,
      longitude: 0,
      downloadSpeed: 0,
      qualityOfYoutube: 0,
      uploadSpeed: 0,
      rate: 0,
    );
  }

  InternetSpeedOnMapEntity copyWith({
    String? ip,
    String? typeOfConnection,
    String? typeOfMobile,
    String? nameOfMobile,
    double? qualityOfYoutube,
    double? uploadSpeed,
    double? downloadSpeed,
    double? latitude,
    double? longitude,
    int? rate,
  }) {
    return InternetSpeedOnMapEntity(
      ip: ip ?? this.ip,
      typeOfConnection: typeOfConnection ?? this.typeOfConnection,
      typeOfMobile: typeOfMobile ?? this.typeOfMobile,
      nameOfMobile: nameOfMobile ?? this.nameOfMobile,
      downloadSpeed: downloadSpeed ?? this.downloadSpeed,
      uploadSpeed: uploadSpeed ?? this.uploadSpeed,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      qualityOfYoutube: qualityOfYoutube ?? this.qualityOfYoutube,
      rate: rate ?? this.rate,
    );
  }

  @override
  LatLng get location => LatLng(latitude!, longitude!);
}
