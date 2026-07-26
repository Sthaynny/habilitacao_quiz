import 'package:habilitacao_quiz/app/features/historico/domain/entities/materia_percentual_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/historico_materias.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_pergunta_detalhe_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';

class _AcumuladorMateria {
  int corretas = 0;
  int total = 0;
}

/// Agrega % de acerto por matéria a partir do histórico (temas + simulados Pro).
List<MateriaPercentualEntity> agregarPercentualPorMateria(
  List<ResultadoEntity> resultados,
) {
  final acumuladores = <String, _AcumuladorMateria>{};
  for (final titulo in historicoMateriaTitulos) {
    acumuladores[titulo] = _AcumuladorMateria();
  }

  for (final resultado in resultados) {
    if (resultado.tipo == TipoResultado.tema) {
      _acumularTema(acumuladores, resultado);
      continue;
    }
    if (resultado.isSimulado && resultado.detalhePerguntas != null) {
      _acumularSimuladoDetalhe(acumuladores, resultado.detalhePerguntas!);
    }
  }

  return historicoMateriaTitulos.map((titulo) {
    final acc = acumuladores[titulo]!;
    final total = acc.total;
    final percentual = total > 0 ? (acc.corretas / total) * 100 : 0.0;
    return MateriaPercentualEntity(
      titulo: titulo,
      percentual: percentual,
      totalCorretas: acc.corretas,
      totalQuestoes: total,
    );
  }).toList();
}

void _acumularTema(
  Map<String, _AcumuladorMateria> acc,
  ResultadoEntity resultado,
) {
  final bucket = acc[resultado.titulo];
  if (bucket == null) return;
  bucket.corretas += resultado.totalRespostasCorretas;
  bucket.total += resultado.totalPerguntas;
}

void _acumularSimuladoDetalhe(
  Map<String, _AcumuladorMateria> acc,
  List<ResultadoPerguntaDetalheEntity> detalhe,
) {
  for (final item in detalhe) {
    final materia = item.materiaTitulo;
    if (materia == null) continue;
    final bucket = acc[materia];
    if (bucket == null) continue;
    bucket.total++;
    if (item.acertou) bucket.corretas++;
  }
}
