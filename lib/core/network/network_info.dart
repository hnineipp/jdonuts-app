import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  NetworkInfo(this._connectivity);

  final Connectivity _connectivity;

  static const Duration _timeout = Duration(seconds: 5);

  Stream<bool> get offlineChanges async* {
    var previous = await isOffline();

    debugPrint('INITIAL OFFLINE STATUS: $previous');

    yield previous;

    await for (final _ in _connectivity.onConnectivityChanged) {
      await Future<void>.delayed(
        const Duration(milliseconds: 350),
      );

      final current = await isOffline();

      debugPrint('NETWORK STATUS CHANGED: $current');

      if (current != previous) {
        previous = current;
        yield current;
      }
    }
  }

  Future<bool> isOffline() async {
    try {
      final interfaces = await _connectivity.checkConnectivity();

      debugPrint('NETWORK INTERFACES: $interfaces');

      if (interfaces.isEmpty ||
          interfaces.every((r) => r == ConnectivityResult.none)) {
        debugPrint('NO NETWORK INTERFACE');
        return true;
      }

      final hasInternet = await _hasInternetReachability();

      debugPrint('INTERNET AVAILABLE: $hasInternet');

      return !hasInternet;
    } catch (error, stackTrace) {
      debugPrint('NETWORK CHECK ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);

      return true;
    }
  }

  Future<bool> _hasInternetReachability() async {
    const endpoints = <String>[
      'https://connectivitycheck.gstatic.com/generate_204',
      'https://www.google.com/generate_204',
      'https://www.cloudflare.com/cdn-cgi/trace',
    ];

    for (final endpoint in endpoints) {
      final client = HttpClient()..connectionTimeout = _timeout;

      try {
        debugPrint('CHECKING: $endpoint');

        final request =
            await client.getUrl(Uri.parse(endpoint)).timeout(_timeout);

        request.followRedirects = false;

        final response = await request.close().timeout(_timeout);

        debugPrint(
          'RESPONSE: $endpoint -> ${response.statusCode}',
        );

        if (response.statusCode == HttpStatus.noContent) {
          await response.drain<void>().timeout(_timeout);
          return true;
        }

        if (endpoint.contains('cloudflare.com') &&
            response.statusCode == HttpStatus.ok) {
          final body =
              await response.transform(utf8.decoder).join().timeout(_timeout);

          debugPrint('CLOUDFLARE RESPONSE: $body');

          if (body.contains('ip=') && body.contains('ts=')) {
            return true;
          }
        } else {
          await response.drain<void>().timeout(_timeout);
        }
      } catch (error) {
        debugPrint('ENDPOINT FAILED: $endpoint');
        debugPrint('ERROR: $error');
      } finally {
        client.close(force: true);
      }
    }

    debugPrint('ALL INTERNET CHECKS FAILED');

    return false;
  }
}
