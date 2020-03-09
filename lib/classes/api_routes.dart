class ApiRoutes {
  final String login = 'login';
  final String getUsers = 'users';
  final String createUsers = 'create-user';
  final String deleteUser = 'delete-user';
  
  final String getGroups = 'groups';
  final String createGroup = 'create-group';
  final String getGroupMembers = 'group-members';

  final String getTasks = 'tasks';
  final String createTask = 'create-task';
  
  final String getUserProfile = 'show';
  
  final String getManagerOrAdminDetails = 'managers';
  final String getManagerOrEmployeeDetails = 'employees';
}

createAdminRoute(route) {
  return 'admin/$route';
}

final ApiRoutes apiRoutes = ApiRoutes();
