import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static const String pX = 'X';
  static const String pO = 'O';

  late String curr;
  late bool end;
  late List<String> occ;
  late String winner;
  late List<int> winningPattern;
  
  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _winController;
  
  // Animations
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _winAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    initializeGame();
  }

  void _initializeAnimations() {
    // Fade in animation for initial load
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Slide animation for header
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    // Scale animation for cell interactions
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    // Win celebration animation
    _winController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    _winAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _winController,
      curve: Curves.elasticOut,
    ));

    // Start initial animations
    _fadeController.forward();
    _slideController.forward();
  }

  void initializeGame() {
    curr = pX;
    end = false;
    winner = '';
    winningPattern = [];
    occ = List.filled(9, '');
    _winController.reset();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _winController.dispose();
    super.dispose();
  }

  void changeTurn() {
    curr = (curr == pX) ? pO : pX;
  }

  void checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6] // Diagonals
    ];

    for (var pattern in winPatterns) {
      String first = occ[pattern[0]];
      if (first.isNotEmpty &&
          first == occ[pattern[1]] &&
          first == occ[pattern[2]]) {
        setState(() {
          end = true;
          winner = first;
          winningPattern = pattern;
        });
        _winController.forward();
        return;
      }
    }
  }

  void checkDraw() {
    if (!occ.contains('') && !end) {
      setState(() {
        end = true;
        winner = 'Draw';
      });
    }
  }

  Widget _buildHeader() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Text(
              'Tic Tac Toe',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: curr == pX 
                    ? [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)]
                    : [const Color(0xFFEF4444), const Color(0xFFDC2626)],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: (curr == pX 
                      ? const Color(0xFF3B82F6) 
                      : const Color(0xFFEF4444)).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                end 
                  ? (winner == 'Draw' ? "Game Draw" : 'Player $winner Wins!')
                  : "Player $curr's Turn",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameBoard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: Colors.white,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return _buildGameCell(index);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameCell(int index) {
    bool isWinningCell = winningPattern.contains(index);
    bool hasValue = occ[index].isNotEmpty;
    
    return AnimatedBuilder(
      animation: _winAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isWinningCell && end ? _winAnimation.value : 1.0,
          child: GestureDetector(
            onTap: () {
              if (end || occ[index].isNotEmpty) return;
              
              setState(() {
                occ[index] = curr;
                checkWinner();
                checkDraw();
                if (!end) changeTurn();
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isWinningCell && end
                    ? Colors.amber.shade100
                    : hasValue
                        ? (occ[index] == pX 
                            ? Colors.blue.shade50 
                            : Colors.red.shade50)
                        : Colors.grey.shade50,
                border: Border.all(
                  color: isWinningCell && end
                      ? Colors.amber.shade400
                      : Colors.grey.shade200,
                  width: isWinningCell && end ? 3 : 1,
                ),
              ),
              child: Center(
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween(begin: 0.0, end: hasValue ? 1.0 : 0.0),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Text(
                        occ[index],
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          color: hasValue
                              ? (occ[index] == pX 
                                  ? const Color(0xFF3B82F6) 
                                  : const Color(0xFFEF4444))
                              : Colors.transparent,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNewGameButton() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: ElevatedButton.icon(
          onPressed: () {
            setState(() {
              initializeGame();
            });
          },
          icon: const Icon(Icons.refresh_rounded, size: 20),
          label: Text(
            end ? 'Play Again' : 'Restart',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6366F1),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
            shadowColor: const Color(0xFF6366F1).withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFF8FAFC),
              const Color(0xFFF1F5F9),
              const Color(0xFFE2E8F0),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  _buildHeader(),
                  const SizedBox(height: 40),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 350),
                    child: _buildGameBoard(),
                  ),
                  const SizedBox(height: 20),
                  _buildNewGameButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}