import 'package:crafty_bay/api/api_caller.dart';
import 'package:crafty_bay/api/api_response.dart';
import 'package:crafty_bay/auth/controllers/auth_controller.dart';
import 'package:crafty_bay/users/models/customer_model.dart';
import 'package:crafty_bay/utilities/urls.dart';
import 'package:get/get.dart';

class ReadUserProfileController extends GetxController {
  bool _inProgress = false;
  bool _hasProfileData = true;

  final AuthController _authController = Get.find<AuthController>();

  bool get inProgress => _inProgress;
  bool get hasProfileData => _hasProfileData;

  Future<bool> readProfile() async {
    _inProgress = true;
    update();

    ApiResponse res = await ApiCaller().apiGetRequest(
      url: Urls.readProfile,
      token: AuthController.token.toString(),
    );

    _inProgress = false;
    update();

    if (res.isSuccess) {
      if (res.jsonResponse['data'] == null ||
          res.jsonResponse['data'].isEmpty) {
        _hasProfileData = false;
      } else {
        CustomerModel customerModel =
            CustomerModel.fromJson(res.jsonResponse['data']);
        await _authController.saveCustomerData(model: customerModel);
      }

      return true;
    } else {
      return false;
    }
  }
}
