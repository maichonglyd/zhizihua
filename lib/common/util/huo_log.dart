enum HuoLogLevel {
  Debug,
  Info,
  Warn,
  Error,
  None
}
/// 通用日志打印控制
///
class HuoLog {
  static HuoLogLevel _level = HuoLogLevel.Debug;

  static void setLevel(HuoLogLevel level) {
    _level = level;
  }

  static d(Object content) {
    if (_level.index <= HuoLogLevel.Debug.index) {
      print("huolog:${content}");
    }
  }
  static i(Object content) {
    if (_level.index <= HuoLogLevel.Info.index) {
      print("huolog:${content}");
    }
  }
  static w(Object content) {
    if (_level.index <= HuoLogLevel.Warn.index) {
      print("huolog:${content}");
    }
  }
  static e(Object content) {
    if (_level.index <= HuoLogLevel.Warn.index) {
      print("huolog:${content}");
    }
  }
}
