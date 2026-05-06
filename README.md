# 🛍️ Retrofit Store — Flutter Clean Architecture

A production-ready Flutter app built with **FakeStoreAPI**, **Retrofit**, **Dio**, **Cubit**, and **Clean Architecture** — structured the way real companies build scalable mobile apps.

---

## 🚀 Features

- ✅ Clean Architecture (Data / Domain / Presentation)
- ✅ Retrofit for type-safe, annotation-driven API calls
- ✅ Dio HTTP client with timeout and logging
- ✅ Cubit (flutter_bloc) for predictable state management
- ✅ GetIt dependency injection
- ✅ Repository pattern for full abstraction
- ✅ Product CRUD: Get All · Add · Delete
- ✅ Real-time client-side search by title & category
- ✅ Shimmer skeleton loading
- ✅ Staggered grid animations
- ✅ Cached network images
- ✅ Beautiful, responsive UI with Google Fonts

---

## 🧠 Tech Stack

| Layer | Technology |
|---|---|
| Language | Dart |
| Framework | Flutter |
| Networking | Dio + Retrofit |
| State Management | flutter_bloc (Cubit) |
| Dependency Injection | GetIt |
| Code Generation | build_runner, json_serializable, retrofit_generator |
| UI | Google Fonts, Shimmer, Staggered Animations |
| API | FakeStoreAPI |

---

## 🌐 API

**Base URL:** `https://fakestoreapi.com`

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/products` | Fetch all products |
| `POST` | `/products` | Add a new product |
| `DELETE` | `/products/{id}` | Delete a product by ID |

---

## 📂 Project Structure

```
lib/
├── main.dart
│
├── core/
│   ├── di/
│   │   └── injection.dart                  ← GetIt DI registration
│   ├── errors/
│   │   └── failures.dart                   ← Failure types
│   └── network/
│       ├── dio_client.dart                 ← Dio configuration
│       ├── api_service.dart                ← Retrofit interface (@GET, @POST, @DELETE)
│       └── api_service.g.dart              ← Generated Retrofit implementation
│
└── features/
    └── product/
        ├── data/
        │   ├── models/
        │   │   ├── product_model.dart       ← JSON model + toEntity() mapper
        │   │   └── product_model.g.dart     ← Generated JSON serialization
        │   ├── datasources/
        │   │   └── product_remote_datasource.dart
        │   └── repositories/
        │       └── product_repository_impl.dart
        │
        ├── domain/
        │   ├── entities/
        │   │   └── product.dart             ← Pure Dart entity (Equatable)
        │   ├── repositories/
        │   │   └── product_repository.dart  ← Abstract contract
        │   └── usecases/
        │       ├── get_products.dart
        │       ├── add_product.dart
        │       └── delete_product.dart
        │
        └── presentation/
            ├── pages/
            │   └── product_page.dart        ← Main page (orchestrator only)
            ├── state/
            │   ├── product_cubit.dart
            │   └── product_state.dart
            └── local_widgets/
                ├── product_app_bar.dart
                ├── product_search_bar.dart
                ├── product_grid.dart
                ├── product_card.dart
                ├── product_shimmer_grid.dart
                ├── product_error_view.dart
                └── add_product_sheet.dart
```

---

## ⚙️ Setup

### 1. Clone the repository
```bash
git clone https://github.com/your-username/retrofit-store-flutter.git
cd retrofit-store-flutter
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Generate Retrofit + JSON code
```bash
dart run build_runner build --delete-conflicting-outputs
```

> Re-run this command whenever you modify `api_service.dart` or any `@JsonSerializable` model.

### 4. Run the app
```bash
flutter run
```

---

## 🔥 Retrofit in Action

```dart
@RestApi(baseUrl: 'https://fakestoreapi.com')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/products')
  Future<List<ProductModel>> getProducts();

  @POST('/products')
  Future<ProductModel> addProduct(@Body() Map<String, dynamic> product);

  @DELETE('/products/{id}')
  Future<dynamic> deleteProduct(@Path('id') int id);
}
```

No manual URL building. No manual JSON parsing. No repetitive boilerplate — Retrofit generates everything via `build_runner`.

---

## 🧠 Architecture Flow

```
UI (Cubit/State)
     ↓
  Use Cases          ← Domain layer — pure business logic
     ↓
  Repository         ← Abstract contract defined in domain
     ↓
  Datasource         ← Data layer — calls Retrofit API
     ↓
  Retrofit + Dio     ← HTTP layer — handles all networking
```

Each layer only knows about the layer directly below it. The domain layer has **zero** Flutter or Retrofit dependencies.

---

## 📦 Dependencies

```yaml
dependencies:
  dio: ^5.4.3+1
  retrofit: ^4.1.0
  json_annotation: ^4.9.0
  get_it: ^7.7.0
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5
  cached_network_image: ^3.3.1
  flutter_staggered_animations: ^1.1.1
  shimmer: ^3.0.0
  google_fonts: ^6.2.1

dev_dependencies:
  retrofit_generator: ^8.1.0
  build_runner: ^2.4.9
  json_serializable: ^6.8.0
```

---

## 🎯 What You'll Learn From This Project

- How Clean Architecture is applied in a real Flutter app
- How Retrofit eliminates boilerplate API code with annotations
- How Cubit manages state cleanly across loading / loaded / error
- How GetIt wires all dependencies without context
- How to break a page into small, focused local widgets
- How the Repository pattern decouples your UI from your data source

---

## 👨‍💻 Author

Built as part of a daily Flutter learning series focused on production-level architecture, clean code, and real-world patterns.

---

## ⭐ Support

If this helped you, give it a star on GitHub ⭐

---

## 🏷️ Tags

`Flutter` `Dart` `Clean Architecture` `Retrofit` `Dio` `Cubit` `flutter_bloc` `GetIt` `FakeStoreAPI` `Mobile Development` `100DaysOfFlutter`
