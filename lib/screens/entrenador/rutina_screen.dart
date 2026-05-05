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

  Future<void> _refresh() async {
    if (widget.clienteId == null) return;
    setState(() {
      _futureRutina = _service.obtenerRutinaDeCliente(widget.clienteId!);
    });
  }

  Future<void> _crearRutina() async {
    if (widget.clienteId == null) return;

    final nombreController = TextEditingController();
    final descripcionController = TextEditingController();

    try {
      final created = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Crear rutina'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nombreController, decoration: const InputDecoration(labelText: 'Nombre')),
              TextField(controller: descripcionController, decoration: const InputDecoration(labelText: 'Descripcion (opcional)')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Crear')),
          ],
        ),
      );

      if (created != true) return;

      await _service.crearRutina(
        clienteId: widget.clienteId!,
        nombre: nombreController.text.trim(),
        descripcion: descripcionController.text.trim().isEmpty ? null : descripcionController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rutina creada')));
      await _refresh();
    } finally {
      nombreController.dispose();
      descripcionController.dispose();
    }
  }

  Future<void> _agregarEjercicio(int rutinaId) async {
    final catalogo = await _service.obtenerEjerciciosCatalogo();
    if (!mounted) return;

    if (catalogo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No hay ejercicios en el catalogo')));
      return;
    }

    int? ejercicioId = (catalogo.first['id'] as int?);
    final ordenController = TextEditingController(text: '1');
    final seriesController = TextEditingController(text: '3');
    final metricaController = ValueNotifier<String>('repeticiones');
    final repeticionesController = TextEditingController(text: '12');
    final duracionController = TextEditingController();
    final pesoController = TextEditingController();
    final descansoController = TextEditingController(text: '60');

    try {
      final created = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Asignar ejercicio'),
          content: StatefulBuilder(
            builder: (context, setModalState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<int>(
                      value: ejercicioId,
                      items: catalogo
                          .map((e) => DropdownMenuItem<int>(
                                value: e['id'] as int,
                                child: Text(e['nombre']?.toString() ?? 'Ejercicio'),
                              ))
                          .toList(),
                      onChanged: (value) => setModalState(() => ejercicioId = value),
                      decoration: const InputDecoration(labelText: 'Ejercicio'),
                    ),
                    TextField(controller: ordenController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Orden')),
                    TextField(controller: seriesController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Series')),
                    DropdownButtonFormField<String>(
                      value: metricaController.value,
                      items: const [
                        DropdownMenuItem(value: 'repeticiones', child: Text('Repeticiones')),
                        DropdownMenuItem(value: 'tiempo', child: Text('Tiempo')),
                      ],
                      onChanged: (value) => setModalState(() => metricaController.value = value ?? 'repeticiones'),
                      decoration: const InputDecoration(labelText: 'Tipo metrica'),
                    ),
                    if (metricaController.value == 'repeticiones')
                      TextField(controller: repeticionesController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Repeticiones')),
                    if (metricaController.value == 'tiempo')
                      TextField(controller: duracionController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Duracion (seg)')),
                    TextField(controller: pesoController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Peso kg (opcional)')),
                    TextField(controller: descansoController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Descanso seg (opcional)')),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Guardar')),
          ],
        ),
      );

      if (created != true || ejercicioId == null) return;

      final tipoMetrica = metricaController.value;
      await _service.asignarEjercicioARutina(
        rutinaId: rutinaId,
        ejercicioId: ejercicioId!,
        orden: int.tryParse(ordenController.text.trim()) ?? 1,
        series: int.tryParse(seriesController.text.trim()) ?? 1,
        tipoMetrica: tipoMetrica,
        repeticiones: tipoMetrica == 'repeticiones' ? int.tryParse(repeticionesController.text.trim()) : null,
        duracionSeg: tipoMetrica == 'tiempo' ? int.tryParse(duracionController.text.trim()) : null,
        pesoKg: int.tryParse(pesoController.text.trim()),
        descansoSeg: int.tryParse(descansoController.text.trim()),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ejercicio asignado')));
      await _refresh();
    } finally {
      ordenController.dispose();
      seriesController.dispose();
      repeticionesController.dispose();
      duracionController.dispose();
      pesoController.dispose();
      descansoController.dispose();
      metricaController.dispose();
    }
  }

  Future<void> _editarEjecucion(RutinaEjercicioModel ejercicio) async {
    final ordenController = TextEditingController(text: ejercicio.orden.toString());
    final seriesController = TextEditingController(text: ejercicio.series.toString());
    final repeticionesController = TextEditingController(text: ejercicio.repeticiones?.toString() ?? '');
    final duracionController = TextEditingController(text: ejercicio.duracionSeg?.toString() ?? '');
    final pesoController = TextEditingController(text: ejercicio.pesoKg?.toString() ?? '');
    final descansoController = TextEditingController(text: ejercicio.descansoSeg?.toString() ?? '');

    try {
      final updated = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Editar ${ejercicio.nombre}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: ordenController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Orden')),
                TextField(controller: seriesController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Series')),
                TextField(controller: repeticionesController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Repeticiones')),
                TextField(controller: duracionController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Duracion seg')),
                TextField(controller: pesoController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Peso kg')),
                TextField(controller: descansoController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Descanso seg')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Guardar')),
          ],
        ),
      );

      if (updated != true) return;

      await _service.modificarEjecucion(
        ejecucionId: ejercicio.ejecucionId,
        orden: int.tryParse(ordenController.text.trim()),
        series: int.tryParse(seriesController.text.trim()),
        repeticiones: int.tryParse(repeticionesController.text.trim()),
        duracionSeg: int.tryParse(duracionController.text.trim()),
        pesoKg: int.tryParse(pesoController.text.trim()),
        descansoSeg: int.tryParse(descansoController.text.trim()),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ejercicio modificado')));
      await _refresh();
    } finally {
      ordenController.dispose();
      seriesController.dispose();
      repeticionesController.dispose();
      duracionController.dispose();
      pesoController.dispose();
      descansoController.dispose();
    }
  }

  Future<void> _eliminarEjecucion(int ejecucionId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar ejercicio'),
        content: const Text('Esta accion no se puede deshacer.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
        ],
      ),
    );

    if (confirm != true) return;

    await _service.eliminarEjecucion(ejecucionId);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ejercicio eliminado')));
    await _refresh();
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
                        final error = snapshot.error.toString().toLowerCase();
                        final noRutina = error.contains('no tiene rutina');
                        if (noRutina) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Este cliente no tiene rutina activa', style: TextStyle(color: Colors.white)),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E)),
                                  onPressed: _crearRutina,
                                  child: const Text('Crear rutina', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                          );
                        }
                        return Center(child: Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white)));
                      }

                      final rutina = snapshot.data;
                      if (rutina == null) {
                        return const Center(child: Text('No se pudo cargar la rutina', style: TextStyle(color: Colors.white)));
                      }

                      if (rutina.ejercicios.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Rutina creada sin ejercicios', style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E)),
                                onPressed: () => _agregarEjercicio(rutina.id),
                                child: const Text('Asignar primer ejercicio', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.separated(
                        itemCount: rutina.ejercicios.length + 1,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) {
                          if (i == 0) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${rutina.ejercicios.length} ejercicio(s) asignado(s)', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E)),
                                  onPressed: () => _agregarEjercicio(rutina.id),
                                  child: const Text('Agregar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                                ),
                              ],
                            );
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
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E)),
                                        onPressed: () => _editarEjecucion(ejercicio),
                                        child: const Text('Modificar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                                        onPressed: () => _eliminarEjecucion(ejercicio.ejecucionId),
                                        child: const Text('Eliminar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
      floatingActionButton: widget.clienteId == null
          ? null
          : FloatingActionButton(
              onPressed: _crearRutina,
              backgroundColor: Colors.white,
              child: const Icon(Icons.fitness_center, color: Colors.black),
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
