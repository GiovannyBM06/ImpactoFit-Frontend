class MembresiaModel {
	final int id;
	final int usuarioId;
	final String tipo;
	final String estado;
	final DateTime? fechaInicio;
	final DateTime? fechaVencimiento;

	const MembresiaModel({
		required this.id,
		required this.usuarioId,
		required this.tipo,
		required this.estado,
		required this.fechaInicio,
		required this.fechaVencimiento,
	});

	factory MembresiaModel.fromJson(Map<String, dynamic> json) {
		return MembresiaModel(
			id: json['id'] as int,
			usuarioId: json['usuarioId'] as int,
			tipo: json['tipo']?.toString() ?? '',
			estado: json['estado']?.toString() ?? '',
			fechaInicio: DateTime.tryParse(json['fechaInicio']?.toString() ?? ''),
			fechaVencimiento: DateTime.tryParse(json['fechaVencimiento']?.toString() ?? ''),
		);
	}
}
