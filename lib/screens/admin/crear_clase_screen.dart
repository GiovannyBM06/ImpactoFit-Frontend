import 'package:flutter/material.dart';

class AdminCrearClaseScreen extends StatefulWidget {
  const AdminCrearClaseScreen({Key? key}) : super(key: key);

  @override
  State<AdminCrearClaseScreen> createState() => _AdminCrearClaseScreenState();
}

class _AdminCrearClaseScreenState extends State<AdminCrearClaseScreen> {
  final _fechaController = TextEditingController();
  final _horaController = TextEditingController();
  final _cuposController = TextEditingController();
  List<String> entrenadores = [];

  @override
  void dispose() {
    _fechaController.dispose();
    _horaController.dispose();
    _cuposController.dispose();
    super.dispose();
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
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Asignar Entrenador(es)', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            height: 138,
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                            child: Icon(Icons.person, size: 80, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add, size: 32, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Fecha
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Fecha:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _fechaController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'DD/MM/YYYY',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Hora
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Hora:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _horaController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'HH:MM',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Cupos
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Cupos:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _cuposController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Número de cupos',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Programar button
                    Container(
                      height: 62,
                      decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Clase grupal programada')));
                          Navigator.of(context).pop();
                        },
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
