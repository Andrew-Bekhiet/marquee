import 'dart:async';

import 'package:flutter/widgets.dart';

extension StreamAsListenable<T> on Stream<T> {
  Listenable asListenable() {
    final listenable = ValueNotifier<T?>(null);

    listen(
      (u) => listenable.value = u,
      onDone: listenable.dispose,
    );

    Future.microtask(() => listenable.value = null);

    return listenable;
  }
}
