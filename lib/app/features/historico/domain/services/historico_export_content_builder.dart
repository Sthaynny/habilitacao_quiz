import 'dart:convert';

import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// Gera conteúdo CSV/PDF do histórico (sem I/O).
class HistoricoExportContentBuilder {
  const HistoricoExportContentBuilder();

  List<int> buildBytes({
    required List<ResultadoEntity> resultados,
    required bool isPdf,
  }) {
    if (isPdf) {
      return buildPdfBytes(resultados);
    }
    return buildCsvBytes(resultados);
  }

  List<int> buildCsvBytes(List<ResultadoEntity> resultados) {
    final rows = <String>[
      'Data,Tipo,Título,Percentual,Corretas,Total,Aprovado',
      ...resultados.map(_csvRow),
    ];
    return utf8.encode('\uFEFF${rows.join('\n')}');
  }

  List<int> buildPdfBytes(List<ResultadoEntity> resultados) {
    return utf8.encode(buildPdfDocument(resultados));
  }

  String buildPdfDocument(List<ResultadoEntity> resultados) {
    final streamLines = <String>[];
    double y = 760;
    const lineGap = 13;

    void addText(String text, {double fontSize = 10}) {
      if (y < 48) return;
      streamLines.add(
        'BT /F1 $fontSize Tf 48 ${y.toStringAsFixed(1)} Td '
        '${_pdfLiteral(text)} Tj ET',
      );
      y -= lineGap;
    }

    addText('Histórico — Habilitação Quiz', fontSize: 14);
    addText(
      'Data | Tipo | Título | % | Corretas/Total | Aprovado',
      fontSize: 9,
    );
    for (final r in resultados) {
      addText(_summaryLine(r), fontSize: 9);
    }

    final stream = streamLines.join('\n');
    final streamBytes = utf8.encode(stream);

    final buffer = StringBuffer('%PDF-1.4\n');
    final offsets = <int>[];

    void writeObj(String content) {
      offsets.add(buffer.length);
      buffer.writeln(content);
    }

    writeObj('1 0 obj<</Type/Catalog/Pages 2 0 R>>endobj');
    writeObj('2 0 obj<</Type/Pages/Kids[3 0 R]/Count 1>>endobj');
    writeObj(
      '3 0 obj<</Type/Page/MediaBox[0 0 612 792]/Parent 2 0 R/'
      'Contents 4 0 R/Resources<</Font<</F1 5 0 R>>>>>>endobj',
    );
    writeObj(
      '4 0 obj<</Length $streamBytes.length>>stream\n$stream\nendstream endobj',
    );
    writeObj('5 0 obj<</Type/Font/Subtype/Type1/BaseFont/Helvetica>>endobj');

    final xrefStart = buffer.length;
    buffer.writeln('xref');
    buffer.writeln('0 ${offsets.length + 1}');
    buffer.writeln('0000000000 65535 f ');
    for (final offset in offsets) {
      buffer.writeln('${offset.toString().padLeft(10, '0')} 00000 n ');
    }
    buffer.writeln('trailer<</Size ${offsets.length + 1}/Root 1 0 R>>');
    buffer.writeln('startxref');
    buffer.writeln(xrefStart);
    buffer.write('%%EOF');

    return buffer.toString();
  }

  String filenameFor({
    required bool isPdf,
    required DateTime exportedAt,
  }) {
    final stamp = _fileStamp(exportedAt);
    final ext = isPdf ? 'pdf' : 'csv';
    return 'habilitacao_quiz_historico_$stamp.$ext';
  }

  String _csvRow(ResultadoEntity r) {
    return [
      _csvCell(Strings.historicoDataLabel(r.realizadoEm)),
      _csvCell(_tipoLabel(r.tipo)),
      _csvCell(r.titulo),
      _csvCell(r.percentual.toStringAsFixed(1)),
      _csvCell(r.totalRespostasCorretas.toString()),
      _csvCell(r.totalPerguntas.toString()),
      _csvCell(r.result ? Strings.sim : Strings.nao),
    ].join(',');
  }

  String _summaryLine(ResultadoEntity r) {
    final data = Strings.historicoDataLabel(r.realizadoEm);
    final aprovado = r.result ? Strings.sim : Strings.nao;
    return '$data | ${_tipoLabel(r.tipo)} | ${r.titulo} | '
        '${r.percentual.toStringAsFixed(1)}% | '
        '${r.totalRespostasCorretas}/${r.totalPerguntas} | $aprovado';
  }

  String _tipoLabel(TipoResultado tipo) {
    switch (tipo) {
      case TipoResultado.simulado:
        return Strings.historicoBadgeSimulado;
      case TipoResultado.tema:
        return Strings.historicoBadgeTema;
    }
  }

  String _csvCell(String value) {
    if (value.contains('"') || value.contains(',') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }

  String _pdfLiteral(String text) {
    final buffer = StringBuffer('(');
    for (final codeUnit in text.codeUnits) {
      if (codeUnit == 0x28 || codeUnit == 0x29 || codeUnit == 0x5C) {
        buffer.write('\\${String.fromCharCode(codeUnit)}');
      } else if (codeUnit <= 0xFF) {
        buffer.writeCharCode(codeUnit);
      } else {
        buffer.write('?');
      }
    }
    buffer.write(')');
    return buffer.toString();
  }

  String _fileStamp(DateTime at) {
    final local = at.toLocal();
    final y = local.year.toString().padLeft(4, '0');
    final m = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    final h = local.hour.toString().padLeft(2, '0');
    final min = local.minute.toString().padLeft(2, '0');
    return '$y$m${d}_$h$min';
  }
}
