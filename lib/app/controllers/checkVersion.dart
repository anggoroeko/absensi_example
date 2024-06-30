import 'package:new_version/new_version.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckVersionController extends GetxController {
  advancedStatusCheck(NewVersion newVersion, BuildContext context) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      if (status.localVersion != status.storeVersion) {
        // debugPrint(status.releaseNotes);
        // debugPrint(status.appStoreLink);
        // debugPrint(status.localVersion);
        // debugPrint(status.storeVersion);
        // debugPrint(status.canUpdate.toString());
        newVersion.showUpdateDialog(
            context: context,
            versionStatus: status,
            dialogTitle: 'Update aplikasi',
            dialogText: 'Anda menggunakan versi ' +
                "${status.localVersion}" +
                " silahkan update ke ${status.storeVersion}",
            allowDismissal: false);
      }
    }
  }

  void checkVersion(BuildContext context) {
    final newVersion = NewVersion(
      iOSId: 'com.exo.absensi',
      androidId: 'com.exo.absensi',
    );

    advancedStatusCheck(newVersion, context);
  }
}
