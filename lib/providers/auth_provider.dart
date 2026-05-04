import 'package:flutter/material.dart';
import '../services/auth_service.dart';

/// Proveedor de estado de autenticación
/// 
/// Maneja:
/// - Estado de login/logout
/// - Almacenamiento de datos del usuario
/// - Información de sesión
class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  // ── Estado ─────────────────────────────────────────────────────────────────
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _usuarioId;
  String? _rol;
  String? _nombre;
  String? _email;

  // ── Getters ────────────────────────────────────────────────────────────────
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get usuarioId => _usuarioId;
  String? get rol => _rol;
  String? get nombre => _nombre;
  String? get email => _email;

  // ── Acciones ───────────────────────────────────────────────────────────────

  /// Inicializar el proveedor - verificar si hay sesión activa
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      final isAuth = await _authService.isAuthenticated();
      if (isAuth) {
        final userData = await _authService.getUserData();
        _isAuthenticated = true;
        _usuarioId = userData['usuarioId'];
        _rol = userData['rol'];
        _nombre = userData['nombre'];
        _email = userData['email'];
      } else {
        _isAuthenticated = false;
      }
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Error al verificar sesión: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Iniciar sesión
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.login(
        email: email,
        password: password,
      );

      _isAuthenticated = true;
      _usuarioId = response['usuarioId'].toString();
      _rol = response['rol'];
      _nombre = response['nombre'];
      _email = email;
      _errorMessage = null;

      return true;
    } catch (e) {
      _isAuthenticated = false;
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Cerrar sesión
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.logout();
      _isAuthenticated = false;
      _usuarioId = null;
      _rol = null;
      _nombre = null;
      _email = null;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Error al cerrar sesión: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Solicitar recuperación de contraseña
  Future<bool> recuperarPassword({required String email}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.recuperarPassword(email: email);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Resetear contraseña
  Future<bool> resetearPassword({
    required String token,
    required String nuevaPassword,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.resetearPassword(
        token: token,
        nuevaPassword: nuevaPassword,
      );
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Limpiar mensaje de error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
