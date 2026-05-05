import 'package:flutter/material.dart';

import '../../services/entrenador_service.dart';

class EntrenadorEjerciciosScreen extends StatefulWidget {
  const EntrenadorEjerciciosScreen({Key? key}) : super(key: key);

  @override
  State<EntrenadorEjerciciosScreen> createState() => _EntrenadorEjerciciosScreenState();
}

class _EntrenadorEjerciciosScreenState extends State<EntrenadorEjerciciosScreen> {
  final _service = EntrenadorService();
  late Future<List<Map<String, dynamic>>> _futureEjercicios;

  @override
  void initState() {
    super.initState();
    _futureEjercicios = _service.obtenerEjerciciosCatalogo();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureEjercicios = _service.obtenerEjerciciosCatalogo();
    });
  }

  Future<void> _createExercise() async {
    final nombreController = TextEditingController();
    final descripcionController = TextEditingController();

    final created = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuevo ejercicio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nombreController, decoration: const InputDecoration(labelText: 'Nombre')),
            TextField(controller: descripcionController, decoration: const InputDecoration(labelText: 'Descripción')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () async {
              await _service.crearEjercicio(nombre: nombreController.text.trim(), descripcion: descripcionController.text.trim().isEmpty ? null : descripcionController.text.trim());
              if (!mounted) return;
              Navigator.pop(context, true);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    nombreController.dispose();
    descripcionController.dispose();

    if (created == true) {
      await _refresh();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ejercicio creado')));
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
              const Text('Ejercicios', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _futureEjercicios,
                builder: (context, snapshot) {
                  final count = snapshot.data?.length ?? 0;
                  return Text('Total: $count ejercicios', style: const TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700, fontSize: 16));
                },
              ),
              const SizedBox(height: 24),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _futureEjercicios,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB84E)));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white)));
                    }

                    final ejercicios = snapshot.data ?? [];
                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.separated(
                        itemCount: ejercicios.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) {
                          final ej = ejercicios[i];
                          return _EjercicioCard(
                            nombre: ej['nombre']?.toString() ?? '',
                            descripcion: ej['descripcion']?.toString(),
                          );
                        },
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
        onPressed: _createExercise,
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black, size: 32),
      ),
    );
  }
}

class _EjercicioCard extends StatelessWidget {
  final String nombre;
  final String? descripcion;

  const _EjercicioCard({required this.nombre, required this.descripcion});

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
              const SizedBox.shrink()
            ],
          ),
          const SizedBox(height: 12),
          if (descripcion != null && descripcion!.isNotEmpty) Text(descripcion!, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }
}
