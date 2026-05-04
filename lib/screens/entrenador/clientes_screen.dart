import 'package:flutter/material.dart';
import 'rutina_screen.dart';

class ClientesEntrenadorScreen extends StatelessWidget {
  const ClientesEntrenadorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientes = [
      {'name': 'Nombre Cliente A', 'level': 'Principiante', 'days': 'Lunes Miércoles Viernes', 'time': '15:30 - 17:00 8:00 a 9:30'},
      {'name': 'Nombre Cliente B', 'level': 'Intermedio', 'days': 'Martes Jueves', 'time': '10:00 - 11:00'},
      {'name': 'Nombre Cliente C', 'level': 'Principiante', 'days': 'Lunes Miércoles', 'time': '18:00 - 19:00'},
      {'name': 'Nombre Cliente D', 'level': 'Avanzado', 'days': 'Todos los días', 'time': '06:00 - 07:00'},
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
              const Text('Nº Clientes: 10', style: TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: clientes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final cliente = clientes[i];
                    return ClienteCard(
                      name: cliente['name'] as String,
                      level: cliente['level'] as String,
                      days: cliente['days'] as String,
                      time: cliente['time'] as String,
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

class ClienteCard extends StatelessWidget {
  final String name;
  final String level;
  final String days;
  final String time;

  const ClienteCard({required this.name, required this.level, required this.days, required this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/entrenador/rutina'),
      child: Container(
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
                      Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black)),
                      Text(level, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFFFF8D28))),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: level.contains('Principiante') || level.contains('Avanzado') ? Colors.black : Colors.black),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.black, height: 1),
            const SizedBox(height: 8),
            const Text('Horario Habitual', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Días', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
                  const SizedBox(height: 4),
                  Text(days, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black)),
                  const SizedBox(height: 8),
                  const Text('Hora habitual', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
                  const SizedBox(height: 4),
                  Text(time, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(onPressed: () => Navigator.of(context).pushNamed('/entrenador/rutina'), child: const Text('Ver rutina', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))),
            )
          ],
        ),
      ),
    );
  }
}
