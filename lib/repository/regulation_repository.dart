abstract class RegulationRepository {
  Future<String> submitReport(
    String description,
    String note,
    String? imageUrl,
    String violatorId,
    String examRoomId,
  );
}
