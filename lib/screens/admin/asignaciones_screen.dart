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
  late Future<void> _futureData;
  List<UsuarioModel> _clientes = const [];
  List<UsuarioModel> _entrenadores = const [];
  UsuarioModel? _clienteSeleccionado;
  UsuarioModel? _entrenadorSeleccionado;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _futureData = _loadData();
  }

  Future<void> _loadData() async {
    final clientes = await _service.obtenerClientes();
    final entrenadores = await _service.obtenerEntrenadores();
    _clientes = clientes;
    _entrenadores = entrenadores;

    if (_clientes.isNotEmpty) {
      _clienteSeleccionado ??= _clientes.first;
    }
    if (_entrenadores.isNotEmpty) {
      _entrenadorSeleccionado ??= _entrenadores.first;
    }
  }

  Future<void> _refresh() async {
    await _loadData();
    if (mounted) setState(() {});
  }

  Future<void> _asignar() async {
    if (_clienteSeleccionado == null || _entrenadorSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecciona cliente y entrenador')));
      return;
    }

    setState(() => _saving = true);
    try {
      final result = await _service.asignarEntrenadorACliente(
        clienteId: _clienteSeleccionado!.id,
        entrenadorId: _entrenadorSeleccionado!.id,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['mensaje']?.toString() ?? 'Entrenador asignado')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _desvincular() async {
    if (_clienteSeleccionado == null || _entrenadorSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecciona cliente y entrenador')));
      return;
    }

    setState(() => _saving = true);
    try {
      final result = await _service.desvincularEntrenadorDeCliente(
        clienteId: _clienteSeleccionado!.id,
        entrenadorId: _entrenadorSeleccionado!.id,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['mensaje']?.toString() ?? 'Entrenador desvinculado')));
    } finally {
      if (mounted) setState(() => _saving = false);
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Asignaciones', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Expanded(
                child: FutureBuilder<void>(
                  future: _futureData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB84E)));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white)));
                    }

                    if (_clientes.isEmpty || _entrenadores.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView(
                          children: const [
                            SizedBox(height: 120),
                            Center(child: Text('Debes tener clientes y entrenadores creados', style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Selecciona cliente', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<UsuarioModel>(
                                  value: _clienteSeleccionado,
                                  items: _clientes
                                      .map((cliente) => DropdownMenuItem<UsuarioModel>(
                                            value: cliente,
                                            child: Text('${cliente.fullName} (#${cliente.id})'),
                                          ))
                                      .toList(),
                                  onChanged: (value) => setState(() => _clienteSeleccionado = value),
                                  decoration: const InputDecoration(border: OutlineInputBorder()),
                                ),
                                const SizedBox(height: 16),
                                const Text('Selecciona entrenador', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<UsuarioModel>(
                                  value: _entrenadorSeleccionado,
                                  items: _entrenadores
                                      .map((entrenador) => DropdownMenuItem<UsuarioModel>(
                                            value: entrenador,
                                            child: Text('${entrenador.fullName} (#${entrenador.id})'),
                                          ))
                                      .toList(),
                                  onChanged: (value) => setState(() => _entrenadorSeleccionado = value),
                                  decoration: const InputDecoration(border: OutlineInputBorder()),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E)),
                                        onPressed: _saving ? null : _asignar,
                                        child: const Text('Asignar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                                        onPressed: _saving ? null : _desvincular,
                                        child: const Text('Desvincular', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text('Entrenadores disponibles', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                          const SizedBox(height: 12),
                          ..._entrenadores.map((entrenador) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _AdminEntrenadorCard(entrenador: entrenador),
                              )),
                        ],
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
