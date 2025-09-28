import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_index_state.dart';

class DashBoardBottomNavIndexCubit extends Cubit<int> {
  DashBoardBottomNavIndexCubit() : super(0);
  void updateIndex(int index) {
    if (index != state) emit(index);
  }
}
