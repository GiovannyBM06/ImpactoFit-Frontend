import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/bienvenida_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/recuperar_password_screen.dart';
import 'screens/cliente/home_screen.dart';
import 'screens/cliente/asistencia_screen.dart';
import 'screens/cliente/rutina_screen.dart';
import 'screens/cliente/clase_grupal_screen.dart';
import 'screens/entrenador/home_screen.dart';
import 'screens/entrenador/clientes_screen.dart';
import 'screens/entrenador/rutina_screen.dart';
import 'screens/entrenador/ejercicios_screen.dart';
import 'screens/admin/home_screen.dart';
import 'screens/admin/clientes_screen.dart';
import 'screens/admin/asignaciones_screen.dart';
import 'screens/admin/crear_entrenador_screen.dart';
import 'screens/admin/crear_clase_screen.dart';
import 'screens/admin/membresia_screen.dart';
import 'screens/admin/clases_screen.dart';
import 'screens/admin/usuarios_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'ImpactoFit',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFFB84E),
            brightness: Brightness.dark,
          ),
          fontFamily: 'Instrument Sans',
        ),
        home: const _RootScreen(),
        routes: _buildRoutes(),
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }

  /// Rutas estáticas de la aplicación
  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      // ── Auth ───────────────────────────────────────────────────────────────
      '/login': (_) => const LoginScreen(),
      '/recuperar-password': (_) => const RecuperarPasswordScreen(),

      // ── Cliente ────────────────────────────────────────────────────────────
      '/cliente/home': (_) => const ClienteHomeScreen(),
      '/cliente/asistencia': (_) => const AsistenciaScreen(),
      '/cliente/mi_rutina': (_) => const MiRutinaScreen(),
      '/cliente/clases': (_) => const ClienteClaseGrupalScreen(),

      // ── Entrenador ─────────────────────────────────────────────────────────
      '/entrenador/home': (_) => const EntrenadorHomeScreen(),
      '/entrenador/clientes': (_) => const ClientesEntrenadorScreen(),
      '/entrenador/rutina': (_) => const EntrenadorRutinaScreen(),
      '/entrenador/ejercicios': (_) => const EntrenadorEjerciciosScreen(),

      // ── Admin ──────────────────────────────────────────────────────────────
      '/admin/home': (_) => const AdminHomeScreen(),
      '/admin/clientes': (_) => const AdminClientesScreen(),
      '/admin/asignaciones': (_) => const AdminAsignacionesScreen(),
      '/admin/crear_entrenador': (_) => const AdminCrearEntrenadorScreen(),
      '/admin/crear_clase': (_) => const AdminCrearClaseScreen(),
      '/admin/membresias': (_) => const AdminMembresiasScreen(),
      '/admin/clases': (_) => const AdminClasesScreen(),
      '/admin/usuarios': (_) => const AdminUsuariosScreen(),
    };
  }

  /// Manejador de rutas con parámetros (ej: /entrenador/rutina?clienteId=123)
  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    // Aquí se pueden manejar rutas dinámicas con parámetros
    // Ej: /entrenador/clientes/{clienteId}/rutina
    return null; // Las rutas estáticas se manejan en _buildRoutes()
  }
}

/// Pantalla raíz que decide qué mostrar según el estado de autenticación
class _RootScreen extends StatefulWidget {
  const _RootScreen({Key? key}) : super(key: key);

  @override
  State<_RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<_RootScreen> {
  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  /// Inicializar autenticación al arrancar la app
  Future<void> _initializeAuth() async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        // Si está cargando, mostrar splash
        if (authProvider.isLoading && !authProvider.isAuthenticated) {
          return const _SplashScreen();
        }

        // Si está autenticado, navegar según su rol
        if (authProvider.isAuthenticated) {
          final rol = authProvider.rol;

          // Navegar a home según el rol
          Future.microtask(() {
            switch (rol) {
              case 'Cliente':
                Navigator.of(context).pushReplacementNamed('/cliente/home');
                break;
              case 'Entrenador':
                Navigator.of(context).pushReplacementNamed('/entrenador/home');
                break;
              case 'Administrador':
              case 'Admin':
                Navigator.of(context).pushReplacementNamed('/admin/home');
                break;
              default:
                Navigator.of(context).pushReplacementNamed('/login');
            }
          });

          return const _LoadingScreen();
        }

        // Si no está autenticado, mostrar bienvenida
        return const BienvenidaScreen();
      },
    );
  }
}

/// Pantalla de splash inicial
class _SplashScreen extends StatelessWidget {
  const _SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262525),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Impacto Fit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(
              color: Color(0xFFFFB84E),
            ),
            const SizedBox(height: 24),
            Text(
              'Conectando...',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pantalla de carga durante navegación
class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF262525),
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xFFFFB84E),
        ),
      ),
    );
  }
}
