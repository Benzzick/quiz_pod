import 'package:quiz_pod_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<AppUserProfile> updateUserRole(
    Session session,
    UserScopes role,
  ) async {
    final authenticated = session.authenticated;
    if (authenticated == null) {
      throw FormatException('User is not authenticated.');
    }

    final profile = await AppUserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authenticated.authUserId),
    );

    if (profile == null) {
      return await AppUserProfile.db.insertRow(
        session,
        AppUserProfile(
          authUserId: authenticated.authUserId,
          role: role,
        ),
      );
    }
    final updatedProfile = profile.copyWith(role: role);
    return await AppUserProfile.db.updateRow(session, updatedProfile);
  }

  Future<AppUserProfile?> getUserProfile(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return null;

    return await AppUserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
  }
}
