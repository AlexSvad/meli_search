import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/bootstrap.dart';

void main() {
  group('AppBlocObserver', () {
    test('onChange no lanza excepciones y ejecuta super.onChange', () {
      const observer = AppBlocObserver();
      final bloc = _FakeBloc();
      const change = Change(currentState: 0, nextState: 1);
      expect(() => observer.onChange(bloc, change), returnsNormally);
    });

    test('onError no lanza excepciones y ejecuta super.onError', () {
      const observer = AppBlocObserver();
      final bloc = _FakeBloc();
      expect(
        () => observer.onError(bloc, 'Error', StackTrace.empty),
        returnsNormally,
      );
    });
  });
}

class _FakeBloc extends BlocBase<int> {
  _FakeBloc() : super(0);
}
