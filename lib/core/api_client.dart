import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';
import 'secure_storage.dart';

/// Cliente HTTP centralizado para comunicarse con el backend
/// 
/// Maneja:
/// - Rutas base (BACKEND_URL)
/// - Headers comunes (Content-Type, Authorization)
/// - Token JWT en requests autenticados
/// - Errores y timeouts
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal();

  /// Headers comunes para todas las peticiones
  Map<String, String> _getHeaders({bool requireAuth = false}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    return headers;
  }

  /// Headers con autenticación (agrega Bearer token)
  Future<Map<String, String>> _getAuthHeaders() async {
    final headers = _getHeaders(requireAuth: true);
    final token = await SecureStorage.read('access_token');

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  /// GET - Obtener datos
  /// Retorna el body parseado como Map o List
  Future<dynamic> get(
    String endpoint, {
    bool requireAuth = true,
  }) async {
    try {
      final headers = requireAuth
          ? await _getAuthHeaders()
          : _getHeaders();

      final response = await http.get(
        Uri.parse('$BACKEND_URL$endpoint'),
        headers: headers,
      ).timeout(HTTP_TIMEOUT);

      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  /// POST - Crear datos
  /// body: Map que se convertirá a JSON
  /// Retorna el body parseado como Map o List
  Future<dynamic> post(
    String endpoint, {
    required dynamic body,
    bool requireAuth = true,
  }) async {
    try {
      final headers = requireAuth
          ? await _getAuthHeaders()
          : _getHeaders();

      final response = await http.post(
        Uri.parse('$BACKEND_URL$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      ).timeout(HTTP_TIMEOUT);

      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  /// PUT - Actualizar datos
  /// body: Map que se convertirá a JSON
  /// Retorna el body parseado como Map o List
  Future<dynamic> put(
    String endpoint, {
    required dynamic body,
    bool requireAuth = true,
  }) async {
    try {
      final headers = requireAuth
          ? await _getAuthHeaders()
          : _getHeaders();

      final response = await http.put(
        Uri.parse('$BACKEND_URL$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      ).timeout(HTTP_TIMEOUT);

      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  /// DELETE - Eliminar datos
  /// Retorna el body parseado como Map o List
  Future<dynamic> delete(
    String endpoint, {
    bool requireAuth = true,
  }) async {
    try {
      final headers = requireAuth
          ? await _getAuthHeaders()
          : _getHeaders();

      final response = await http.delete(
        Uri.parse('$BACKEND_URL$endpoint'),
        headers: headers,
      ).timeout(HTTP_TIMEOUT);

      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  /// Procesar respuesta HTTP
  /// - 200-299: Éxito, parsea JSON y retorna
  /// - 400-499: Error del cliente (credenciales, validación)
  /// - 500-599: Error del servidor
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    // Intentar parsear el body
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      body = response.body;
    }

    // 200-299: Success
    if (statusCode >= 200 && statusCode < 300) {
      return body;
    }

    // 401: Unauthorized (token expirado o inválido)
    if (statusCode == 401) {
      SecureStorage.deleteAll();
      throw ApiException(
        statusCode: statusCode,
        message: 'Tu sesión expiró. Por favor, inicia sesión de nuevo.',
        details: body is Map ? body['detail'] : null,
      );
    }

    // 4xx: Client error
    if (statusCode >= 400 && statusCode < 500) {
      throw ApiException(
        statusCode: statusCode,
        message: body is Map && body.containsKey('detail')
            ? body['detail']
            : 'Error en la solicitud: $statusCode',
        details: body,
      );
    }

    // 5xx: Server error
    if (statusCode >= 500) {
      throw ApiException(
        statusCode: statusCode,
        message: 'Error del servidor. Intenta más tarde.',
        details: body,
      );
    }

    // Otros códigos
    throw ApiException(
      statusCode: statusCode,
      message: 'Error inesperado: $statusCode',
      details: body,
    );
  }

  /// Manejar excepciones
  void _handleError(dynamic error) {
    if (error is ApiException) {
      rethrow;
    }

    if (error is http.ClientException || error.toString().contains('timeout')) {
      throw ApiException(
        statusCode: -1,
        message: 'No hay conexión con el servidor. Verifica tu internet.',
        details: error.toString(),
      );
    }

    throw ApiException(
      statusCode: -1,
      message: 'Error inesperado',
      details: error.toString(),
    );
  }
}

/// Excepción personalizada para errores de API
class ApiException implements Exception {
  final int statusCode;
  final String message;
  final dynamic details;

  ApiException({
    required this.statusCode,
    required this.message,
    this.details,
  });

  @override
  String toString() => message;
}
