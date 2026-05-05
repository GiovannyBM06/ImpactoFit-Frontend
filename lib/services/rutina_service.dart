import '../core/api_client.dart';
import '../core/constants.dart';
import '../models/rutina.dart';

class RutinaService {
	static final RutinaService _instance = RutinaService._internal();

	factory RutinaService() => _instance;

	RutinaService._internal();

	final _api = ApiClient();

	Future<RutinaModel> obtenerMiRutina() async {
		final response = await _api.get(CLIENTE_RUTINA_ENDPOINT);
		if (response is Map) {
			return RutinaModel.fromJson(Map<String, dynamic>.from(response));
		}
		throw ApiException(statusCode: -1, message: 'Respuesta inválida al obtener la rutina', details: response);
	}

	Future<RutinaModel> obtenerRutinaDeCliente(int clienteId) async {
		final endpoint = ENTRENADOR_RUTINA_ENDPOINT.replaceAll('{clienteId}', clienteId.toString());
		final response = await _api.get(endpoint);
		if (response is Map) {
			return RutinaModel.fromJson(Map<String, dynamic>.from(response));
		}
		throw ApiException(statusCode: -1, message: 'Respuesta inválida al obtener la rutina del cliente', details: response);
	}
}
