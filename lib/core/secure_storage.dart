import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Gestor de almacenamiento seguro para tokens y datos sensibles
/// 
/// Usa flutter_secure_storage que encripta los datos en el dispositivo
class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_this_device_this_device_only,
    ),
  );

  /// Guardar un valor encriptado
  static Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Leer un valor encriptado
  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Eliminar un valor
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Limpiar todo el almacenamiento (logout)
  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Verificar si existe una clave
  static Future<bool> containsKey(String key) async {
    final value = await _storage.read(key: key);
    return value != null;
  }
}
