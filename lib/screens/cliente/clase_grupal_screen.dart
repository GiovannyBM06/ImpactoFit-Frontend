import 'package:flutter/material.dart';

class ClienteClaseGrupalScreen extends StatelessWidget {
  const ClienteClaseGrupalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clases = [
      {
        'titulo': 'Cardio Intenso',
        'entrenador': 'Juan Pérez',
        'hora': '06:30 - 07:30',
        'dia': 'Lunes, Miércoles, Viernes',
        'cupos': '10/15',
        'imagen': 'assets/images/cardio.jpg'
      },
      {
        'titulo': 'Yoga Relax',
        'entrenador': 'María García',
        'hora': '18:00 - 19:00',
        'dia': 'Martes, Jueves',
        'cupos': '12/15',
        'imagen': 'assets/images/yoga.jpg'
      },
      {
        'titulo': 'Musculación',
        'entrenador': 'Carlos López',
        'hora': '07:00 - 08:00',
        'dia': 'Lunes, Miércoles, Viernes',
        'cupos': '8/12',
        'imagen': 'assets/images/musculacion.jpg'
      },
      {
        'titulo': 'Zumba Fun',
        'entrenador': 'Sofia Martínez',
        'hora': '19:00 - 20:00',
        'dia': 'Martes, Jueves, Sábado',
        'cupos': '15/20',
        'imagen': 'assets/images/zumba.jpg'
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
              const Text('Clases Grupales', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: clases.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final clase = clases[i];
                    return _ClaseCard(
                      titulo: clase['titulo'] as String,
                      entrenador: clase['entrenador'] as String,
                      hora: clase['hora'] as String,
                      dia: clase['dia'] as String,
                      cupos: clase['cupos'] as String,
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

class _ClaseCard extends StatelessWidget {
  final String titulo;
  final String entrenador;
  final String hora;
  final String dia;
  final String cupos;

  const _ClaseCard({
    required this.titulo,
    required this.entrenador,
    required this.hora,
    required this.dia,
    required this.cupos,
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
                child: Text(titulo, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(4)),
                child: Text(cupos, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12)),
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
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Te inscribiste en $titulo')),
                );
              },
              child: const Text('Inscribirse', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
            ),
          )
        ],
      ),
    );
  }
}
