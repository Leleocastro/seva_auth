import 'package:flutter_test/flutter_test.dart';
import 'package:seva_auth/utils/base_state.dart';

void main() {
  group('[UTILS] - BaseState', () {
    test('LoadingState should be equal', () {
      const loadingState1 = LoadingState();
      const loadingState2 = LoadingState();

      expect(loadingState1, equals(loadingState2));
    });

    test('SuccessState should be equal with the same data', () {
      const successState1 = SuccessState<int>(42);
      const successState2 = SuccessState<int>(42);

      expect(successState1, equals(successState2));
    });

    test('SuccessState should not be equal with different data', () {
      const successState1 = SuccessState<int>(42);
      const successState2 = SuccessState<int>(24);

      expect(successState1, isNot(equals(successState2)));
    });

    test('ErrorState should be equal with the same message and errorCode', () {
      const errorState1 = ErrorState('Error message', '500');
      const errorState2 = ErrorState('Error message', '500');

      expect(errorState1, equals(errorState2));
    });

    test('ErrorState should not be equal with different message', () {
      const errorState1 = ErrorState('Error message 1', '500');
      const errorState2 = ErrorState('Error message 2', '500');

      expect(errorState1, isNot(equals(errorState2)));
    });

    test('EmptyState should be equal', () {
      const emptyState1 = EmptyState();
      const emptyState2 = EmptyState();

      expect(emptyState1, equals(emptyState2));
    });
  });
}
