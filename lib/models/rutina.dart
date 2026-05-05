class RutinaEjercicioModel {
	final int ejecucionId;
	final int ejercicioId;
	final String nombre;
	final String? descripcion;
	final int orden;
	final int series;
	final String tipoMetrica;
	final int? repeticiones;
	final int? duracionSeg;
	final int? pesoKg;
	final int? descansoSeg;

	const RutinaEjercicioModel({
		required this.ejecucionId,
		required this.ejercicioId,
		required this.nombre,
		required this.descripcion,
		required this.orden,
		required this.series,
		required this.tipoMetrica,
		required this.repeticiones,
		required this.duracionSeg,
		required this.pesoKg,
		required this.descansoSeg,
	});

	factory RutinaEjercicioModel.fromJson(Map<String, dynamic> json) {
		return RutinaEjercicioModel(
			ejecucionId: json['ejecucionId'] as int,
			ejercicioId: json['ejercicioId'] as int,
			nombre: json['nombre'] as String,
			descripcion: json['descripcion'] as String?,
			orden: json['orden'] as int? ?? 0,
			series: json['series'] as int? ?? 0,
			tipoMetrica: json['tipoMetrica']?.toString() ?? '',
			repeticiones: json['repeticiones'] as int?,
			duracionSeg: json['duracionSeg'] as int?,
			pesoKg: json['pesoKg'] as int?,
			descansoSeg: json['descansoSeg'] as int?,
		);
	}
}

class RutinaModel {
	final int id;
	final int? clienteId;
	final int? entrenadorId;
	final String nombre;
	final String? descripcion;
	final bool activa;
	final List<RutinaEjercicioModel> ejercicios;

	const RutinaModel({
		required this.id,
		required this.clienteId,
		required this.entrenadorId,
		required this.nombre,
		required this.descripcion,
		required this.activa,
		required this.ejercicios,
	});

	factory RutinaModel.fromJson(Map<String, dynamic> json) {
		final ejerciciosJson = (json['ejercicios'] as List<dynamic>? ?? []);
		return RutinaModel(
			id: json['id'] as int,
			clienteId: json['clienteId'] as int?,
			entrenadorId: json['entrenadorId'] as int?,
			nombre: json['nombre'] as String,
			descripcion: json['descripcion'] as String?,
			activa: json['activa'] as bool? ?? false,
			ejercicios: ejerciciosJson
					.whereType<Map>()
					.map((e) => RutinaEjercicioModel.fromJson(Map<String, dynamic>.from(e)))
					.toList(),
		);
	}
}
