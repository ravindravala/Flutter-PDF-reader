class FileInfo {
  final String name;
  final String path;

  FileInfo({required this.name, required this.path});

  String get folder {
    var data = path.split("/");
    return  data[data.length - 2];
  }
}
