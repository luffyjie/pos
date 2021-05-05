class ChannelModel {
  String? largeChannel;
  List<SubChannelModel>? channelList;

  ChannelModel.fromJson(Map<String, dynamic> json) {
    largeChannel = json['largeChannel'];
    var data = json['channelList'];
    if (data is List) {
      channelList =
          data.map((value) => SubChannelModel.fromJson(value)).toList();
    }
  }
}

class SubChannelModel {
  String? channelName;
  String? channelLogo;
  int? channelId;
  int? hasEnabled;

  SubChannelModel.fromJson(Map<String, dynamic> json) {
    channelName = json['channelName'];
    channelLogo = json['channelLogo'];
    channelId = json['channelId'];
    hasEnabled = json['hasEnabled'];
  }
}
