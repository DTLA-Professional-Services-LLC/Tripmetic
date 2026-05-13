import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_bootstrap.dart';

bool _startupFailureUiInstalled = false;

void _presentStartupFailure(Object error, StackTrace stack) {
  if (_startupFailureUiInstalled) return;
  _startupFailureUiInstalled = true;

  FlutterError.dumpErrorToConsole(FlutterErrorDetails(
    exception: error,
    stack: stack,
    library: 'Tripmetic startup',
    context: ErrorDescription('Unhandled error during app bootstrap'),
  ));

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B132B),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tripmetic could not start',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    child: SelectableText(
                      '$error\n\n$stack',
                      style: const TextStyle(fontSize: 12, height: 1.35),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () {
                    _startupFailureUiInstalled = false;
                    main();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

void _installGlobalErrorHooks() {
  final previousOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    previousOnError?.call(details);
    if (kDebugMode) {
      FlutterError.presentError(details);
    }
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    _presentStartupFailure(error, stack);
    return true;
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: const Color(0xFF0B132B),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white70, fontSize: 13),
              child: Text(
                'Widget build failed:\n${details.exceptionAsString()}\n\n'
                '${details.stack}',
              ),
            ),
          ),
        ),
      ),
    );
  };
}

void main() {
  runZonedGuarded(() {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      _installGlobalErrorHooks();
      runApp(const TripmeticLoader());
    } catch (e, st) {
      _presentStartupFailure(e, st);
    }
  }, (error, stack) {
    _presentStartupFailure(error, stack);
  });
}

class TripmeticLoader extends StatefulWidget {
  const TripmeticLoader({super.key});

  @override
  State<TripmeticLoader> createState() => _TripmeticLoaderState();
}

class _TripmeticLoaderState extends State<TripmeticLoader> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadApp());
  }

  Future<void> _loadApp() async {
    try {
      final root = await createTripmeticRoot();
      if (!mounted) return;
      runApp(root);
    } catch (e, st) {
      if (!mounted) return;
      _presentStartupFailure(e, st);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF0B132B),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tripmetic',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 18),
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
