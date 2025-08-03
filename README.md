# Tic Tac Toe Flutter App

A beautiful and modern Tic Tac Toe game built with Flutter, featuring smooth animations, elegant UI design, and an intuitive user experience.

## 🎮 Features

- **Modern UI Design**: Clean and elegant interface with gradient backgrounds and smooth animations
- **Smooth Animations**: Fade-in, slide, scale, and win celebration animations
- **Responsive Layout**: Adapts to different screen sizes and orientations
- **Game State Management**: Dynamic button text that changes based on game state
- **Win Detection**: Automatic detection of winning patterns and draw conditions
- **Visual Feedback**: Winning cells are highlighted with special animations
- **Google Fonts**: Beautiful typography using Poppins font family
- **Material Design 3**: Modern design system with elevated buttons and shadows

## 🎯 Game Features

- **Turn-based Gameplay**: Alternating turns between Player X and Player O
- **Win Detection**: Detects all possible winning combinations (rows, columns, diagonals)
- **Draw Detection**: Automatically detects when the game ends in a draw
- **Dynamic UI**: Button text changes from "Restart" during gameplay to "Play Again" when game ends
- **Visual Indicators**: Current player's turn is clearly displayed with color-coded indicators
- **Winning Animation**: Special celebration animation for winning cells

## 📱 Screenshots

The app features:
- Clean gradient background
- Animated game board with 3x3 grid
- Dynamic header showing current player or game result
- Adaptive button that changes text based on game state
- Smooth animations for all interactions

## 🚀 Installation

### Prerequisites

- Flutter SDK (version 3.5.0 or higher)
- Dart SDK
- Android Studio / VS Code (recommended)
- Android Emulator or physical device for testing

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd tictactoe
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🛠️ Dependencies

The app uses the following main dependencies:

- **flutter**: The core Flutter framework
- **google_fonts**: ^6.1.0 - For beautiful typography
- **cupertino_icons**: ^1.0.8 - For iOS-style icons

## 📁 Project Structure

```
lib/
├── main.dart              # App entry point and theme configuration
└── screens/
    └── HomeScreen.dart    # Main game screen with all game logic
```

## 🎮 How to Play

1. **Start the Game**: The game automatically starts with Player X's turn
2. **Take Turns**: Players tap on empty cells to place their mark (X or O)
3. **Win Conditions**: Get three of your marks in a row (horizontally, vertically, or diagonally)
4. **Game End**: The game ends when someone wins or all cells are filled (draw)
5. **Restart**: Use the "Restart" button during gameplay or "Play Again" when game ends

## 🎨 UI/UX Features

- **Gradient Backgrounds**: Beautiful gradient backgrounds throughout the app
- **Animated Transitions**: Smooth animations for all user interactions
- **Color-coded Players**: Blue for Player X, Red for Player O
- **Winning Highlights**: Winning cells are highlighted with amber color and special animations
- **Responsive Design**: Works on various screen sizes and orientations
- **Material Design 3**: Modern design with elevated buttons and proper shadows

## 🔧 Technical Details

### State Management
- Uses Flutter's built-in `StatefulWidget` for state management
- Game state includes current player, board state, win conditions, and animations

### Animations
- **Fade Animation**: For initial app load
- **Slide Animation**: For header elements
- **Scale Animation**: For cell interactions
- **Win Animation**: Special celebration animation for winning cells

### Game Logic
- 3x3 grid represented as a List<String>
- Win pattern detection for all 8 possible winning combinations
- Draw detection when all cells are filled
- Dynamic UI updates based on game state

## 🚀 Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google Fonts for the beautiful typography
- Material Design team for the design system

---

**Enjoy playing Tic Tac Toe! 🎮**
