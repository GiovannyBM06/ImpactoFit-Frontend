/// Constantes globales de la aplicación
/// 
/// Define URLs, timeouts, y configuraciones que se usan en toda la app

// ── Backend ──────────────────────────────────────────────────────────────────
// En desarrollo: http://10.0.2.2:8000 (acceso a localhost desde emulador Android)
// En dispositivo real: http://tu-ip-local:8000 o https://api.impactofit.com
const String BACKEND_URL = 'http://10.0.2.2:8000';

// ── Endpoints Auth ───────────────────────────────────────────────────────────
const String LOGIN_ENDPOINT = '/auth/login';
const String LOGOUT_ENDPOINT = '/auth/logout';
const String RECUPERAR_PASSWORD_ENDPOINT = '/auth/recuperar-password';
const String RESETEAR_PASSWORD_ENDPOINT = '/auth/resetear-password';

// ── Endpoints Cliente ────────────────────────────────────────────────────────
const String CLIENTE_RUTINA_ENDPOINT = '/cliente/rutina';
const String CLIENTE_ASISTENCIA_ENDPOINT = '/cliente/asistencia';
const String CLIENTE_CLASES_ENDPOINT = '/cliente/clases';
const String CLIENTE_INSCRIBIR_CLASE_ENDPOINT = '/cliente/clases/{claseId}/inscribir';
const String CLIENTE_CANCELAR_CLASE_ENDPOINT = '/cliente/clases/{claseId}/cancelar';

// ── Endpoints Entrenador ─────────────────────────────────────────────────────
const String ENTRENADOR_CLIENTES_ENDPOINT = '/entrenador/clientes';
const String ENTRENADOR_RUTINA_ENDPOINT = '/entrenador/clientes/{clienteId}/rutina';
const String ENTRENADOR_EJERCICIOS_ENDPOINT = '/entrenador/ejercicios';
const String ENTRENADOR_CREAR_EJERCICIO_ENDPOINT = '/entrenador/ejercicios';
const String ENTRENADOR_EDITAR_EJERCICIO_ENDPOINT = '/entrenador/ejercicios/{ejercicioId}';
const String ENTRENADOR_ELIMINAR_EJERCICIO_ENDPOINT = '/entrenador/ejercicios/{ejercicioId}';

// ── Endpoints Admin ──────────────────────────────────────────────────────────
const String ADMIN_CLIENTES_ENDPOINT = '/admin/clientes';
const String ADMIN_ENTRENADORES_ENDPOINT = '/admin/entrenadores';
const String ADMIN_MEMBRESIAS_ENDPOINT = '/admin/membresias';
const String ADMIN_CLASES_ENDPOINT = '/admin/clases';
const String ADMIN_CREAR_CLASE_ENDPOINT = '/admin/clases';
const String ADMIN_USUARIOS_ENDPOINT = '/admin/usuarios';
const String ADMIN_CREAR_ENTRENADOR_ENDPOINT = '/admin/entrenadores';

// ── Timeouts ─────────────────────────────────────────────────────────────────
const Duration HTTP_TIMEOUT = Duration(seconds: 30);
const Duration STORAGE_TIMEOUT = Duration(seconds: 5);

// ── Storage Keys ─────────────────────────────────────────────────────────────
const String TOKEN_KEY = 'access_token';
const String REFRESH_TOKEN_KEY = 'refresh_token';
const String USUARIO_ID_KEY = 'usuario_id';
const String ROL_KEY = 'rol';
const String NOMBRE_KEY = 'nombre';
const String EMAIL_KEY = 'email';
