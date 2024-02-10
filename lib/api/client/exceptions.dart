abstract class HttpRequestException implements Exception {}

class NoInternetException implements HttpRequestException {}

class ServerNotRespondingException implements HttpRequestException {}

class HttpErrorException implements HttpRequestException {
  static const Map<int, String> _errorCodeNames = {
    400: 'Bad Request',
    500: 'Internal Server Error',
    401: 'Unauthorized',
    403: 'Forbidden',
    502: 'Bad Gateway',
    404: 'Resource not found',
  };

  final int errorCode;
  final String errorMessage;

  HttpErrorException({
    required this.errorCode,
    required this.errorMessage,
  });

  @override
  String toString() {
    return '${_errorCodeToString(errorCode)}.\n'
            '$errorMessage'
        .trim();
  }

  String _errorCodeToString(int statusCode) {
    return _errorCodeNames.containsKey(statusCode)
        ? '$statusCode: ${_errorCodeNames[statusCode]}'
        : 'Error $statusCode';
  }
}
