import 'package:flutter/material.dart';

import '../../models/usuario.dart';
import '../../services/admin_service.dart';

class AdminAsignacionesScreen extends StatefulWidget {
  const AdminAsignacionesScreen({Key? key}) : super(key: key);

  @override
  State<AdminAsignacionesScreen> createState() => _AdminAsignacionesScreenState();
}

class _AdminAsignacionesScreenState extends State<AdminAsignacionesScreen> {
  final _service = AdminService();
  late Future<List<UsuarioModel>> _futureEntrenadores;

  @override
  void initState() {
    super.initState();
    _futureEntrenadores = _service.obtenerEntrenadores();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureEntrenadores = _service.obtenerEntrenadores();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Entrenadores', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Expanded(
                child: FutureBuilder<List<UsuarioModel>>(
                  future: _futureEntrenadores,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB84E)));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white)));
                    }

                    final entrenadores = snapshot.data ?? [];
                    if (entrenadores.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView(
                          children: const [
                            SizedBox(height: 120),
                            Center(child: Text('No hay entrenadores registrados', style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.separated(
                        itemCount: entrenadores.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) => _AdminEntrenadorCard(entrenador: entrenadores[i]),
                      ),
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
  final UsuarioModel entrenador;

  const _AdminEntrenadorCard({required this.entrenador});

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
                child: Text(entrenador.fullName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
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
                    const Text('Email', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(entrenador.email, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black))
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Antigüedad', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(entrenador.createdAt.toIso8601String().split('T').first, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Estado', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(entrenador.isActive ? 'Activo' : 'Inactivo', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black))
            ],
          )
        ],
      ),
    );
  }
}
