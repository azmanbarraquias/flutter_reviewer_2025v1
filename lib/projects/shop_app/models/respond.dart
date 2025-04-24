// sample respond
class UserCredential {
  final AdditionalUserInfo additionalUserInfo;
  final dynamic
  credential; // Could be specified more clearly depending on the use case
  final User user;

  UserCredential({
    required this.additionalUserInfo,
    required this.credential,
    required this.user,
  }) {
    UserCredential(
      additionalUserInfo: AdditionalUserInfo(
        isNewUser: true,
        profile: {},
        providerId: null,
        username: null,
        authorizationCode: null,
      ),
      credential: null,
      user: User(
        displayName: null,
        email: 'test@test.com',
        isEmailVerified: false,
        isAnonymous: false,
        metadata: UserMetadata(
          creationTime: '2024 - 08 - 22 04:47:00.102Z',
          lastSignInTime: '2024 - 08 - 22 04:47:00.102Z',
        ),
        phoneNumber: null,
        photoURL: null,
        providerData: [
          UserInfo(
            displayName: null,
            email: 'test@test.com',
            phoneNumber: null,
            photoURL: null,
            providerId: 'password',
            uid: 'test@test.com',
          ),
        ],
        refreshToken: null,
        tenantId: null,
        uid: 'qubUOpMm5QhzRb0mYhglgTTX2w72',
      ),
    );
  }
}

class AdditionalUserInfo {
  final bool isNewUser;
  final Map<String, dynamic> profile;
  final String? providerId;
  final String? username;
  final String? authorizationCode;

  AdditionalUserInfo({
    required this.isNewUser,
    required this.profile,
    this.providerId,
    this.username,
    this.authorizationCode,
  });
}

class User {
  final String? displayName;
  final String? email;
  final bool isEmailVerified;
  final bool isAnonymous;
  final UserMetadata metadata;
  final String? phoneNumber;
  final String? photoURL;
  final List<UserInfo> providerData;
  final String? refreshToken;
  final String? tenantId;
  final String uid;

  User({
    this.displayName,
    this.email,
    required this.isEmailVerified,
    required this.isAnonymous,
    required this.metadata,
    this.phoneNumber,
    this.photoURL,
    required this.providerData,
    this.refreshToken,
    this.tenantId,
    required this.uid,
  });
}

class UserMetadata {
  final String creationTime;
  final String lastSignInTime;

  UserMetadata({required this.creationTime, required this.lastSignInTime});
}

class UserInfo {
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final String providerId;
  final String uid;

  UserInfo({
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    required this.providerId,
    required this.uid,
  });
}
