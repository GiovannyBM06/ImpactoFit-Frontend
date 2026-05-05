import '../core/api_client.dart';
import '../core/constants.dart';
import '../models/clase_grupal.dart';

class ClaseService {
	static final ClaseService _instance = ClaseService._internal();

	factory ClaseService() => _instance;

	ClaseService._internal();

	final _api = ApiClient();

	Future<List<ClaseGrupalModel>> obtenerClasesDisponibles() async {
		final response = await _api.get(CLIENTE_CLASES_ENDPOINT);
		if (response is List) {
			return response
					.whereType<Map>()
					.map((json) => ClaseGrupalModel.fromJson(Map<String, dynamic>.from(json)))
					.toList();
		}
		throw ApiException(statusCode: -1, message: 'Respuesta inválida al listar clases', details: response);
	}

	Future<dynamic> inscribirse(int claseId) {
		return _api.post(
			CLIENTE_INSCRIBIR_CLASE_ENDPOINT.replaceAll('{claseId}', claseId.toString()),
			body: {},
		);
	}

	Future<dynamic> cancelarInscripcion(int claseId) {
		return _api.put(
			CLIENTE_CANCELAR_CLASE_ENDPOINT.replaceAll('{claseId}', claseId.toString()),
			body: {},
		);
	}
}
