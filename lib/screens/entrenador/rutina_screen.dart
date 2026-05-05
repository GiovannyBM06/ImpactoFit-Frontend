import 'package:flutter/material.dart';

import '../../models/rutina.dart';
import '../../services/entrenador_service.dart';

class EntrenadorRutinaScreen extends StatefulWidget {
  final int? clienteId;
  final String? clienteNombre;

  const EntrenadorRutinaScreen({Key? key, this.clienteId, this.clienteNombre}) : super(key: key);

  @override
  State<EntrenadorRutinaScreen> createState() => _EntrenadorRutinaScreenState();
}

class _EntrenadorRutinaScreenState extends State<EntrenadorRutinaScreen> {
  final _service = EntrenadorService();
  late Future<RutinaModel>? _futureRutina;

  @override
  void initState() {
    super.initState();
    _futureRutina = widget.clienteId == null ? null : _service.obtenerRutinaDeCliente(widget.clienteId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262525),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          const Text('Rutina:', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
                          Text(widget.clienteNombre ?? 'Seleccione un cliente', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 8),
              if (_futureRutina == null)
                const Expanded(
                  child: Center(
                    child: Text('Abre esta pantalla desde la lista de clientes para ver su rutina.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                  ),
                )
              else
                Expanded(
                  child: FutureBuilder<RutinaModel>(
                    future: _futureRutina,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB84E)));
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white)));
                      }

                      final rutina = snapshot.data;
                      if (rutina == null || rutina.ejercicios.isEmpty) {
                        return const Center(child: Text('Este cliente no tiene rutina activa', style: TextStyle(color: Colors.white)));
                      }

                      return ListView.separated(
                        itemCount: rutina.ejercicios.length + 1,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) {
                          if (i == 0) {
                            return Text('${rutina.ejercicios.length} ejercicio(s) asignado(s)', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15));
                          }

                          final ejercicio = rutina.ejercicios[i - 1];
                          return Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ejercicio #${ejercicio.orden}', style: const TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w500, fontSize: 15)),
                                const SizedBox(height: 8),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: const Color(0xFFF3F2F2), borderRadius: BorderRadius.circular(8)),
                                  child: Text(ejercicio.nombre, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
                                ),
                                const SizedBox(height: 8),
                                if (ejercicio.descripcion != null) Text(ejercicio.descripcion!, style: const TextStyle(color: Colors.black87)),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    _MiniInfo(label: 'Series', value: '${ejercicio.series}'),
                                    _MiniInfo(label: 'Métrica', value: ejercicio.tipoMetrica),
                                    _MiniInfo(label: 'Repeticiones', value: ejercicio.repeticiones?.toString() ?? '-'),
                                    _MiniInfo(label: 'Duración', value: ejercicio.duracionSeg?.toString() ?? '-'),
                                    _MiniInfo(label: 'Peso', value: ejercicio.pesoKg?.toString() ?? '-'),
                                    _MiniInfo(label: 'Descanso', value: ejercicio.descansoSeg?.toString() ?? '-'),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
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

class _MiniInfo extends StatelessWidget {
  final String label;
  final String value;

  const _MiniInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: const Color(0xFFF3F2F2), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFFF8D28))),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
