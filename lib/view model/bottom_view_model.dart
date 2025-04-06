import 'package:flutter_riverpod/flutter_riverpod.dart';

// ViewModel for Bottom Navigation State
class BottomNavViewModel extends StateNotifier<int> {
  BottomNavViewModel() : super(0);

  void changeIndex(int index) {
    state = index;
  }
}

// Riverpod Provider
final bottomNavProvider = StateNotifierProvider<BottomNavViewModel, int>(
  (ref) => BottomNavViewModel(),
);