abstract interface class IHistoricoExportRepository {
  Future<String> writeTempFile({
    required String filename,
    required List<int> bytes,
  });
}
