import 'package:quiz_pod_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
class EmailIdpEndpoint extends EmailIdpBaseEndpoint {
  @override
  Future<AuthSuccess> finishRegistration(
    Session session, {
    required String registrationToken,
    required String password,
    UserScopes? role,
  }) async {
    final authSuccess = await super.finishRegistration(
      session,
      registrationToken: registrationToken,
      password: password,
    );

    if (role != null) {
      await AppUserProfile.db.insertRow(
        session,
        AppUserProfile(
          authUserId: authSuccess.authUserId,
          role: role,
        ),
      );
    }

    return authSuccess;
  }
}
