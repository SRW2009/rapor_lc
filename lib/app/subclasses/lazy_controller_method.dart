
import 'package:flutter/material.dart';
import 'package:rapor_lc/common/enum/request_status.dart';

mixin LazyControllerMethod {
  void onResponseStatus(BuildContext context, String action, RequestStatus status, Function() onSuccess) {
    if (status == RequestStatus.success) {
      onSuccess();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please wait...')));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to $action.')));
  }
}