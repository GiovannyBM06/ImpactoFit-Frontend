import '../core/api_client.dart';
import '../core/constants.dart';
import '../models/rutina.dart';
import '../models/usuario.dart';

class EntrenadorService {
  static final EntrenadorService _instance = EntrenadorService._internal();

  factory EntrenadorService() => _instance;

  EntrenadorService._internal();

  final _api = ApiClient();

  Future<List<UsuarioModel>> obtenerClientes() async {
    final response = await _api.get(ENTRENADOR_CLIENTES_ENDPOINT);
    if (response is List) {
      return response
          .whereType<Map>()
          .map((item) => UsuarioModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    throw ApiException(statusCode: -1, message: 'Respuesta inválida al listar clientes', details: response);
  }

  Future<RutinaModel> obtenerRutinaDeCliente(int clienteId) async {
    final response = await _api.get(ENTRENADOR_RUTINA_ENDPOINT.replaceAll('{clienteId}', clienteId.toString()));
    if (response is Map) {
      return RutinaModel.fromJson(Map<String, dynamic>.from(response));
    }
    throw ApiException(statusCode: -1, message: 'Respuesta inválida al obtener rutina', details: response);
  }

  Future<List<Map<String, dynamic>>> obtenerEjerciciosCatalogo() async {
    final response = await _api.get(ENTRENADOR_EJERCICIOS_ENDPOINT);
    if (response is List) {
      return response
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    throw ApiException(statusCode: -1, message: 'Respuesta inválida al listar ejercicios', details: response);
  }

  Future<dynamic> crearEjercicio({required String nombre, String? descripcion}) {
    return _api.post(
      ENTRENADOR_CREAR_EJERCICIO_ENDPOINT,
      body: {'nombre': nombre, 'descripcion': descripcion},
    );
  }

  Future<dynamic> actualizarEjercicio({required int ejercicioId, String? nombre, String? descripcion}) {
    return _api.put(
      ENTRENADOR_EDITAR_EJERCICIO_ENDPOINT.replaceAll('{ejercicioId}', ejercicioId.toString()),
      body: {'nombre': nombre, 'descripcion': descripcion},
    );
  }

  Future<dynamic> eliminarEjercicio(int ejercicioId) {
    return _api.delete(
      ENTRENADOR_ELIMINAR_EJERCICIO_ENDPOINT.replaceAll('{ejercicioId}', ejercicioId.toString()),
    );
  }
}