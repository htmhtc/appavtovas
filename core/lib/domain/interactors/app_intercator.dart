import 'package:core/avtovas_core.dart';

final class AppIntercator {
  final ILocalAuthorizationRepository _authorizationRepository;
  final IUserRepository _userRepository;

  AppIntercator(
    this._authorizationRepository,
    this._userRepository,
  );

  Stream<bool> get remoteConnectionStream =>
      _userRepository.remoteConnectionStream;

  String get userUuid => _authorizationRepository.userUuid;

  Future<void> fetchUser(String userUuid) {
    return _userRepository.fetchUser(userUuid);
  }

  void saveUserLocally(String userUuid) {
    _authorizationRepository.authorize(userUuid);
  }
}