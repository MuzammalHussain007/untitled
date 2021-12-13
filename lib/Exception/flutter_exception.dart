class FlutterException implements Exception
{
       final String message;

       FlutterException(this.message);

       @override
  String toString() {

    return message;
  }
}