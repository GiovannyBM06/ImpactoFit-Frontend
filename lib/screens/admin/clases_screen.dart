import 'package:flutter/material.dart';

class AdminClasesScreen extends StatelessWidget {
  const AdminClasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clases = [
      {
        'nombre': 'Cardio Intenso',
        'entrenador': 'Juan Pérez',
        'hora': '06:30',
        'dia': 'Lunes, Miércoles, Viernes',
        'cupos': '15',
        'inscritos': '12',
      },
      {
        'nombre': 'Yoga Relax',
        'entrenador': 'María García',
        'hora': '18:00',
        'dia': 'Martes, Jueves',
        'cupos': '15',
        'inscritos': '14',
      },
      {
        'nombre': 'Musculación',
        'entrenador': 'Carlos López',
        'hora': '07:00',
        'dia': 'Lunes, Miércoles, Viernes',
        'cupos': '12',
        'inscritos': '10',
      },
      {
        'nombre': 'Zumba Fun',
        'entrenador': 'Sofia Martínez',
        'hora': '19:00',
        'dia': 'Martes, Jueves, Sábado',
        'cupos': '20',
        'inscritos': '18',
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
              const Text('Clases Grupales', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text('Nº Clases: ${clases.length}', style: const TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: clases.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final clase = clases[i];
                    return _AdminClaseCard(
                      nombre: clase['nombre'] as String,
                      entrenador: clase['entrenador'] as String,
                      hora: clase['hora'] as String,
                      dia: clase['dia'] as String,
                      cupos: clase['cupos'] as String,
                      inscritos: clase['inscritos'] as String,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/admin/crear_clase'),
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black, size: 32),
      ),
    );
  }
}

class _AdminClaseCard extends StatelessWidget {
  final String nombre;
  final String entrenador;
  final String hora;
  final String dia;
  final String cupos;
  final String inscritos;

  const _AdminClaseCard({
    required this.nombre,
    required this.entrenador,
    required this.hora,
    required this.dia,
    required this.cupos,
    required this.inscritos,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(nombre, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(4)),
                child: Text('$inscritos/$cupos', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12)),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(entrenador, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(hora, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Expanded(
                child: Text(dia, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E)),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Editar $nombre'))),
                  child: const Text('Editar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Eliminar $nombre'))),
                  child: const Text('Eliminar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
