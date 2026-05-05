import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ClienteHomeScreen extends StatelessWidget {
  const ClienteHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262525),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                          'Bienvenido ${authProvider.nombre ?? 'Cliente'}',
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const CircleAvatar(radius: 26, backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.black)),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text('¿Qué deseas hacer?', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView(
                  children: [
                    _ActionCard(
                      title: 'Nivel de uso de máquinas',
                      buttonText: 'Ver',
                      image: 'assets/images/machines.jpg',
                      onTap: () {},
                    ),
                    const SizedBox(height: 18),
                    _ActionCard(
                      title: 'Diligenciar asistencia',
                      buttonText: 'Diligenciar',
                      image: 'assets/images/attendance.jpg',
                      onTap: () => Navigator.of(context).pushNamed('/cliente/asistencia'),
                    ),
                    const SizedBox(height: 18),
                    _ActionCard(
                      title: 'Ver mi rutina',
                      buttonText: 'Ir',
                      image: 'assets/images/routine.jpg',
                      onTap: () => Navigator.of(context).pushNamed('/cliente/mi_rutina'),
                    ),
                    const SizedBox(height: 30),
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

class _ActionCard extends StatelessWidget {
  final String title;
  final String buttonText;
  final String image;
  final VoidCallback? onTap;

  const _ActionCard({required this.title, required this.buttonText, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.45),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(50)),
                        child: Text(buttonText, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
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
    );
  }
}
