import '../core/api_client.dart';
import '../core/constants.dart';
import '../core/secure_storage.dart';

/// Servicio de autenticación
/// 
/// Maneja:
/// - Login (email, password)
/// - Logout (limpia sesión)
/// - Recuperar contraseña
/// - Almacenamiento de token JWT
class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  final _api = ApiClient();

  /// Iniciar sesión con email y contraseña
  /// 
  /// Retorna: {
  ///   'accessToken': string,
  ///   'tokenType': string,
  ///   'rol': string ('Cliente' | 'Entrenador' | 'Administrador'),
  ///   'usuarioId': int,
  ///   'nombre': string
  /// }
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _api.post(
        LOGIN_ENDPOINT,
        body: {
          'email': email,
          'password': password,
        },
        requireAuth: false,
      );

      // Guardar token y datos del usuario de forma segura
      if (response is Map) {
        final token = response['accessToken'];
        final usuarioId = response['usuarioId'];
        final rol = response['rol'];
        final nombre = response['nombre'];

        await SecureStorage.write(TOKEN_KEY, token);
        await SecureStorage.write(USUARIO_ID_KEY, usuarioId.toString());
        await SecureStorage.write(ROL_KEY, rol);
        await SecureStorage.write(NOMBRE_KEY, nombre);
        await SecureStorage.write(EMAIL_KEY, email);

        return response;
      }

      throw ApiException(
        statusCode: -1,
        message: 'Respuesta inválida del servidor',
        details: response,
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        statusCode: -1,
        message: 'Error al iniciar sesión: $e',
      );
    }
  }

  /// Cerrar sesión y limpiar almacenamiento local
  Future<void> logout() async {
    try {
      // Notificar al backend (opcional, es buena práctica)
      await _api.post(LOGOUT_ENDPOINT, body: {});

      // Limpiar almacenamiento local
      await SecureStorage.deleteAll();
    } catch (e) {
      // Aunque falle la petición al backend, limpiamos localmente
      await SecureStorage.deleteAll();
      rethrow;
    }
  }

  /// Solicitar recuperación de contraseña
  Future<void> recuperarPassword({required String email}) async {
    try {
      await _api.post(
        RECUPERAR_PASSWORD_ENDPOINT,
        body: {'email': email},
        requireAuth: false,
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        statusCode: -1,
        message: 'Error al solicitar recuperación: $e',
      );
    }
  }

  /// Resetear contraseña con token del email
  Future<void> resetearPassword({
    required String token,
    required String nuevaPassword,
  }) async {
    try {
      await _api.post(
        RESETEAR_PASSWORD_ENDPOINT,
        body: {
          'token': token,
          'nuevaPassword': nuevaPassword,
        },
        requireAuth: false,
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        statusCode: -1,
        message: 'Error al resetear contraseña: $e',
      );
    }
  }

  /// Verificar si hay sesión activa
  Future<bool> isAuthenticated() async {
    final token = await SecureStorage.read(TOKEN_KEY);
    return token != null && token.isNotEmpty;
  }

  /// Obtener token actual
  Future<String?> getToken() async {
    return await SecureStorage.read(TOKEN_KEY);
  }

  /// Obtener datos del usuario actual
  Future<Map<String, String?>> getUserData() async {
    return {
      'usuarioId': await SecureStorage.read(USUARIO_ID_KEY),
      'rol': await SecureStorage.read(ROL_KEY),
      'nombre': await SecureStorage.read(NOMBRE_KEY),
      'email': await SecureStorage.read(EMAIL_KEY),
    };
  }
}
