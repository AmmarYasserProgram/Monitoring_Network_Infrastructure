
class PortScanModel {
  final String host;
  final String ports;
  int openPorts = 0;
  int closedPorts = 0;
  List<PortStatus> data =[];
  PortScanModel({required this.host,required this.ports, this.data = const [],this.openPorts = 0,this.closedPorts = 0});
  factory PortScanModel.from_json(Map<String,dynamic> data){
    return PortScanModel(
        host: data["host"],
        ports: data["ports"],
        openPorts: data['opened'],
        closedPorts: data["closed"],
        data: (data["data"] as List).map((i)=> PortStatus.from_json(i)).toList()
    );
  }
}

class PortStatus {
  final int port;
  final String status;

  PortStatus({required this.port, required this.status});
  factory PortStatus.from_json(Map<String,dynamic> data) {
    return PortStatus(port: data["port"], status: data["status"]);
  }

}