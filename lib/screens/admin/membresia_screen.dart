import 'package:flutter/material.dart';

import '../../models/membresia.dart';
import '../../services/admin_service.dart';

class AdminMembresiasScreen extends StatefulWidget {
  const AdminMembresiasScreen({Key? key}) : super(key: key);

  @override
  State<AdminMembresiasScreen> createState() => _AdminMembresiasScreenState();
}

class _AdminMembresiasScreenState extends State<AdminMembresiasScreen> {
  final _service = AdminService();
  late Future<List<MembresiaModel>> _futureMembresias;

  @override
  void initState() {
    super.initState();
    _futureMembresias = _service.obtenerMembresias();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureMembresias = _service.obtenerMembresias();
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
              const Text('Membresías', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Expanded(
                child: FutureBuilder<List<MembresiaModel>>(
                  future: _futureMembresias,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB84E)));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white)));
                    }

                    final membresias = snapshot.data ?? [];
                    if (membresias.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView(
                          children: const [
                            SizedBox(height: 120),
                            Center(child: Text('No hay membresías registradas', style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.separated(
                        itemCount: membresias.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, i) => _MembresiaPlan(membresia: membresias[i]),
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

class _MembresiaPlan extends StatelessWidget {
  final MembresiaModel membresia;

  const _MembresiaPlan({required this.membresia});

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
                    Text('Membresía #${membresia.id}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text('Usuario ${membresia.usuarioId}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(membresia.tipo, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(4)),
                    child: Text(membresia.estado, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12)),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.black, height: 1),
          const SizedBox(height: 12),
          Row(children: [const Text('Inicio: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)), Text(membresia.fechaInicio?.toIso8601String().split('T').first ?? '-')]),
          const SizedBox(height: 6),
          Row(children: [const Text('Vence: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)), Text(membresia.fechaVencimiento?.toIso8601String().split('T').first ?? '-')]),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E)),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Editar membresía ${membresia.id}'))),
                  child: const Text('Editar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ver detalle de membresía ${membresia.id}'))),
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
