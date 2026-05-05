class ClaseGrupalModel {
	final int id;
	final String nombre;
	final String? descripcion;
	final int? entrenadorId;
	final String? entrenadorNombre;
	final DateTime fechaHora;
	final int cupoMaximo;
	final int cupoActual;
	final bool inscripcionesAbiertas;

	const ClaseGrupalModel({
		required this.id,
		required this.nombre,
		required this.descripcion,
		required this.entrenadorId,
		required this.entrenadorNombre,
		required this.fechaHora,
		required this.cupoMaximo,
		required this.cupoActual,
		required this.inscripcionesAbiertas,
	});

	factory ClaseGrupalModel.fromJson(Map<String, dynamic> json) {
		return ClaseGrupalModel(
			id: json['id'] as int,
			nombre: json['nombre'] as String,
			descripcion: json['descripcion'] as String?,
			entrenadorId: json['entrenadorId'] as int?,
			entrenadorNombre: json['entrenadorNombre']?.toString(),
			fechaHora: DateTime.tryParse(json['fechaHora']?.toString() ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
			cupoMaximo: json['cupoMaximo'] as int? ?? 0,
			cupoActual: json['cupoActual'] as int? ?? 0,
			inscripcionesAbiertas: json['inscripcionesAbiertas'] as bool? ?? false,
		);
	}

	String get cuposLabel => '$cupoActual/$cupoMaximo';
}
