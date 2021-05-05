class Profile {
  late String apiDomain;
  late String fileDomain;

  static final Profile _instance = Profile.test();

  factory Profile() {
    return _instance;
  }

  Profile.test() {
    apiDomain = 'http://192.168.31.116:8080';
    fileDomain = 'http://192.168.31.116:8080/upload';
  }
}

class ErorMessage {
  static final String service =
      'Sorry, we are having some temporary server issue. Please try again later.';
}
