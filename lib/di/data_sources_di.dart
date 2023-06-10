import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import '../data/network/network_helper.dart';
import '../data/network/network_helper_impl.dart';
import '../data/storage/storage_repo.dart';
import '../data/storage/storage_repo_impl.dart';
import 'di.dart';

initializeDataSources() {
  /// Storage
  di.registerLazySingleton<StorageRepo>(
    () => StorageRepoImpl(storage: const FlutterSecureStorage()),
  );

  /// Network Helper
  di.registerLazySingleton<NetworkHelper>(
    () => NetworkHelperImpl(storage: di()),
  );

  di.registerLazySingleton(() => FirebaseFirestore.instance);


}
