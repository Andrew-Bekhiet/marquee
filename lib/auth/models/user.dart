import 'package:equatable/equatable.dart';

class User({
  required final String uid,
  required final String email,
  required final String name,
}) with Equatable {
  @override
  List<Object?> get props => [uid, email, name];
}
