import 'package:heldis/screens/authentification/data/model/user_model.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';

class GetUserInfoResponseModel {
  UserModel? user;

  GetUserInfoResponseModel({this.user});

  GetUserInfoResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.user != null) {
      data['data'] = this.user!.toJson();
    }
    return data;
  }

  UserEntity? toEntity() {
    return user?.toEntity();
  }
}
