import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test_app/bloc/auth/auth_bloc.dart';

void main() {
//   setUp(() {});
//
  group('AuthBlocTest', () {
    // blocTest<AuthBloc, AuthState>(
    //   'emits Initial when nothing is added',
    //   build: () => AuthBloc(),
    //   expect: () => AuthInitial(),
    // );

    blocTest<AuthBloc, AuthState>(
      'emits [1] when CounterEvent.increment is added',
      build: () => AuthBloc(),
      act: (bloc) => bloc.add(GoogleSignInEvent()),
      expect: () => GoogleSignInSuccessState(),
    );

    // blocTest<AuthBloc, AuthState>(
    //   'emits [1] when CounterEvent.increment is added',
    //   build: () => AuthBloc(),
    //   act: (bloc) => bloc.add(GoogleSignInEvent()),
    //   expect: () => GoogleSignInFailState(''),
    // );
  });
//
//   // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//   //   // Build our app and trigger a frame.
//   //   await tester.pumpWidget(MyApp());
//   //
//   //   // Verify that our counter starts at 0.
//   //   expect(find.text('0'), findsOneWidget);
//   //   expect(find.text('1'), findsNothing);
//   //
//   //   // Tap the '+' icon and trigger a frame.
//   //   await tester.tap(find.byIcon(Icons.add));
//   //   await tester.pump();
//   //
//   //   // Verify that our counter has incremented.
//   //   expect(find.text('0'), findsNothing);
//   //   expect(find.text('1'), findsOneWidget);
//   // });
}
