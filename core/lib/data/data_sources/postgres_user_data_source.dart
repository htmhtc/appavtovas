import 'package:core/avtovas_core.dart';
import 'package:core/data/utils/sql_support/sql_fields.dart';
import 'package:core/data/utils/sql_support/sql_requests.dart';
import 'package:core/domain/utils/core_logger.dart';
import 'package:rxdart/rxdart.dart';

final class PostgresUserDataSource implements IPostgresUserDataSource {
  final IPostgresConnection _postgresConnection;

  PostgresUserDataSource(
    this._postgresConnection,
  );

  final BehaviorSubject<User> _userSubject = BehaviorSubject.seeded(
    const User.unauthorized(),
  );

  @override
  Stream<User> get userStream => _userSubject;

  @override
  Stream<bool> get remoteConnectionStream =>
      _postgresConnection.postgresConnectionStream;

  @override
  Future<void> addUser(User user) async {
    if (_postgresConnection.hasConnection) {
      final userForAdding = user.phoneNumber.contains('+')
          ? user
          : user.copyWith(
              phoneNumber: '+${user.phoneNumber}',
            );

      final query = SQLRequests.insertInto(
        tableName: PrivateInfo.usersTableName,
        fields: SQLFields.addUserFields(userForAdding),
      );

      final queryResult = await _postgresConnection.connection.query(query);

      _userSubject.add(userForAdding);

      CoreLogger.log(
        'Query was sent successfully',
        params: {
          'Result query': queryResult,
        },
      );
    } else {
      CoreLogger.log(
        'No have connection to Postgres',
        params: {'User for adding': user},
      );
    }
  }

  @override
  Future<User> fetchUser(String userUuid) async {
    if (_postgresConnection.hasConnection) {
      final query = SQLRequests.selectSingle(
        tableName: PrivateInfo.usersTableName,
        fields: SQLFields.selectUserByIdFields(userUuid),
      );

      final queryResult =
          await _postgresConnection.connection.mappedResultsQuery(query);

      if (queryResult.isEmpty) {
        CoreLogger.log(
          'User with this uuid ($userUuid) was not found',
          params: {
            'Result query': queryResult,
          },
        );

        return const User.unfounded();
      } else {
        final user = UserMapper().fromJson(
          queryResult.first['users']!,
          fromPostgres: true,
        );

        CoreLogger.log(
          'Query was sent successfully',
          params: {
            'Result query': queryResult,
          },
        );

        _userSubject.add(user);

        return user;
      }
    } else {
      CoreLogger.log(
        'No have connection to Postgres',
        params: {'Uuid for select': userUuid},
      );

      return const User.unauthorized();
    }
  }

  @override
  Future<User> fetchUserByPhone(String phoneNumber) async {
    if (_postgresConnection.hasConnection) {
      final query = SQLRequests.selectSingle(
        tableName: PrivateInfo.usersTableName,
        fields: SQLFields.selectUserByPhoneFields(phoneNumber),
      );

      final queryResult =
          await _postgresConnection.connection.mappedResultsQuery(query);

      if (queryResult.isEmpty) {
        CoreLogger.log(
          'User with this phone ($phoneNumber) was not found',
          params: {
            'Result query': queryResult,
          },
        );

        return const User.unfounded();
      } else {
        final user = UserMapper().fromJson(
          queryResult.first['users']!,
          fromPostgres: true,
        );

        _userSubject.add(user);

        CoreLogger.log(
          'Query was sent successfully',
          params: {
            'Result query': queryResult,
          },
        );

        return user;
      }
    } else {
      CoreLogger.log(
        'No have connection to Postgres',
        params: {'Phone for select': phoneNumber},
      );

      return const User.unauthorized();
    }
  }

  @override
  Future<void> updateUser(String userUuid, User user) {
    throw UnimplementedError();
  }
}