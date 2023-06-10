
import 'package:dartz/dartz.dart';

import '../../core/usecase.dart';
import '../../data/models/coach_models/coach_metrics_scores_moderate_list_model.dart';

class CoachReportMetricsScoresModerateListUseCase extends UseCase<
    CoachMetricsScoresModerateList?,
    CoachReportMetricsScoresModerateListParams> {
  @override
  Future<Either<dynamic, CoachMetricsScoresModerateList?>> call(CoachReportMetricsScoresModerateListParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
  // CoachReportMetricsScoresModerateListUseCase({required this.playerProfileRepo});

  // final PlayerProfileRepo? playerProfileRepo;
  //
  // @override
  // Future<Either<Failure, CoachMetricsScoresModerateList?>> call(
  //     CoachReportMetricsScoresModerateListParams params) async {
  //   final response =
  //       await playerProfileRepo!.getCoachMetricsScoresModerateListData(params);
  //
  //   return response.fold(
  //     (error) => Left(error),
  //     (r) => Right(r),
  //   );
  // }
}

class CoachReportMetricsScoresModerateListParams {
  String playerId;
  String dateFrom;
  String dateTo;

  CoachReportMetricsScoresModerateListParams({
    required this.playerId,
    required this.dateFrom,
    required this.dateTo,
  });
}
