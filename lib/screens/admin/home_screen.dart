import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

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
              Row(
                children: [
                  const Expanded(
                    child: Text('Bienvenido Admin A', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                  ),
                  CircleAvatar(radius: 26, backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.black)),
                ],
              ),
              const SizedBox(height: 24),
              // Registrar nuevo entrenador
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/admin/crear_entrenador'),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: AssetImage('assets/images/trainer.jpg'), fit: BoxFit.cover)),
                  height: 150,
                  child: Stack(
                    children: [
                      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black.withOpacity(0.4))),
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Registrar nuevo entrenador', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 8),
                            Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(50)), child: const Text('Registrar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Registrar nuevo cliente
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/admin/crear_cliente'),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: AssetImage('assets/images/clients.jpg'), fit: BoxFit.cover)),
                  height: 150,
                  child: Stack(
                    children: [
                      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black.withOpacity(0.4))),
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Registrar nuevo cliente', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 8),
                            Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(50)), child: const Text('Registrar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Más', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24)),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  children: [
                    _AdminMenuCard(
                      icon: Icons.assignment,
                      label: 'Asistencia',
                      subtitle: 'General',
                      onTap: () => Navigator.of(context).pushNamed('/admin/asistencia'),
                    ),
                    const SizedBox(height: 8),
                    _AdminMenuCard(
                      icon: Icons.people,
                      label: 'Ver Clientes',
                      onTap: () => Navigator.of(context).pushNamed('/admin/clientes'),
                    ),
                    const SizedBox(height: 8),
                    _AdminMenuCard(
                      icon: Icons.group_work,
                      label: 'Crear Clase Grupal',
                      onTap: () => Navigator.of(context).pushNamed('/admin/crear_clase'),
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

class _AdminMenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;

  const _AdminMenuCard({required this.icon, required this.label, this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: AssetImage('assets/images/admin_menu.jpg'), fit: BoxFit.cover)),
        height: 75,
        child: Stack(
          children: [
            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black.withOpacity(0.4))),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(label, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                    if (subtitle != null) Text(subtitle!, style: const TextStyle(color: Colors.white70, fontSize: 12))
                  ],
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(50)),
                  child: const Icon(Icons.chevron_right, color: Colors.black, size: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
