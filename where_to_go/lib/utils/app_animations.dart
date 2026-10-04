import "package:animations/animations.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

CustomTransitionPage<T> buildSharedAxisPage<T>({required GoRouterState state, required Widget child}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.vertical,
        fillColor: Colors.transparent,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
    reverseTransitionDuration: const Duration(milliseconds: 500),
  );
}
