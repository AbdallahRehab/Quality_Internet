
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_speed_test/data/storage/storage_repo.dart';


class StorageRepoImpl implements StorageRepo {
  StorageRepoImpl({required this.storage});

  final FlutterSecureStorage storage;
  @override
  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  @override
  Future<String?> read(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  @override
  Future<bool> isContains(String key) async {
    return await storage.containsKey(key: key);
  }

}
