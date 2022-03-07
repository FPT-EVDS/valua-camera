import 'package:json_annotation/json_annotation.dart';
part 'room.g.dart';

@JsonSerializable()
class Room {
  String roomId;
  int seatCount;
  String roomName;
  int floor;
  int status;

  Room({
    required this.roomId,
    required this.seatCount,
    required this.roomName,
    required this.floor,
    required this.status,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
