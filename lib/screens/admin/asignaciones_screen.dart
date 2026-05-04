import 'package:flutter/material.dart';

class AdminAsignacionesScreen extends StatelessWidget {
  const AdminAsignacionesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entrenadores = [
      {'name': 'Nombre Entrenador A', 'clientes': '12', 'rutinas': '54', 'antiguedad': '5 Años'},
      {'name': 'Nombre Entrenadora B', 'clientes': '8', 'rutinas': '35', 'antiguedad': '3 Años'},
      {'name': 'Nombre Entrenadora C', 'clientes': '10', 'rutinas': '42', 'antiguedad': '4 Años'},
      {'name': 'Nombre Entrenador D', 'clientes': '15', 'rutinas': '60', 'antiguedad': '6 Años'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF262525),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Entrenadores', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Nº Entrenadores: xxx', style: TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: entrenadores.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final ent = entrenadores[i];
                    return _AdminEntrenadorCard(
                      name: ent['name'] as String,
                      clientes: ent['clientes'] as String,
                      rutinas: ent['rutinas'] as String,
                      antiguedad: ent['antiguedad'] as String,
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

class _AdminEntrenadorCard extends StatelessWidget {
  final String name;
  final String clientes;
  final String rutinas;
  final String antiguedad;

  const _AdminEntrenadorCard({
    required this.name,
    required this.clientes,
    required this.rutinas,
    required this.antiguedad,
  });

  @override
  Widget build(BuildContext context) {
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
                child: Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ),
              Icon(Icons.chevron_right, color: const Color(0xFFFFB84E)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.black, height: 1),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nº Clientes asignados\n(actualmente)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(clientes, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black))
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Antigüedad:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(antiguedad, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Rutinas asignadas a sus clientes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(rutinas, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black))
            ],
          )
        ],
      ),
    );
  }
}
