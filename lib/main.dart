import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/ticker_bloc.dart';
import 'ticker/ticker.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'ticker_bloc_observer.dart';

void main() {
  Bloc.observer = TickerBlocObserver();
  EquatableConfig.stringify = kDebugMode;
  runApp(TickerApp());
}

/// {@template ticker_app}
/// [MaterialApp] which sets the [TickerPage] as the `home`.
/// [TickerApp] also provides an instance of [TickerBloc] to
/// the [TickerPage].
/// {@endtemplate}
class TickerApp extends MaterialApp {
  /// {@macro ticker_app}
  TickerApp({Key key})
      : super(
          key: key,
          home: BlocProvider(
            create: (_) => TickerBloc(Ticker()),
            child: TickerPage(),
          ),
        );
}

/// [StatelessWidget] which consumes a [TickerBloc]
/// and responds to changes in the [TickerState].
/// [TickerPage] also notifies the [TickerBloc] when
/// the user taps on the start button.
class TickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bloc with Streams'),
      ),
      body: BlocBuilder<TickerBloc, TickerState>(
        builder: (context, state) {
          if (state is TickerTickSuccess) {
            return Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: state.count.toDouble() / 100,
                header: Text("Icon header"),
                center: Icon(
                  Icons.person_pin,
                  size: 50.0,
                  color: Colors.blue,
                ),
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),
            );
          }
          return const Center(
            child: Text('Press the floating button to start'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<TickerBloc>().add(TickerStarted()),
        tooltip: 'Start',
        child: const Icon(Icons.timer),
      ),
    );
  }
}
