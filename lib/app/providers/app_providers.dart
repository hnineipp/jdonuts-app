import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/network_info.dart';

final networkInfoProvider = Provider<NetworkInfo>(
  (ref) => NetworkInfo(Connectivity()),
);

final isOfflineProvider = StreamProvider<bool>(
  (ref) => ref.watch(networkInfoProvider).offlineChanges,
);
