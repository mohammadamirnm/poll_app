import 'package:easy_localization/easy_localization.dart';
import 'package:poll_app/src/exceptions/failure.dart';

class PollRequestFailed implements Failure {
  @override
  String? get message => 'label_network_failure'.tr();
}
