/// Leitura/escrita de arquivo de backup (file picker + share) — implementação em data.
abstract interface class IHistoricoBackupFileGateway {
  Future<void> shareBackupFile({required String jsonContent});

  /// `null` se o usuário cancelou o picker.
  Future<String?> pickBackupFileContent();
}
