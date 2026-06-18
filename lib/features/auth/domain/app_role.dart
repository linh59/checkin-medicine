enum AppRole {
  admin,
  user
}

extension AppRoleX on String {
  AppRole? toAppRole() {
    switch (this) {
      case 'admin':
        return AppRole.admin;
      case 'user':
        return AppRole.user;

      default:
        return null;
    }
  }
}