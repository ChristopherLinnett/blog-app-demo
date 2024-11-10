import 'package:blogapp_flutter/core/typedefs/async_result.dart';
import 'package:blogapp_flutter/core/typedefs/usecases.dart';

import '../../data/models/response_message.dart';
import '../repos/auth_repo.dart';

class Logout extends UsecaseWithoutParams<ResponseMessage> {
  final AuthRepo repo;

  Logout(this.repo);

  @override
  AsyncResult<ResponseMessage> call() async {
    return await repo.logout();
  }
}
