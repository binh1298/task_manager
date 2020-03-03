class ApiRoutes {
  final String login = '/login';
  final String getUsers = '/users';
  final String createUsers = '/create-user';

  createAdminRoute(route) {
    return '/admin/$route';
  }
}

final ApiRoutes apiRoutes = ApiRoutes();