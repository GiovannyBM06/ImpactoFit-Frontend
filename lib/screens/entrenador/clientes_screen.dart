import 'package:flutter/material.dart';

import '../../models/usuario.dart';
import '../../services/entrenador_service.dart';
import 'rutina_screen.dart';

class ClientesEntrenadorScreen extends StatefulWidget {
  const ClientesEntrenadorScreen({Key? key}) : super(key: key);

  @override
  State<ClientesEntrenadorScreen> createState() => _ClientesEntrenadorScreenState();
}

class _ClientesEntrenadorScreenState extends State<ClientesEntrenadorScreen> {
  final _service = EntrenadorService();
  late Future<List<UsuarioModel>> _futureClientes;

  @override
  void initState() {
    super.initState();
    _futureClientes = _service.obtenerClientes();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureClientes = _service.obtenerClientes();
    });
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
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Clientes', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Expanded(
                child: FutureBuilder<List<UsuarioModel>>(
                  future: _futureClientes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB84E)));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white)));
                    }

                    final clientes = snapshot.data ?? [];
                    if (clientes.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView(
                          children: const [
                            SizedBox(height: 120),
                            Center(child: Text('No tienes clientes asignados', style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.separated(
                        itemCount: clientes.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) {
                          final cliente = clientes[i];
                          return ClienteCard(
                            cliente: cliente,
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => EntrenadorRutinaScreen(clienteId: cliente.id, clienteNombre: cliente.fullName),
                            )),
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ClienteCard extends StatelessWidget {
  final UsuarioModel cliente;
  final VoidCallback onTap;

  const ClienteCard({required this.cliente, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 22, backgroundColor: Colors.grey[300]),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cliente.fullName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black)),
                      Text(cliente.email, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFFF8D28))),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.black),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.black, height: 1),
            const SizedBox(height: 8),
            const Text('Acceso rapido', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
            const SizedBox(height: 8),
            Center(
              child: TextButton(onPressed: onTap, child: const Text('Ver rutina', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))),
            )
          ],
        ),
      ),
    );
  }
}
