import 'package:flutter/material.dart';

class EntrenadorEjerciciosScreen extends StatefulWidget {
  const EntrenadorEjerciciosScreen({Key? key}) : super(key: key);

  @override
  State<EntrenadorEjerciciosScreen> createState() => _EntrenadorEjerciciosScreenState();
}

class _EntrenadorEjerciciosScreenState extends State<EntrenadorEjerciciosScreen> {
  final ejercicios = [
    {
      'nombre': 'Sentadilla',
      'series': '4',
      'reps': '12',
      'peso': '80 kg',
      'descanso': '90 seg',
      'musculo': 'Piernas'
    },
    {
      'nombre': 'Press de Banca',
      'series': '4',
      'reps': '10',
      'peso': '60 kg',
      'descanso': '2 min',
      'musculo': 'Pecho'
    },
    {
      'nombre': 'Dominadas',
      'series': '3',
      'reps': '8',
      'peso': 'Peso corporal',
      'descanso': '90 seg',
      'musculo': 'Espalda'
    },
    {
      'nombre': 'Flexiones',
      'series': '3',
      'reps': '15',
      'peso': 'Peso corporal',
      'descanso': '60 seg',
      'musculo': 'Pecho'
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              const Text('Ejercicios', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text('Total: ${ejercicios.length} ejercicios', style: const TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: ejercicios.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final ej = ejercicios[i];
                    return _EjercicioCard(
                      nombre: ej['nombre'] as String,
                      series: ej['series'] as String,
                      reps: ej['reps'] as String,
                      peso: ej['peso'] as String,
                      descanso: ej['descanso'] as String,
                      musculo: ej['musculo'] as String,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Agregar nuevo ejercicio')));
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black, size: 32),
      ),
    );
  }
}

class _EjercicioCard extends StatelessWidget {
  final String nombre;
  final String series;
  final String reps;
  final String peso;
  final String descanso;
  final String musculo;

  const _EjercicioCard({
    required this.nombre,
    required this.series,
    required this.reps,
    required this.peso,
    required this.descanso,
    required this.musculo,
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
                decoration: BoxDecoration(color: const Color(0xFFFF8D28), borderRadius: BorderRadius.circular(4)),
                child: Text(musculo, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Series', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(series, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFFFFB84E)))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Repeticiones', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(reps, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFFFFB84E)))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Peso', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(peso, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFFFFB84E)))
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Descanso', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(descanso, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFFFFB84E)))
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Editar $nombre'))),
                    icon: const Icon(Icons.edit, color: Color(0xFFFFB84E)),
                  ),
                  IconButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Eliminar $nombre'))),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
