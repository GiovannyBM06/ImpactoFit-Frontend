import 'package:flutter/material.dart';

import '../../models/clase_grupal.dart';
import '../../services/admin_service.dart';

class AdminClasesScreen extends StatefulWidget {
  const AdminClasesScreen({Key? key}) : super(key: key);

  @override
  State<AdminClasesScreen> createState() => _AdminClasesScreenState();
}

class _AdminClasesScreenState extends State<AdminClasesScreen> {
  final _service = AdminService();
  late Future<List<ClaseGrupalModel>> _futureClases;

  @override
  void initState() {
    super.initState();
    _futureClases = _service.obtenerClases();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureClases = _service.obtenerClases();
    });
  }

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
              const Text('Clases Grupales', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Expanded(
                child: FutureBuilder<List<ClaseGrupalModel>>(
                  future: _futureClases,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB84E)));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white)));
                    }

                    final clases = snapshot.data ?? [];
                    if (clases.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView(
                          children: const [
                            SizedBox(height: 120),
                            Center(child: Text('No hay clases registradas', style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.separated(
                        itemCount: clases.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) => _AdminClaseCard(clase: clases[i]),
                      ),
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
  final ClaseGrupalModel clase;

  const _AdminClaseCard({required this.clase});

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
                child: Text(clase.nombre, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(4)),
                child: Text(clase.cuposLabel, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12)),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(clase.entrenadorId != null ? 'Entrenador #${clase.entrenadorId}' : 'Entrenador no disponible', style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(clase.fechaHora.toString(), style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Expanded(
                child: Text(clase.descripcion ?? 'Sin descripcion', style: const TextStyle(fontSize: 14, color: Colors.grey)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
