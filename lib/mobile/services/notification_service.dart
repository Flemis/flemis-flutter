import 'package:flemis/mobile/models/api_response.dart';
import 'package:flemis/mobile/services/default_service.dart';

class NotificationService extends DefaultService {
  Future<APIResponse> fetchNotifications(String userId) async {
    String url = "${DefaultService.envUrl}/notifications/$userId";
    try {
      final response = await super.get(url);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final parsedResponse = parseResponse(response);

        return APIResponse(
            status: parsedResponse.status, result: parsedResponse.result);
      } else {
        final parsedResponse = parseResponse(response);
        return APIResponse(
          status: parsedResponse.status,
          message: parsedResponse.message,
          result: [],
        );
      }
      // ignore: empty_catches
    } catch (e) {
      return APIResponse(
        status: 500,
        message:
            "Error while trying to load your notifications. Please, try again!",
      );
    }
  }
}
