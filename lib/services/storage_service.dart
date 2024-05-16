import 'package:get_storage/get_storage.dart';

class StorageService {
  final box = GetStorage();

  // Save my last location
  saveVariable({required String key, required var value}) {
    box.write(key, value);
  }

  // Save my last location
  String? readVariable({required String key}) {
    return box.read(key);
  }

  // clear auth User data
  clearStorage() {}

  // get auth User data
  // UserModel? getUser() {
  //   return box.read<UserModel?>('user');
  // }

  // // update auth User data
  // Future<void> updateUser({required UserModel user}) async {
  //   await box.write('user', user);
  //   box.write('idUser', user.id ?? "");
  //   box.write('nameUser', user.name ?? "");
  //   box.write('emailUser', user.email ?? "");
  //   box.write("roleId", user.roleId ?? "");
  //   box.write("lastName", user.lastname ?? "");
  //   box.write("firstName", user.firstname ?? "");
  //   box.write("role", user.role ?? "");
  // }

  // // set auth User data
  // storeUser({
  //   required UserModel user,
  //   required String token,
  // }) {
  //   box.write('idUser', user.id ?? "");
  //   box.write('nameUser', user.name ?? "");
  //   box.write('emailUser', user.email ?? "");
  //   box.write("roleId", user.roleId ?? "");
  //   box.write("lastName", user.lastname ?? "");
  //   box.write("firstName", user.firstname ?? "");
  //   box.write("role", user.role ?? "");
  //   box.write('token', token);
  //   box.write('phone', user.phone);
  //   box.write(
  //       'codePays',
  //       user.phoneWithPrefix!
  //           .replaceFirst("+", "")
  //           .replaceFirst(user.phone!, ""));
  // }
}
