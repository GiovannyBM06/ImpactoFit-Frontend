class UsuarioModel {
	final int id;
	final String nombre;
	final String apellido;
	final String email;
	final String? telefono;
	final String rol;
	final bool isActive;
	final DateTime createdAt;

	const UsuarioModel({
		required this.id,
		required this.nombre,
		required this.apellido,
		required this.email,
		required this.telefono,
		required this.rol,
		required this.isActive,
		required this.createdAt,
	});

	String get fullName => '$nombre $apellido'.trim();

	factory UsuarioModel.fromJson(Map<String, dynamic> json) {
		return UsuarioModel(
			id: json['id'] as int,
			nombre: json['nombre'] as String,
			apellido: json['apellido'] as String,
			email: json['email'] as String,
			telefono: json['telefono'] as String?,
			rol: json['rol']?.toString() ?? '',
			isActive: json['isActive'] as bool? ?? false,
			createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
		);
	}
}
