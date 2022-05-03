
import 'package:get/get.dart';
import 'package:todo/services/auth_services.dart';

class AuthServicesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthServices>(()=>AuthServices());
  }
}