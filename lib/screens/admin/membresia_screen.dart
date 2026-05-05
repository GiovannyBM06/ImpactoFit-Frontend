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

  Future<void> _confirmarPago(MembresiaModel membresia) async {
    final montoController = TextEditingController();
    final notasController = TextEditingController();

    try {
      final confirmado = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirmar pago #${membresia.id}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: montoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Monto'),
              ),
              TextField(
                controller: notasController,
                decoration: const InputDecoration(labelText: 'Notas (opcional)'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Confirmar')),
          ],
        ),
      );

      if (confirmado != true) return;

      final monto = int.tryParse(montoController.text.trim());
      if (monto == null || monto <= 0) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ingresa un monto valido')));
        return;
      }

      final result = await _service.activarMembresia(
        membresiaId: membresia.id,
        monto: monto,
        notas: notasController.text.trim().isEmpty ? null : notasController.text.trim(),
      );

      if (!mounted) return;
      final comprobante = result is Map ? (result['comprobanteCodigo']?.toString() ?? '-') : '-';
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Pago confirmado'),
          content: Text('Comprobante: $comprobante'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
          ],
        ),
      );
      await _refresh();
    } finally {
      montoController.dispose();
      notasController.dispose();
    }
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
                        itemBuilder: (context, i) => _MembresiaPlan(membresia: membresias[i], onConfirmarPago: () => _confirmarPago(membresias[i])),
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
  final VoidCallback onConfirmarPago;

  const _MembresiaPlan({required this.membresia, required this.onConfirmarPago});

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
          if (membresia.estado.toLowerCase() == 'pendiente')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E)),
                onPressed: onConfirmarPago,
                child: const Text('Confirmar pago y activar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
              ),
            )
          else
            const Text('Membresía ya activada o vencida', style: TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
