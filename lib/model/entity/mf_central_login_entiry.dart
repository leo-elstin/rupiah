class MFCentralEntity {
  final String token;
  final int notificationCount;
  final String? redirectPath;
  final bool isLoggedOut;
  final bool isLoggedIn;
  final bool firstTimeLoggedIn;
  final bool enableTwoFactorAuth;
  final bool appTourVisited;
  final bool enabledPin;
  final bool isFromPreLogin;
  final String backupPin;
  final String newToMF;
  final String reqId;
  final String pekrn;
  final String displayName;
  final String userRegisteredWith;
  final String ftTransactions;
  final String otmRegistration;
  final String message;
  final String showPopUp;
  final String email;
  final String mobile;
  final String displayMobile;
  final String pan;

  MFCentralEntity({
    required this.token,
    required this.notificationCount,
    this.redirectPath,
    required this.isLoggedOut,
    required this.isLoggedIn,
    required this.firstTimeLoggedIn,
    required this.enableTwoFactorAuth,
    required this.appTourVisited,
    required this.enabledPin,
    required this.isFromPreLogin,
    required this.backupPin,
    required this.newToMF,
    required this.reqId,
    required this.pekrn,
    required this.displayName,
    required this.userRegisteredWith,
    required this.ftTransactions,
    required this.otmRegistration,
    required this.message,
    required this.showPopUp,
    required this.email,
    required this.mobile,
    required this.displayMobile,
    required this.pan,
  });

  factory MFCentralEntity.fromJson(Map<String, dynamic> json) {
    return MFCentralEntity(
      token: json['token'],
      notificationCount: json['notificationCount'],
      redirectPath: json['redirectPath'],
      isLoggedOut: json['isLoggedOut'],
      isLoggedIn: json['isLoggedIn'],
      firstTimeLoggedIn: json['firstTimeLoggedIn'],
      enableTwoFactorAuth: json['enableTwoFactorAuth'],
      appTourVisited: json['appTourVisited'],
      enabledPin: json['enabledPin'],
      isFromPreLogin: json['isFromPreLogin'],
      backupPin: json['backupPin'],
      newToMF: json['newToMF'],
      reqId: json['reqId'],
      pekrn: json['pekrn'],
      displayName: json['displayName'],
      userRegisteredWith: json['userRegisteredWith'],
      ftTransactions: json['ftTransactions'],
      otmRegistration: json['otmRegistration'],
      message: json['message'],
      showPopUp: json['showPopUp'],
      email: json['email'],
      mobile: json['mobile'],
      displayMobile: json['displayMobile'],
      pan: json['pan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'notificationCount': notificationCount,
      'redirectPath': redirectPath,
      'isLoggedOut': isLoggedOut,
      'isLoggedIn': isLoggedIn,
      'firstTimeLoggedIn': firstTimeLoggedIn,
      'enableTwoFactorAuth': enableTwoFactorAuth,
      'appTourVisited': appTourVisited,
      'enabledPin': enabledPin,
      'isFromPreLogin': isFromPreLogin,
      'backupPin': backupPin,
      'newToMF': newToMF,
      'reqId': reqId,
      'pekrn': pekrn,
      'displayName': displayName,
      'userRegisteredWith': userRegisteredWith,
      'ftTransactions': ftTransactions,
      'otmRegistration': otmRegistration,
      'message': message,
      'showPopUp': showPopUp,
      'email': email,
      'mobile': mobile,
      'displayMobile': displayMobile,
      'pan': pan,
    };
  }
}

class Matched {
  final String amc;
  final String amcName;
  final dynamic folio;
  final String isDemat;

  Matched({
    required this.amc,
    required this.amcName,
    required this.folio,
    required this.isDemat,
  });

  factory Matched.fromJson(Map<String, dynamic> json) {
    return Matched(
      amc: json['amc'],
      amcName: json['amcName'],
      folio: json['folio'],
      isDemat: json['isDemat'],
    );
  }
}

class Persist {
  final int version;
  final bool rehydrated;

  Persist({
    required this.version,
    required this.rehydrated,
  });

  factory Persist.fromJson(Map<String, dynamic> json) {
    return Persist(
      version: json['version'],
      rehydrated: json['rehydrated'],
    );
  }
}
