import '../core/api_client.dart';
import '../core/constants.dart';

class AsistenciaService {
	static final AsistenciaService _instance = AsistenciaService._internal();

	factory AsistenciaService() => _instance;

	AsistenciaService._internal();

	final _api = ApiClient();

	Future<dynamic> registrarAsistencia({String? observaciones}) {
		return _api.post(
			CLIENTE_ASISTENCIA_ENDPOINT,
			body: {'observaciones': observaciones},
		);
	}
}
