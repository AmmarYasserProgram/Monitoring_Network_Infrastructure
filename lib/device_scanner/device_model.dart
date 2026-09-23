class DeviceModel {
  int online;
  int offline;
  List<DeviceState> data = [];

  DeviceModel({
    required this.online,
    required this.offline,
    this.data = const [],
  });
  Map<String , dynamic> asd = {
    "name":"asd"
  };

  factory DeviceModel.from_json(Map<String, dynamic> data) {
    return DeviceModel(
      online: data["online"],
      offline: data["offline"],
      data: (data["data"] as List).map((i) => DeviceState.from_json(i)).toList(),
    );
  }
}

class DeviceState {
  final String ip;
  final bool state;

  DeviceState({
    required this.ip,
    required this.state
  });

  factory DeviceState.from_json(Map<String, dynamic> data) {
    return DeviceState(
        ip: data["host"],
        state: data["status"]
    );
  }
}
