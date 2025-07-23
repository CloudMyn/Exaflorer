import 'dart:isolate';

class IsolateService {
  final ReceivePort receivePort;
  final ReceivePort errorPort;
  final SendPort isolateSendPort;

  IsolateService({
    required this.receivePort,
    required this.errorPort,
    required this.isolateSendPort,
  });

  /// Function to run single task in created [Isolate].
  ///  Arguments:
  ///   - task is a async `callback`, task will execute inside [Isolate]
  ///   the task has given must be a `top-level` Function
  ///   or `static` function inside a class
  ///   - data is an `arguments` for task
  ///
  /// note: after task completed the response port will automatically close,
  ///   but you still need to terminate the isolate
  Future<dynamic> run<T>(
    Function(T) task,
    T arguments,
  ) async {
    ReceivePort responsePort = ReceivePort();

    this.listenError(responsePort);

    var handleMessage = IsolateHandler(
      port: responsePort.sendPort,
      task: task,
      data: arguments,
    );

    isolateSendPort.send(handleMessage);

    List<dynamic> result = await responsePort.first;

    responsePort.close();

    return result[0];

    // ...
  }

  Future<void> listenError(ReceivePort responsePort) async {
    await for (var data in this.errorPort) {
      responsePort.close();
      this.terminateIsolate();

      String msg = data.toString();

      if (data is List) msg = data[0].toString();

      throw Exception(msg);
    }
  }

  /// Method for terminate `Isolate` and close comunication `port`
  void terminateIsolate() {
    receivePort.close();
    errorPort.close();
    Isolate(isolateSendPort).kill(priority: Isolate.immediate);
  }

  // ...
}

// Isolate provider is a class for create new isolate
// for doing expensive computation
class IsolateProvider {
  List<SendPort> isolatePorts = [];

  Future<IsolateService> createIsolate() async {
    ReceivePort _receivePort = new ReceivePort();
    ReceivePort _errorPort = new ReceivePort();

    Isolate.spawn(
      _spawnIsolate,
      _receivePort.sendPort,
      onError: _errorPort.sendPort,
    );

    SendPort isolateSendPort = await _receivePort.first;

    isolatePorts.add(isolateSendPort);

    return IsolateService(
      receivePort: _receivePort,
      errorPort: _errorPort,
      isolateSendPort: isolateSendPort,
    );
  }

  static void _spawnIsolate(SendPort mainIsolate) async {
    ReceivePort isolatePort = ReceivePort();

    mainIsolate.send(isolatePort.sendPort);

    await for (IsolateHandler handler in isolatePort) {
      dynamic data = await handler.task(handler.data);

      handler.port.send([data ?? 'no-data', isolatePort.sendPort]);
    }
  }

  /// Method for terminate creates `isolates`
  void terminateIsolates() {
    for (SendPort isp in isolatePorts) {
      Isolate(isp).kill(priority: Isolate.immediate);
    }
    isolatePorts = [];
  }

  // ...
}

class IsolateHandler {
  final SendPort port;
  final Function task;
  final dynamic data;

  IsolateHandler({
    required this.port,
    required this.task,
    required this.data,
  });
}
