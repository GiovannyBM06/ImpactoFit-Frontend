import 'package:flutter/material.dart';

import '../../models/rutina.dart';
import '../../services/rutina_service.dart';

class MiRutinaScreen extends StatefulWidget {
  const MiRutinaScreen({Key? key}) : super(key: key);

  @override
  State<MiRutinaScreen> createState() => _MiRutinaScreenState();
}

class _MiRutinaScreenState extends State<MiRutinaScreen> {
  final _service = RutinaService();
  late Future<RutinaModel> _futureRutina;

  @override
  void initState() {
    super.initState();
    _futureRutina = _service.obtenerMiRutina();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureRutina = _service.obtenerMiRutina();
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
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                  const Expanded(child: Center(child: Text('Mi Rutina', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)))),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: FutureBuilder<RutinaModel>(
                  future: _futureRutina,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB84E)));
                    }

                    if (snapshot.hasError) {
                      return _ErrorState(message: snapshot.error.toString(), onRetry: _refresh);
                    }

                    final rutina = snapshot.data;
                    if (rutina == null || rutina.ejercicios.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView(
                          children: const [
                            SizedBox(height: 120),
                            Center(
                              child: Text('No tienes una rutina activa', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.separated(
                        itemCount: rutina.ejercicios.length + 1,
                        separatorBuilder: (_, index) => index == 0 ? const SizedBox(height: 12) : const SizedBox(height: 18),
                        itemBuilder: (context, i) {
                          if (i == 0) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(rutina.nombre, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 4),
                                if (rutina.descripcion != null)
                                  Text(rutina.descripcion!, style: TextStyle(color: Colors.white.withOpacity(0.7))),
                                const SizedBox(height: 8),
                                Text('${rutina.ejercicios.length} ejercicio(s)', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                              ],
                            );
                          }

                          final ejercicio = rutina.ejercicios[i - 1];
                          return ExerciseCard(
                            title: ejercicio.nombre,
                            series: '${ejercicio.series}x',
                            reps: ejercicio.repeticiones != null ? '${ejercicio.repeticiones}' : (ejercicio.duracionSeg != null ? '${ejercicio.duracionSeg} seg' : '-'),
                            time: ejercicio.descansoSeg != null ? '${ejercicio.descansoSeg} seg' : '-',
                            bottomLeft: ejercicio.tipoMetrica,
                            estimate: ejercicio.pesoKg != null ? '${ejercicio.pesoKg} kg' : '',
                            description: ejercicio.descripcion,
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
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final String title;
  final String series;
  final String reps;
  final String time;
  final String bottomLeft;
  final String estimate;
  final String? description;

  const ExerciseCard({required this.title, required this.series, required this.reps, required this.time, required this.bottomLeft, required this.estimate, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            height: 92,
            width: double.infinity,
            decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)), color: Color(0xFFF3F2F2)),
            padding: const EdgeInsets.all(12),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                if (description != null) ...[
                  const SizedBox(height: 4),
                  Text(description!, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                ]
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Series', style: TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w600)), const SizedBox(height: 4), Text(series, style: const TextStyle(fontWeight: FontWeight.w600))]),
                    const SizedBox(width: 24),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Repeticiones / tiempo', style: TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w600)), const SizedBox(height: 4), Text(reps, style: const TextStyle(fontWeight: FontWeight.w600))]),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(color: const Color(0xFFF3F3F3), borderRadius: BorderRadius.circular(5)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Descanso', style: TextStyle(fontWeight: FontWeight.w600)), Text(time)]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)), child: const Icon(Icons.pause, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(bottomLeft, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Column(children: [const Text('Detalle', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)), const SizedBox(height: 4), Text(estimate, style: const TextStyle(fontWeight: FontWeight.w600))])
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.white),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: onRetry, child: const Text('Reintentar')),
        ],
      ),
    );
  }
}
