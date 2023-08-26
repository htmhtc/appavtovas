import 'package:core/data/data_sources/interfaces/i_secured_storage_data_source.dart';
import 'package:core/domain/interfaces/i_local_authorization_repository.dart';
import 'package:rxdart/rxdart.dart';

final class LocalAuthorizationRepository
    implements ILocalAuthorizationRepository {
  final ISecuredStorageDataSource _securedStorageDataSource;

  LocalAuthorizationRepository(this._securedStorageDataSource) {
    checkAuthorizationStatus();
  }

  final BehaviorSubject<String> _userAuthorizationSubject = BehaviorSubject();

  @override
  Stream<String> get userAuthorizationStream => _userAuthorizationSubject;

  @override
  String get userUuid =>
      _userAuthorizationSubject.hasValue ? _userAuthorizationSubject.value : '';

  @override
  bool get isAuthorized =>
      _userAuthorizationSubject.hasValue &&
      _userAuthorizationSubject.value.isNotEmpty;

  @override
  void authorize(String userUuid) {
    _securedStorageDataSource.saveEncryptedUserUuid(userUuid);
    _userAuthorizationSubject.add(userUuid);
  }

  @override
  void deAuthorize() {
    _securedStorageDataSource.saveEncryptedUserUuid('');
    _userAuthorizationSubject.add('');
  }

  @override
  Future<void> checkAuthorizationStatus() async {
    final userUuid = await _securedStorageDataSource.getEncryptedUserUuid();

    if (userUuid != null) {
      _userAuthorizationSubject.add(userUuid);
    } else {
      _userAuthorizationSubject.add('');
    }
  }
}