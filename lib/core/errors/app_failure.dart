sealed class AppFailure {
  const AppFailure(this.message, {this.cause, this.stackTrace});
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message);
}

final class StorageFailure extends AppFailure {
  const StorageFailure(super.message, {super.cause, super.stackTrace});
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure(super.message, {super.cause, super.stackTrace});
}

final class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure([super.message = 'You are not authorized.']);
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure(super.message, {super.cause, super.stackTrace});
}
