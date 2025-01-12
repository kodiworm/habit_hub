
const String timeoutError = "Connection Timeout";
const String socketError = "Connection to server failed";
const String somethingWentWrong = 'Something Went Wrong, Try Again!';
const String unauthorizedError = 'Forbidden! Unauthorized Request';

const requestDuration = Duration(seconds: 60);

class ApiResponse {
  Map<String, dynamic>? data;
  String? error;
  Map<String, dynamic>? result;
}

    int accountType = 4;
var headers = {
  'Accept': 'application/json',
  // 'Authorization': 'Bearer $getAccessToken'
};

const String baseUrl = "http://localhost";
const String apiUrl ="$baseUrl/api";
const String loginUrl ="$apiUrl/auth/login";
const String registerUrl ="$apiUrl/auth/register";
