import 'dart:async';
import 'package:flutter/widgets.dart';

class RouteTracker extends NavigatorObserver {
  final _controller = StreamController<String>.broadcast();

  Stream<String> get routeStream => _controller.stream;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _controller.add(route.settings.name ?? '');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _controller.add(previousRoute?.settings.name ?? '');
  }

  void dispose() => _controller.close();
}
