import 'package:flutter/material.dart';

class AdminUsuariosScreen extends StatelessWidget {
  const AdminUsuariosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarios = [
      {
        'nombre': 'Juan Fernando Lozano',
        'rol': 'Cliente',
        'email': 'juan@email.com',
        'estado': 'Activo',
        'fechaRegistro': '2024-01-15',
        'membresia': 'Plan Pro'
      },
      {
        'nombre': 'María García Pérez',
        'rol': 'Entrenador',
        'email': 'maria@email.com',
        'estado': 'Activo',
        'fechaRegistro': '2023-06-20',
        'membresia': 'N/A'
      },
      {
        'nombre': 'Carlos López López',
        'rol': 'Cliente',
        'email': 'carlos@email.com',
        'estado': 'Inactivo',
        'fechaRegistro': '2024-03-10',
        'membresia': 'Plan Básico'
      },
      {
        'nombre': 'Sofia Martínez García',
        'rol': 'Entrenador',
        'email': 'sofia@email.com',
        'estado': 'Activo',
        'fechaRegistro': '2023-09-05',
        'membresia': 'N/A'
      },
      {
        'nombre': 'Ana Rodríguez García',
        'rol': 'Cliente',
        'email': 'ana@email.com',
        'estado': 'Activo',
        'fechaRegistro': '2024-02-28',
        'membresia': 'Plan Premium'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF262525),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Usuarios', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text('Total: ${usuarios.length} usuarios', style: const TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: usuarios.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final user = usuarios[i];
                    return _UsuarioCard(
                      nombre: user['nombre'] as String,
                      rol: user['rol'] as String,
                      email: user['email'] as String,
                      estado: user['estado'] as String,
                      fechaRegistro: user['fechaRegistro'] as String,
                      membresia: user['membresia'] as String,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _UsuarioCard extends StatelessWidget {
  final String nombre;
  final String rol;
  final String email;
  final String estado;
  final String fechaRegistro;
  final String membresia;

  const _UsuarioCard({
    required this.nombre,
    required this.rol,
    required this.email,
    required this.estado,
    required this.fechaRegistro,
    required this.membresia,
  });

  @override
  Widget build(BuildContext context) {
    final esCliente = rol == 'Cliente';
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 22, backgroundColor: Colors.grey[300]),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nombre, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    Text(email, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: rol == 'Cliente' ? const Color(0xFFFFB84E) : const Color(0xFFFF8D28),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(rol, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
              )
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.black, height: 1),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Estado', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: estado == 'Activo' ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(estado, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: estado == 'Activo' ? Colors.green : Colors.red)),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Fecha Registro', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(fechaRegistro, style: const TextStyle(fontSize: 14, color: Colors.grey))
                ],
              ),
            ],
          ),
          if (esCliente) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Membresía: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
                  child: Text(membresia, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                )
              ],
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E)),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ver detalles de $nombre'))),
                  child: const Text('Ver', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Editar $nombre'))),
                  child: const Text('Editar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
