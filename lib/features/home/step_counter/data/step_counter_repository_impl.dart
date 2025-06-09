import 'package:pedometer/pedometer.dart';
import '../domain/step_counter_repository.dart';

class StepCounterRepositoryImpl implements StepCounterRepository {
  int? _initialSteps;

  @override
  Stream<int> getStepCountStream() async* {
    await for (final event in Pedometer.stepCountStream) {
      if (_initialSteps == null) {
        _initialSteps = event.steps;
      }
      yield event.steps - _initialSteps!;
    }
  }

  @override
  Future<bool> requestPermission() async => true;
}
