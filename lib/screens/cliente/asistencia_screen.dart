import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/asistencia_service.dart';

class AsistenciaScreen extends StatefulWidget {
  const AsistenciaScreen({Key? key}) : super(key: key);

  @override
  State<AsistenciaScreen> createState() => _AsistenciaScreenState();
}

class _AsistenciaScreenState extends State<AsistenciaScreen> {
  final TextEditingController _observacionesController = TextEditingController();
  final _service = AsistenciaService();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _observacionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262525),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                  const SizedBox(width: 8),
                  const Text('Volver', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24)),
                ],
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 8),
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  return Text(
                    'Usuario: ${authProvider.nombre ?? 'Cliente'}',
                    style: const TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700, fontSize: 24),
                  );
                },
              ),
              const SizedBox(height: 18),
              const Text('Observaciones', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24)),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 140),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: TextField(
                  controller: _observacionesController,
                  maxLines: 5,
                  decoration: const InputDecoration(border: InputBorder.none, hintText: 'Escribe una observación opcional'),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200))),
                  onPressed: _isSubmitting
                      ? null
                      : () async {
                          setState(() => _isSubmitting = true);
                          try {
                            await _service.registrarAsistencia(observaciones: _observacionesController.text.trim().isEmpty ? null : _observacionesController.text.trim());
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Asistencia enviada')));
                            Navigator.of(context).pop();
                          } finally {
                            if (mounted) setState(() => _isSubmitting = false);
                          }
                        },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_isSubmitting ? 'Enviando...' : 'Enviar', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18)),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
