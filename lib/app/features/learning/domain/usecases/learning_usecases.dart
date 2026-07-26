import 'package:habilitacao_quiz/app/features/historico/domain/agregar_percentual_por_materia.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/materia_percentual_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/historico_materias.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/entities/learning_entities.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/repositories/learning_repository.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';

class GetLearningManifestUsecase {
  GetLearningManifestUsecase(this._repository);

  final ILearningRepository _repository;

  Future<LearningManifestEntity> call() => _repository.getManifest();
}

class LoadLearningMarkdownUsecase {
  LoadLearningMarkdownUsecase(this._repository);

  final ILearningRepository _repository;

  Future<String> call(String relativePath) =>
      _repository.loadMarkdown(relativePath);
}

class GetTrilhaBasicaUsecase {
  GetTrilhaBasicaUsecase(this._repository);

  final ILearningRepository _repository;

  Future<LearningTrilhaEntity> call() => _repository.getTrilhaBasica();
}

class GetTrilhaCompletaUsecase {
  GetTrilhaCompletaUsecase(this._repository);

  final ILearningRepository _repository;

  Future<LearningTrilhaEntity> call() => _repository.getTrilhaCompleta();
}

class GetTrilhaProgressoUsecase {
  GetTrilhaProgressoUsecase(this._repository);

  final ILearningRepository _repository;

  Future<Set<String>> call(String trilhaId) =>
      _repository.loadTrilhaProgresso(trilhaId);
}

class SalvarPassoTrilhaUsecase {
  SalvarPassoTrilhaUsecase(this._repository);

  final ILearningRepository _repository;

  Future<void> call({
    required String trilhaId,
    required String stepId,
  }) =>
      _repository.salvarPassoTrilha(trilhaId: trilhaId, stepId: stepId);
}

class GetMapaCompetenciasUsecase {
  GetMapaCompetenciasUsecase(this._proGate);

  final ProGate _proGate;

  MapaCompetenciasEntity call(HistoricoEntity historico) {
    if (_proGate.podeMapaCompetenciasDinamico) {
      return MapaCompetenciasEntity(
        materias: agregarPercentualPorMateria(historico.resutados),
        dinamico: true,
      );
    }
    return MapaCompetenciasEntity(
      materias: _previewEstatico(),
      dinamico: false,
    );
  }

  List<MateriaPercentualEntity> _previewEstatico() {
    return historicoMateriaTitulos
        .map(
          (titulo) => MateriaPercentualEntity(
            titulo: titulo,
            percentual: 0,
            totalCorretas: 0,
            totalQuestoes: 0,
          ),
        )
        .toList();
  }
}

class GetRevisaoEspacadaIdsUsecase {
  GetRevisaoEspacadaIdsUsecase(this._repository, this._proGate);

  final ILearningRepository _repository;
  final ProGate _proGate;

  Future<List<String>> call() async {
    if (!_proGate.podeRevisaoEspacada) return [];
    return _repository.getRevisaoEspacadaIds();
  }
}

class RegistrarRevisaoEspacadaUsecase {
  RegistrarRevisaoEspacadaUsecase(this._repository, this._proGate);

  final ILearningRepository _repository;
  final ProGate _proGate;

  Future<void> call(Set<String> questionIds) async {
    if (!_proGate.podeRevisaoEspacada) return;
    await _repository.registrarRevisaoEspacada(questionIds);
  }
}
