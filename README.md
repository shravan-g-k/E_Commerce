# E-Commerce App

A modern e-commerce mobile application built with Flutter, Supabase, and Flutter Bloc architecture.

## Features

- User authentication and account management
- Product browsing and searching
- Product categories and filtering
- Shopping cart functionality
- Secure checkout process
- User reviews and ratings
- Wishlist functionality

## Technology Stack

- **Frontend**: Flutter
- **Backend**: Supabase
- **State Management**: Flutter Bloc
- **Authentication**: Supabase Auth

## Prerequisites

Before you begin, ensure you have the following installed:
- [Flutter](https://flutter.dev/docs/get-started/install) (latest stable version)
- [Dart](https://dart.dev/get-dart)
- [Git](https://git-scm.com/)
- A code editor like [VS Code](https://code.visualstudio.com/) with Flutter and Dart plugins

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/shravan-g-k/E_Commerce.git
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Set up Supabase

1. Create a Supabase project at [supabase.com](https://supabase.com)
2. Create the necessary tables in your Supabase database
3. Copy your Supabase URL and anon key from the project settings

### 4. Configure environment variables

Create a `.env` file in the project root with the following:

```
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
WEB_CLIENT_ID = web_client_id
```

### 5. Run the app

```bash
flutter run
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Flutter](https://flutter.dev/)
- [Supabase](https://supabase.com/)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)