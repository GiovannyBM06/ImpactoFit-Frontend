import 'package:flutter/material.dart';

class AdminMembresiasScreen extends StatelessWidget {
  const AdminMembresiasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membresias = [
      {
        'nombre': 'Plan Básico',
        'precio': '\$29.99',
        'periodo': '/mes',
        'descripcion': 'Acceso a rutinas personalizadas',
        'beneficios': ['Rutinas personalizadas', 'Seguimiento básico', 'Soporte por email'],
        'activos': '145'
      },
      {
        'nombre': 'Plan Pro',
        'precio': '\$59.99',
        'periodo': '/mes',
        'descripcion': 'Entrenador dedicado incluido',
        'beneficios': ['Todo del Plan Básico', 'Entrenador dedicado', 'Clases grupales', 'Soporte prioritario'],
        'activos': '89'
      },
      {
        'nombre': 'Plan Premium',
        'precio': '\$99.99',
        'periodo': '/mes',
        'descripcion': 'Máxima personalización',
        'beneficios': ['Todo del Plan Pro', 'Nutrición personalizada', 'Evaluaciones mensuales', 'Soporte 24/7'],
        'activos': '34'
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
              const Text('Membresías', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: membresias.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, i) {
                    final mem = membresias[i];
                    return _MembresiaPlan(
                      nombre: mem['nombre'] as String,
                      precio: mem['precio'] as String,
                      periodo: mem['periodo'] as String,
                      descripcion: mem['descripcion'] as String,
                      beneficios: (mem['beneficios'] as List).cast<String>(),
                      activos: mem['activos'] as String,
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

class _MembresiaPlan extends StatelessWidget {
  final String nombre;
  final String precio;
  final String periodo;
  final String descripcion;
  final List<String> beneficios;
  final String activos;

  const _MembresiaPlan({
    required this.nombre,
    required this.precio,
    required this.periodo,
    required this.descripcion,
    required this.beneficios,
    required this.activos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nombre, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(descripcion, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: precio, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black)),
                        TextSpan(text: periodo, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(4)),
                    child: Text('$activos activos', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12)),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.black, height: 1),
          const SizedBox(height: 12),
          const Text('Beneficios:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...beneficios.map((b) => Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Color(0xFFFFB84E), size: 20),
                const SizedBox(width: 8),
                Expanded(child: Text(b, style: const TextStyle(fontSize: 14))),
              ],
            ),
          )),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E)),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Editar $nombre'))),
                  child: const Text('Editar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ver analytics de $nombre'))),
                  child: const Text('Analytics', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
