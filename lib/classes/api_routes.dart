class ApiRoutes {
  final String login = 'login';
  final String getUsers = 'users';
  final String createUsers = 'create-user';
  final String deleteUser = 'delete-user';
  
  final String getGroups = 'groups';
  final String createGroup = 'create-group';
  
  final String createTask = 'create-task';
  
  final String getUserProfile = 'show';
  final String getManagerOrAdminProfile = 'managers';
}

createAdminRoute(route) {
  return 'admin/$route';
}

final ApiRoutes apiRoutes = ApiRoutes();
