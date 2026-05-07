import 'package:flutter/material.dart';

import '../../models/usuario.dart';
import '../../services/admin_service.dart';

class AdminCrearClaseScreen extends StatefulWidget {
  const AdminCrearClaseScreen({Key? key}) : super(key: key);

  @override
  State<AdminCrearClaseScreen> createState() => _AdminCrearClaseScreenState();
}

class _AdminCrearClaseScreenState extends State<AdminCrearClaseScreen> {
  final _service = AdminService();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _fechaController = TextEditingController();
  final _horaController = TextEditingController();
  final _cuposController = TextEditingController();
  late Future<List<UsuarioModel>> _futureEntrenadores;
  UsuarioModel? _selectedEntrenador;

  @override
  void initState() {
    super.initState();
    _futureEntrenadores = _service.obtenerEntrenadores();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _fechaController.dispose();
    _horaController.dispose();
    _cuposController.dispose();
    super.dispose();
  }

  Future<void> _crearClase() async {
    if (_selectedEntrenador == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecciona un entrenador')));
      return;
    }

    final cupos = int.tryParse(_cuposController.text.trim());
    if (cupos == null || cupos <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ingresa un número de cupos válido')));
      return;
    }

    final fecha = _fechaController.text.trim();
    final hora = _horaController.text.trim();
    if (fecha.isEmpty || hora.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ingresa fecha y hora')));
      return;
    }

    final fechaHora = '${fecha}T${hora}';
    await _service.crearClaseGrupal(
      entrenadorId: _selectedEntrenador!.id,
      nombre: _nombreController.text.trim(),
      fechaHora: fechaHora,
      cupoMaximo: cupos,
      descripcion: _descripcionController.text.trim().isEmpty ? null : _descripcionController.text.trim(),
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Clase grupal programada')));
    Navigator.of(context).pop();
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
                ],
              ),
              const SizedBox(height: 8),
              const Text('Programar', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
              const Text('Clase Grupal', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    FutureBuilder<List<UsuarioModel>>(
                      future: _futureEntrenadores,
                      builder: (context, snapshot) {
                        final entrenadores = snapshot.data ?? [];
                        return Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Asignar Entrenador', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 12),
                              if (snapshot.connectionState == ConnectionState.waiting)
                                const LinearProgressIndicator(),
                              DropdownButtonFormField<UsuarioModel>(
                                initialValue: _selectedEntrenador,
                                items: entrenadores.map((entrenador) => DropdownMenuItem(value: entrenador, child: Text(entrenador.fullName))).toList(),
                                onChanged: (value) => setState(() => _selectedEntrenador = value),
                                decoration: const InputDecoration(labelText: 'Entrenador'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nombre:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(controller: _nombreController, decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: true, fillColor: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Descripción:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(controller: _descripcionController, decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: true, fillColor: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Fecha:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(controller: _fechaController, decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: true, fillColor: Colors.white, hintText: 'YYYY-MM-DD')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Hora:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(controller: _horaController, decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: true, fillColor: Colors.white, hintText: 'HH:MM:SS')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Cupos:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(controller: _cuposController, keyboardType: TextInputType.number, decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: true, fillColor: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Container(
                      height: 62,
                      decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        onPressed: _crearClase,
                        child: const Text('Programar', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
