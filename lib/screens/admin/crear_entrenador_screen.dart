import 'package:flutter/material.dart';

class AdminCrearEntrenadorScreen extends StatefulWidget {
  const AdminCrearEntrenadorScreen({Key? key}) : super(key: key);

  @override
  State<AdminCrearEntrenadorScreen> createState() => _AdminCrearEntrenadorScreenState();
}

class _AdminCrearEntrenadorScreenState extends State<AdminCrearEntrenadorScreen> {
  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _experienciaController = TextEditingController();
  bool hombre = true;
  String experiencia = 'Principiante';

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _experienciaController.dispose();
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
              const Text('Registrar', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
              const Text('Entrenador', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
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
                          const Text('Imagen Entrenador', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            height: 138,
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                            child: Icon(Icons.person, size: 80, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Nombre
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Nombre:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _nombreController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Apellidos
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Apellidos:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _apellidosController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Sexo
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Sexo:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Checkbox(
                                value: hombre,
                                onChanged: (v) => setState(() => hombre = v ?? true),
                              ),
                              const SizedBox(width: 4),
                              const Text('Hombre', style: TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700, fontSize: 20)),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: !hombre,
                                onChanged: (v) => setState(() => hombre = !(v ?? false)),
                              ),
                              const SizedBox(width: 4),
                              const Text('Mujer', style: TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700, fontSize: 20)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Experiencia
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Experiencia', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                          const SizedBox(height: 8),
                          Column(
                            children: ['Principiante', 'Intermedio', 'Avanzado'].map((exp) {
                              return Row(
                                children: [
                                  Checkbox(
                                    value: experiencia == exp,
                                    onChanged: (v) => setState(() => experiencia = exp),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(exp, style: const TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700, fontSize: 20)),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Create button
                    Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: IconButton(onPressed: () {}, icon: const Icon(Icons.add, color: Colors.black, size: 32)),
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
