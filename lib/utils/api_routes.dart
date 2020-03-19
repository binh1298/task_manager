import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/utils/secure_storage.dart';

class ApiRoutes {
  final String dashboard = 'dashboard';
  
  final String login = 'login';
  final String getUsers = 'users';
  final String createUsers = 'create-user';
  final String deleteUser = 'delete-user';

  final String getGroups = 'groups';
  final String createGroup = 'create-group';

  final String getGroupMembers = 'group-members';
  final String addGroupMember = 'add-group-member';
  
  final String getTasks = 'tasks';
  final String getTasksToReview = 'tasks-review';
  final String createTask = 'create-task';
  final String updateTask = 'update-task';
  
  final String getUserProfile = 'show';
  final String changeAvatar = 'update-avatar-user';
  
  final String getManagerOrAdminDetails = 'managers';
  final String getManagerOrEmployeeDetails = 'employees';
}

createRoleRoute(route) async {
  UserDetails user = await getUserFromToken();
  return '${user.roleName}/$route';
}

final ApiRoutes apiRoutes = ApiRoutes();
