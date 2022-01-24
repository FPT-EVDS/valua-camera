import 'package:dio/dio.dart';
import 'package:valua_staff/configs/http_service.dart';
import 'package:valua_staff/models/exam_room.dart';
import 'package:valua_staff/repository/exam_room_repository.dart';

class ExamRoomService implements ExamRoomRepository {
  Dio dio = new HttpService().dio;

  @override
  Future<ExamRoom> loadExamRoom() async {
    print('loadExam');
    final response = await dio.get("/examRooms/assigned");
    print(response);
    return ExamRoom.fromJson(response.data);
  }
}
