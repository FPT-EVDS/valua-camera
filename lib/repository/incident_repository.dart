abstract class IncidentRepository {
  Future<String> submitReport(
    String description,
    String note,
    String? imageUrl,
    String examRoomId,
  );
}
