# ImpactoFit - Frontend Flutter

Aplicación móvil de fitness y entrenamiento personalizado.

## 📱 Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada
├── core/
│   ├── api_client.dart         # Cliente HTTP
│   ├── constants.dart          # Constantes (URLs, endpoints)
│   └── secure_storage.dart     # Almacenamiento seguro de tokens
├── models/                      # Modelos de datos
├── services/                    # Servicios (auth, etc)
├── providers/                   # State management (Provider)
└── screens/                     # Interfaces de usuario
    ├── auth/                   # Autenticación
    ├── cliente/                # Módulo Cliente
    ├── entrenador/             # Módulo Entrenador
    └── admin/                  # Módulo Admin
```

## 🚀 Requisitos

- Flutter 3.0+
- Dart 3.0+
- Android SDK 21+ o iOS 12+

## 🔧 Instalación

### 1. Clonar el repositorio
```bash
git clone <repo>
cd ImpactoFit-Frontend
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Configurar backend (constants.dart)
```dart
// lib/core/constants.dart
const String BACKEND_URL = 'http://tu-ip:8000';  // Cambia según tu ambiente
```

**En desarrollo (emulador Android):**
```dart
const String BACKEND_URL = 'http://10.0.2.2:8000';  // localhost desde emulador
```

**En dispositivo real:**
```dart
const String BACKEND_URL = 'http://192.168.1.100:8000';  // Tu IP local
```

### 4. Crear carpeta de assets
```bash
mkdir -p assets/images assets/icons assets/fonts
```

## ▶️ Ejecutar

### Desarrollo
```bash
flutter run
```

### Build release
```bash
# Android
flutter build apk

# iOS
flutter build ios
```

## 🏗️ Arquitectura

### 1. **Capas**
- **Screens**: Interfaz de usuario (UI)
- **Providers**: Gestión de estado (Provider pattern)
- **Services**: Lógica de negocio
- **Core**: Configuración, cliente HTTP, almacenamiento seguro

### 2. **Flujo de Datos**
```
Widget (Screen)
    ↓ reads/watches
Provider (State)
    ↓ calls
Service (Auth, Cliente, etc)
    ↓ calls
ApiClient (HTTP)
    ↓ communicates with
Backend (FastAPI)
```

### 3. **Autenticación**
- Login: Email + Contraseña
- Token: JWT almacenado en almacenamiento seguro
- Renovación automática de sesión

## 🔐 Seguridad

### Almacenamiento de Tokens
Los tokens JWT se almacenan en `flutter_secure_storage` (encriptado):
- Android: Keystore del sistema
- iOS: Keychain

### Headers Autenticados
```dart
// En ApiClient, automáticamente agrega:
headers['Authorization'] = 'Bearer $token'
```

## 📡 Endpoints Integrados

### Auth
- `POST /auth/login` → Iniciar sesión
- `POST /auth/logout` → Cerrar sesión
- `POST /auth/recuperar-password` → Recuperar contraseña

### Cliente
- `GET /cliente/rutina` → Ver rutina activa
- `POST /cliente/asistencia` → Registrar asistencia
- `GET /cliente/clases` → Ver clases disponibles
- `POST /cliente/clases/{id}/inscribir` → Inscribirse

### Entrenador
- `GET /entrenador/clientes` → Ver clientes asignados
- `GET /entrenador/clientes/{id}/rutina` → Ver rutina de cliente
- `GET /entrenador/ejercicios` → Ver ejercicios disponibles

### Admin
- `GET /admin/clientes` → Ver todos los clientes
- `GET /admin/entrenadores` → Ver todos los entrenadores
- `POST /admin/clases` → Crear clase grupal
- `GET /admin/membresias` → Ver planes de membresía

## 🎨 Diseño

### Tema
- **Color primario**: #FFB84E (Naranja)
- **Color secundario**: #FF8D28 (Naranja oscuro)
- **Fondo**: #262525 (Gris oscuro)
- **Texto**: #FFFFFF (Blanco)

### Fuente
- Instrument Sans (Regular, Bold)

## 🔄 Navegación

La navegación se maneja con `named routes`:
```dart
// Navegar
Navigator.of(context).pushNamed('/cliente/asistencia');

// Reemplazar
Navigator.of(context).pushReplacementNamed('/login');

// Con parámetros (en desarrollo)
Navigator.of(context).pushNamed('/entrenador/rutina', arguments: {'clienteId': 123});
```

### Rutas Disponibles
```
/login                              # Login
/recuperar-password                 # Recuperar contraseña
/cliente/home                       # Home Cliente
/cliente/asistencia                 # Registro de asistencia
/cliente/mi_rutina                  # Rutina activa
/cliente/clases                     # Clases disponibles
/entrenador/home                    # Home Entrenador
/entrenador/clientes                # Clientes asignados
/entrenador/rutina                  # Rutina de cliente
/entrenador/ejercicios              # Gestión de ejercicios
/admin/home                         # Home Admin
/admin/clientes                     # Gestión de clientes
/admin/asignaciones                 # Asignaciones trainer-cliente
/admin/crear_entrenador             # Registrar entrenador
/admin/crear_clase                  # Crear clase grupal
/admin/membresias                   # Planes de membresía
/admin/clases                       # Gestión de clases
/admin/usuarios                     # Gestión de usuarios
```

## 📦 Dependencias Principales

| Paquete | Versión | Propósito |
|---------|---------|-----------|
| provider | ^6.0.0 | State management |
| http | ^1.1.0 | Cliente HTTP |
| flutter_secure_storage | ^9.0.0 | Almacenamiento seguro |

## 🐛 Debugging

### Habilitar logs
```dart
import 'package:logger/logger.dart';

final logger = Logger();
logger.d('Debug message');  // Debug
logger.i('Info message');   // Info
logger.w('Warning message'); // Warning
logger.e('Error message');  // Error
```

### DevTools
```bash
flutter pub global activate devtools
devtools
```

## 🤝 Contribuir

1. Crear rama feature: `git checkout -b feature/nueva-funcionalidad`
2. Hacer cambios y tests
3. Push: `git push origin feature/nueva-funcionalidad`
4. Pull request

## 📝 Notas

- Cambiar `BACKEND_URL` en `constants.dart` según el ambiente
- Assets (imágenes, fonts) deben colocarse en `assets/`
- Actualizar pubspec.yaml si se agregan nuevas dependencias
- Revisar logs con `flutter logs`

## 📞 Soporte

Para preguntas o problemas, contacta al equipo de desarrollo.
