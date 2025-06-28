// ignore: constant_identifier_names
enum TypeTitle { Adicionar, Atualizar }

abstract class NotificationRepository {
  String message();
  String title();
}

class RegisterNotification implements NotificationRepository {
  @override
  String message() => 'Registrado com sucesso';

  @override
  String title() => TypeTitle.Adicionar.toString();
}

class UpdateNotification implements NotificationRepository {
  @override
  String message() => 'Atualizado com sucesso';

  @override
  String title() => TypeTitle.Atualizar.toString();
}
