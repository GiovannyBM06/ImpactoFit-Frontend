import 'package:flutter/material.dart';

class AdminClientesScreen extends StatelessWidget {
  const AdminClientesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientes = [
      {
        'name': 'Nombre Cliente A',
        'level': 'Principiante',
        'asistencia': '13',
        'semana': '4',
        'antiguedad': '3 meses',
        'observaciones': 'El usuario es consistente con los entrenamiento y suele llevar a cabo todos los ejercicios planteados',
        'entrenador': 'No asignado'
      },
      {
        'name': 'Nombre Cliente B',
        'level': 'Intermedio',
        'asistencia': '15',
        'semana': '3',
        'antiguedad': '2 meses',
        'observaciones': 'Progreso constante en los ejercicios',
        'entrenador': 'Entrenador X'
      },
      {
        'name': 'Nombre Cliente C',
        'level': 'Principiante',
        'asistencia': '10',
        'semana': '2',
        'antiguedad': '1 mes',
        'observaciones': 'Necesita más seguimiento',
        'entrenador': 'No asignado'
      },
      {
        'name': 'Nombre Cliente D',
        'level': 'Avanzado',
        'asistencia': '20',
        'semana': '5',
        'antiguedad': '6 meses',
        'observaciones': 'Alumno dedicado',
        'entrenador': 'Entrenador Y'
      },
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
              const Text('Clientes', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Nº Clientes: xxx', style: TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: clientes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final cliente = clientes[i];
                    return _AdminClienteCard(
                      name: cliente['name'] as String,
                      level: cliente['level'] as String,
                      asistencia: cliente['asistencia'] as String,
                      semana: cliente['semana'] as String,
                      antiguedad: cliente['antiguedad'] as String,
                      observaciones: cliente['observaciones'] as String,
                      entrenador: cliente['entrenador'] as String,
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

class _AdminClienteCard extends StatelessWidget {
  final String name;
  final String level;
  final String asistencia;
  final String semana;
  final String antiguedad;
  final String observaciones;
  final String entrenador;

  const _AdminClienteCard({
    required this.name,
    required this.level,
    required this.asistencia,
    required this.semana,
    required this.antiguedad,
    required this.observaciones,
    required this.entrenador,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    Text(level, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFFFF8D28))),
                  ],
                ),
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
                    const Text('Nº asistencia', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(asistencia, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('últmo mes:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(asistencia, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                ],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Semana pasada:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(semana, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                ],
              ),
              const SizedBox(width: 12),
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Observaciones:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(observaciones, style: const TextStyle(fontSize: 14))
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Entrenador: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    Text(entrenador, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: entrenador.contains('No') ? Colors.red : Colors.green))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(50)),
                child: const Text('Asignar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14)),
              )
            ],
          )
        ],
      ),
    );
  }
}
