import 'package:event_bus/event_bus.dart';

class EventBusManager {
  // 工厂模式
  factory EventBusManager() => _getInstance();

  static EventBusManager get instance => _getInstance();
  static EventBusManager _instance;
  static EventBus eventBus;

  EventBusManager._internal() {
    // 初始化
  }

  static EventBusManager _getInstance() {
    if (_instance == null) {
      _instance = new EventBusManager._internal();
    }
    return _instance;
  }

  static EventBus getEventBus() {
    if (eventBus == null) {
      eventBus = new EventBus();
    } else {
      return eventBus;
    }
    return eventBus;
  }
}
