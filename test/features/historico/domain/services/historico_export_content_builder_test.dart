import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/services/historico_export_content_builder.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

ResultadoEntity _resultado({
  required String id,
  required TipoResultado tipo,
  required String titulo,
}) =>
    ResultadoEntity(
      id: id,
      tipo: tipo,
      realizadoEm: DateTime.utc(2026, 7, 26),
      titulo: titulo,
      totalPerguntas: 30,
      result: true,
      totalRespostasCorretas: 24,
      percentual: 80,
    );

void main() {
  const builder = HistoricoExportContentBuilder();

  test('CSV inclui BOM UTF-8 e linha de resultado', () {
    final bytes = builder.buildCsvBytes([
      _resultado(
        id: '1',
        tipo: TipoResultado.simulado,
        titulo: Strings.simulado,
      ),
    ]);
    expect(bytes.length, greaterThan(3));
    expect(bytes[0], 0xEF);
    expect(bytes[1], 0xBB);
    expect(bytes[2], 0xBF);
    final text = utf8.decode(bytes);
    expect(text, contains('Simulado'));
    expect(text, contains('80.0'));
    expect(text, contains('24'));
    expect(text, contains('30'));
  });

  test('PDF começa com header e inclui título do resultado', () {
    final doc = builder.buildPdfDocument([
      _resultado(
        id: '1',
        tipo: TipoResultado.tema,
        titulo: Strings.legislacao,
      ),
    ]);
    expect(doc.startsWith('%PDF-1.4'), isTrue);
    expect(doc, contains(Strings.legislacao));
    expect(doc, contains('%%EOF'));
  });

  test('filenameFor usa extensão correta', () {
    final at = DateTime(2026, 7, 26, 14, 5);
    expect(
      builder.filenameFor(isPdf: false, exportedAt: at),
      endsWith('.csv'),
    );
    expect(
      builder.filenameFor(isPdf: true, exportedAt: at),
      endsWith('.pdf'),
    );
    expect(
      builder.filenameFor(isPdf: false, exportedAt: at),
      startsWith('habilitacao_quiz_historico_'),
    );
  });
}
