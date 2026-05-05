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
    final response = await _api.get(EJERCICIOS_CATALOGO_ENDPOINT);
    if (response is List) {
      return response
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    throw ApiException(statusCode: -1, message: 'Respuesta inválida al listar ejercicios', details: response);
  }

  Future<RutinaModel> crearRutina({required int clienteId, required String nombre, String? descripcion}) async {
    final response = await _api.post(
      ENTRENADOR_CREAR_RUTINA_ENDPOINT,
      body: {'clienteId': clienteId, 'nombre': nombre, 'descripcion': descripcion},
    );
    if (response is Map) {
      return RutinaModel.fromJson(Map<String, dynamic>.from(response));
    }
    throw ApiException(statusCode: -1, message: 'Respuesta invalida al crear rutina', details: response);
  }

  Future<Map<String, dynamic>> asignarEjercicioARutina({
    required int rutinaId,
    required int ejercicioId,
    required int orden,
    required int series,
    required String tipoMetrica,
    int? repeticiones,
    int? duracionSeg,
    int? pesoKg,
    int? descansoSeg,
  }) async {
    final response = await _api.post(
      ENTRENADOR_ASIGNAR_EJERCICIO_ENDPOINT.replaceAll('{rutinaId}', rutinaId.toString()),
      body: {
        'ejercicioId': ejercicioId,
        'orden': orden,
        'series': series,
        'tipoMetrica': tipoMetrica,
        'repeticiones': repeticiones,
        'duracionSeg': duracionSeg,
        'pesoKg': pesoKg,
        'descansoSeg': descansoSeg,
      },
    );

    if (response is Map) {
      return Map<String, dynamic>.from(response);
    }
    throw ApiException(statusCode: -1, message: 'Respuesta invalida al asignar ejercicio', details: response);
  }

  Future<Map<String, dynamic>> modificarEjecucion({
    required int ejecucionId,
    int? series,
    int? repeticiones,
    int? duracionSeg,
    int? pesoKg,
    int? descansoSeg,
    int? orden,
  }) async {
    final response = await _api.put(
      ENTRENADOR_EDITAR_EJECUCION_ENDPOINT.replaceAll('{ejecucionId}', ejecucionId.toString()),
      body: {
        'series': series,
        'repeticiones': repeticiones,
        'duracionSeg': duracionSeg,
        'pesoKg': pesoKg,
        'descansoSeg': descansoSeg,
        'orden': orden,
      },
    );

    if (response is Map) {
      return Map<String, dynamic>.from(response);
    }
    throw ApiException(statusCode: -1, message: 'Respuesta invalida al modificar ejercicio', details: response);
  }

  Future<Map<String, dynamic>> eliminarEjecucion(int ejecucionId) async {
    final response = await _api.delete(
      ENTRENADOR_ELIMINAR_EJECUCION_ENDPOINT.replaceAll('{ejecucionId}', ejecucionId.toString()),
    );
    if (response is Map) {
      return Map<String, dynamic>.from(response);
    }
    throw ApiException(statusCode: -1, message: 'Respuesta invalida al eliminar ejercicio', details: response);
  }

  Future<dynamic> crearEjercicio({required String nombre, String? descripcion}) {
    return _api.post(
      EJERCICIOS_CATALOGO_ENDPOINT,
      body: {'nombre': nombre, 'descripcion': descripcion},
    );
  }

  Future<dynamic> actualizarEjercicio({required int ejercicioId, String? nombre, String? descripcion}) {
    return _api.put(
      '$EJERCICIOS_CATALOGO_ENDPOINT/$ejercicioId',
      body: {'nombre': nombre, 'descripcion': descripcion},
    );
  }

  Future<dynamic> eliminarEjercicio(int ejercicioId) {
    return _api.delete(
      '$EJERCICIOS_CATALOGO_ENDPOINT/$ejercicioId',
    );
  }
}