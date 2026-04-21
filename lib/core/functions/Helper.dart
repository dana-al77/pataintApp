class ApiHelper {
  static String getMessage(Map response) {
    if (response['error'] != null &&
        response['error'].toString().isNotEmpty) {
      return response['error'];
    }

    if (response['message'] is String &&
        response['message'].toString().isNotEmpty) {
      return response['message'];
    }

    if (response['message'] is List &&
        (response['message'] as List).isNotEmpty) {
      return (response['message'] as List).join(", ");
    }

    return "حدث خطأ";
  }
}