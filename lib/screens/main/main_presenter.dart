import 'package:shared_preferences/shared_preferences.dart';
import 'package:valua_staff/di/injection.dart';
import 'package:valua_staff/models/exam_room.dart';
import 'package:valua_staff/models/shift.dart';
import 'package:valua_staff/repository/exam_room_repository.dart';
import 'package:valua_staff/repository/shift_repository.dart';
import 'package:valua_staff/screens/main/main_view.dart';

class MainPresenter {
  MainView _mainView;
  late ExamRoomRepository _examRoomRepository;

  MainPresenter(this._mainView) {
    _examRoomRepository = new Injector().examRoomRepository;
  }

  Future<void> loadExamRoom() async {
    try {
      ExamRoom examRoom = await _examRoomRepository.loadExamRoom();
      _mainView.loadExamRoom(examRoom);
    } catch (e) {
      _mainView.showEmptyExamRoom();
      print(e);
    }
  }
}
