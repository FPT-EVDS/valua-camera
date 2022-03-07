import 'package:valua_camera/models/shift.dart';

abstract class ShiftRepository {
  Future<Shift> getShift();
}
