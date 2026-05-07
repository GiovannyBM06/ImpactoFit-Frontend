import 'package:flutter/material.dart';

import '../../services/admin_service.dart';

class AdminCrearClienteScreen extends StatefulWidget {
  const AdminCrearClienteScreen({Key? key}) : super(key: key);

  @override
  State<AdminCrearClienteScreen> createState() => _AdminCrearClienteScreenState();
}

class _AdminCrearClienteScreenState extends State<AdminCrearClienteScreen> {
  final _service = AdminService();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telefonoController = TextEditingController();
  String _rolSeleccionado = 'cliente';
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

  Future<void> _crearCliente() async {
    if (_nombreController.text.trim().isEmpty || _apellidoController.text.trim().isEmpty || _emailController.text.trim().isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Completa los campos obligatorios')));
      return;
    }

    setState(() => _saving = true);
    try {
      await _service.crearUsuario(
        nombre: _nombreController.text.trim(),
        apellido: _apellidoController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        rol: _rolSeleccionado,
        telefono: _telefonoController.text.trim().isEmpty ? null : _telefonoController.text.trim(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Usuario creado')));
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
              const Text('Usuario', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Rol', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          initialValue: _rolSeleccionado,
                          dropdownColor: Colors.white,
                          items: const [
                            DropdownMenuItem(value: 'cliente', child: Text('cliente')),
                            DropdownMenuItem(value: 'entrenador', child: Text('entrenador')),
                            DropdownMenuItem(value: 'administrador', child: Text('administrador')),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _rolSeleccionado = value);
                            }
                          },
                          decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: true, fillColor: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
                        const Text('Contrasena', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: true, fillColor: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Telefono', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
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
                          onPressed: _saving ? null : _crearCliente,
                          icon: Text(_saving ? 'Guardando...' : 'Crear', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),
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
