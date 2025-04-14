# HobbyMatch Flutter App

This is the Flutter frontend for the **HobbyMatch** platform, which connects people based on shared hobbies and interests. It consumes data from the HobbyMatch PHP MVC API.

## 🌐 Backend API

👉 [HobbyMatch PHP MVC API](https://github.com/taco-greco/HobbyMatch-PHP-MVC-API)

## 🧱 Features

- 🔐 User authentication with JWT
- 🧑‍🤝‍🧑 Profile creation and hobby selection
- 🧠 Hobby-based user matching
- 📲 Clean and responsive UI
- 🌙 Dark mode support (if applicable)

## 📸 Screenshots

> Add your app screenshots here:
- Home screen
- Match list
- Profile page

```
screenshots/home.png
screenshots/matches.png
screenshots/profile.png
```

## 🚀 Getting Started

### Prerequisites

- Flutter 3.x
- Android Studio or VS Code with Flutter plugin

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/taco-greco/HobbyMatch-Flutter.git
   cd HobbyMatch-Flutter
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Set up environment variables  
   Update the `baseUrl` in your API service files if needed to match your PHP backend.

4. Run the app
   ```bash
   flutter run
   ```

## 📂 Project Structure

- `lib/` – Main Flutter code
- `models/` – Data models
- `services/` – API calls
- `screens/` – UI screens
- `widgets/` – Reusable components

## 🧑‍💻 Author

- GitHub: [taco-greco](https://github.com/taco-greco)

## 📄 License

MIT License – feel free to use, modify, and contribute!
