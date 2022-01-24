import 'package:valua_staff/models/shift.dart';

abstract class ShiftRepository {
  Future<Shift> getShift();
}
