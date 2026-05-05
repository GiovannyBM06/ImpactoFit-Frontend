import 'package:flutter/material.dart';

import '../../models/usuario.dart';
import '../../services/admin_service.dart';

class AdminUsuariosScreen extends StatefulWidget {
  const AdminUsuariosScreen({Key? key}) : super(key: key);

  @override
  State<AdminUsuariosScreen> createState() => _AdminUsuariosScreenState();
}

class _AdminUsuariosScreenState extends State<AdminUsuariosScreen> {
  final _service = AdminService();
  late Future<List<UsuarioModel>> _futureUsuarios;

  @override
  void initState() {
    super.initState();
    _futureUsuarios = _service.obtenerUsuarios();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureUsuarios = _service.obtenerUsuarios();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Usuarios', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Expanded(
                child: FutureBuilder<List<UsuarioModel>>(
                  future: _futureUsuarios,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB84E)));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white)));
                    }

                    final usuarios = snapshot.data ?? [];
                    if (usuarios.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView(
                          children: const [
                            SizedBox(height: 120),
                            Center(child: Text('No hay usuarios', style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.separated(
                        itemCount: usuarios.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) => _UsuarioCard(usuario: usuarios[i]),
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

class _UsuarioCard extends StatelessWidget {
  final UsuarioModel usuario;

  const _UsuarioCard({required this.usuario});

  @override
  Widget build(BuildContext context) {
    final esCliente = usuario.rol.toLowerCase() == 'cliente';
    return Container(
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
                    Text(usuario.fullName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    Text(usuario.email, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: esCliente ? const Color(0xFFFFB84E) : const Color(0xFFFF8D28),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(usuario.rol, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
              )
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.black, height: 1),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Estado', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: usuario.isActive ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(usuario.isActive ? 'Activo' : 'Inactivo', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: usuario.isActive ? Colors.green : Colors.red)),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Fecha Registro', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(usuario.createdAt.toIso8601String().split('T').first, style: const TextStyle(fontSize: 14, color: Colors.grey))
                ],
              ),
            ],
          ),
          if (esCliente) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Rol: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
                  child: Text(usuario.rol, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                )
              ],
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E)),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ver detalles de ${usuario.fullName}'))),
                  child: const Text('Ver', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Editar ${usuario.fullName}'))),
                  child: const Text('Editar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
