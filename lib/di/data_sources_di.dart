import 'package:cloud_firestore/cloud_firestore.dart';

import 'di.dart';

initializeDataSources() {
  di.registerLazySingleton(() => FirebaseFirestore.instance);
}
