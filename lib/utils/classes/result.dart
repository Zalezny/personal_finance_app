/// A class that represents the result of an operation that can either succeed 
/// or fail.
sealed class Result<S, E extends Exception> {
  const Result();
}
/// A class that represents the result of an operation that succeeded.
final class Success<S, E extends Exception> extends Result<S, E> {
  /// Creates a Success.
  const Success(this.value);
  /// The value of the operation.
  final S value;
}

/// A class that represents the result of an operation that failed.
final class Failure<S, E extends Exception> extends Result<S, E> {
  /// Creates a Failure.
  const Failure(this.exception);
  /// The exception that caused the operation to fail.
  final E exception;
}
