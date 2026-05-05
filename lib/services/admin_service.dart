import '../core/api_client.dart';
import '../core/constants.dart';
import '../models/clase_grupal.dart';
import '../models/membresia.dart';
import '../models/usuario.dart';

class AdminService {
  static final AdminService _instance = AdminService._internal();

  factory AdminService() => _instance;

  AdminService._internal();

  final _api = ApiClient();

  Future<List<UsuarioModel>> obtenerClientes() async {
    final response = await _api.get(ADMIN_CLIENTES_ENDPOINT);
    return _parseUsers(response);
  }

  Future<List<UsuarioModel>> obtenerEntrenadores() async {
    final response = await _api.get(ADMIN_ENTRENADORES_ENDPOINT);
    return _parseUsers(response);
  }

  Future<List<UsuarioModel>> obtenerUsuarios() async {
    final response = await _api.get(ADMIN_USUARIOS_ENDPOINT);
    return _parseUsers(response);
  }

  Future<List<MembresiaModel>> obtenerMembresias() async {
    final response = await _api.get(ADMIN_MEMBRESIAS_ENDPOINT);
    if (response is List) {
      return response
          .whereType<Map>()
          .map((item) => MembresiaModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    throw ApiException(statusCode: -1, message: 'Respuesta inválida al listar membresías', details: response);
  }

  Future<UsuarioModel> crearUsuario({
    required String nombre,
    required String apellido,
    required String email,
    required String password,
    required String rol,
    String? telefono,
  }) async {
    final response = await _api.post(
      ADMIN_CREAR_USUARIO_ENDPOINT,
      body: {
        'nombre': nombre,
        'apellido': apellido,
        'email': email,
        'password': password,
        'rol': rol,
        'telefono': telefono,
      },
    );
    if (response is Map) {
      return UsuarioModel.fromJson(Map<String, dynamic>.from(response));
    }
    throw ApiException(statusCode: -1, message: 'Respuesta inválida al crear usuario', details: response);
  }

  Future<MembresiaModel> crearMembresia({required int clienteId, required String tipo}) async {
    final response = await _api.post(
      ADMIN_MEMBRESIAS_ENDPOINT,
      body: {'clienteId': clienteId, 'tipo': tipo},
    );
    if (response is Map) {
      return MembresiaModel.fromJson(Map<String, dynamic>.from(response));
    }
    throw ApiException(statusCode: -1, message: 'Respuesta inválida al crear membresía', details: response);
  }

  Future<dynamic> activarMembresia({required int membresiaId, required int monto, String? notas}) {
    return _api.post(
      '${ADMIN_MEMBRESIAS_ENDPOINT}/$membresiaId/activar',
      body: {'monto': monto, 'notas': notas},
    );
  }

  Future<ClaseGrupalModel> crearClaseGrupal({
    required int entrenadorId,
    required String nombre,
    required String fechaHora,
    required int cupoMaximo,
    String? descripcion,
  }) async {
    final response = await _api.post(
      ADMIN_CREAR_CLASE_ENDPOINT,
      body: {
        'entrenadorId': entrenadorId,
        'nombre': nombre,
        'fechaHora': fechaHora,
        'cupoMaximo': cupoMaximo,
        'descripcion': descripcion,
      },
    );
    if (response is Map) {
      return ClaseGrupalModel.fromJson(Map<String, dynamic>.from(response));
    }
    throw ApiException(statusCode: -1, message: 'Respuesta inválida al crear clase', details: response);
  }

  List<UsuarioModel> _parseUsers(dynamic response) {
    if (response is List) {
      return response
          .whereType<Map>()
          .map((item) => UsuarioModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    throw ApiException(statusCode: -1, message: 'Respuesta inválida al listar usuarios', details: response);
  }
}