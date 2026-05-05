import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import 'clientes_screen.dart';

class EntrenadorHomeScreen extends StatelessWidget {
  const EntrenadorHomeScreen({Key? key}) : super(key: key);

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
              const SizedBox(height: 8),
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Bienvenido ${authProvider.nombre ?? 'Entrenador'}',
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const CircleAvatar(radius: 26, backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.black)),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              // Ver clientes asignados card
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/entrenador/clientes'),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: AssetImage('assets/images/trainer_group.jpg'), fit: BoxFit.cover)),
                  height: 200,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black.withOpacity(0.4)),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text('Ver Clientes asignados', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(50)),
                                    child: const Text('Ver', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.chevron_right, color: Colors.white),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar Cliente ...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 24),
              // Opciones de Rutina
              const Text('Opciones de Rutina', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(image: AssetImage('assets/images/create_routine.jpg'), fit: BoxFit.cover),
                        ),
                        child: Stack(
                          children: [
                            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black.withOpacity(0.4))),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Crear una rutina', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(50)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [Text('Crear', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 13)), SizedBox(width: 6), Icon(Icons.add, color: Colors.black, size: 16)],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(image: AssetImage('assets/images/modify_routine.jpg'), fit: BoxFit.cover),
                        ),
                        child: Stack(
                          children: [
                            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black.withOpacity(0.4))),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Modificar una rutina', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(50)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [Text('Mod.', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 13)), SizedBox(width: 6), Icon(Icons.edit, color: Colors.black, size: 16)],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
