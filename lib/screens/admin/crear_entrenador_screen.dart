import 'package:flutter/material.dart';

import '../../services/admin_service.dart';

class AdminCrearEntrenadorScreen extends StatefulWidget {
  const AdminCrearEntrenadorScreen({Key? key}) : super(key: key);

  @override
  State<AdminCrearEntrenadorScreen> createState() => _AdminCrearEntrenadorScreenState();
}

class _AdminCrearEntrenadorScreenState extends State<AdminCrearEntrenadorScreen> {
  final _service = AdminService();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telefonoController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  Future<void> _crearEntrenador() async {
    setState(() => _saving = true);
    try {
      await _service.crearUsuario(
        nombre: _nombreController.text.trim(),
        apellido: _apellidoController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        rol: 'entrenador',
        telefono: _telefonoController.text.trim().isEmpty ? null : _telefonoController.text.trim(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Entrenador creado')));
      Navigator.of(context).pop();
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
              const Text('Registrar', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
              const Text('Entrenador', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nombre', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(controller: _nombreController, decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: true, fillColor: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Apellido', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(controller: _apellidoController, decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: true, fillColor: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Email', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: true, fillColor: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Contraseña', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: true, fillColor: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Teléfono', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(controller: _telefonoController, decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: true, fillColor: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(999)),
                        child: IconButton(
                          onPressed: _saving ? null : _crearEntrenador,
                          icon: Text(_saving ? 'Guardando...' : 'Crear', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(child: Text('Crear Entrenador', style: TextStyle(color: Colors.white, fontSize: 14))),
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
