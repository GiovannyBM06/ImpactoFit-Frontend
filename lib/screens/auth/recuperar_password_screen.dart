import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class RecuperarPasswordScreen extends StatefulWidget {
  const RecuperarPasswordScreen({Key? key}) : super(key: key);

  @override
  State<RecuperarPasswordScreen> createState() => _RecuperarPasswordScreenState();
}

class _RecuperarPasswordScreenState extends State<RecuperarPasswordScreen> {
  final _emailController = TextEditingController();
  bool codigoEnviado = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  /// Solicitar código de recuperación
  Future<void> _handleSolicitar() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa tu correo')),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.recuperarPassword(
      email: _emailController.text,
    );

    if (success) {
      setState(() => codigoEnviado = true);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Código enviado a tu correo')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProvider.errorMessage ?? 'Error')),
        );
      }
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
              const SizedBox(height: 24),
              const Text('Recuperar', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const Text('Contraseña', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Ingresa tu correo electrónico', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 16),
                          const Text('Correo:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'ejemplo@correo.com',
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (codigoEnviado)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(8)),
                              child: const Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text('Código enviado a tu correo', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700)),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, _) {
                        return Container(
                          height: 62,
                          decoration: BoxDecoration(color: const Color(0xFFFFB84E), borderRadius: BorderRadius.circular(15)),
                          child: MaterialButton(
                            onPressed: authProvider.isLoading ? null : _handleSolicitar,
                            child: Text(
                              authProvider.isLoading ? 'Enviando...' : 'Enviar Código',
                              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Text('Volver al login', style: TextStyle(color: Color(0xFFFFB84E), fontSize: 16, fontWeight: FontWeight.w700)),
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
