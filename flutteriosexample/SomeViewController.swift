import UIKit
import Flutter
import FlutterPluginRegistrant
import AVFoundation

final class SomeViewController: UIViewController {
  lazy var flutterEngine = FlutterEngine(name: "flutter_engine")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    flutterEngine.run()
    GeneratedPluginRegistrant.register(with: flutterEngine)
    
    view.backgroundColor = .green
    
    let button = UIButton(type: .system)
    button.setTitle("Open Flutter", for: .normal)
    button.addTarget(self, action: #selector(openFlutter), for: .touchUpInside)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  @objc private func openFlutter() {
    let flutterVC = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    let channel = FlutterMethodChannel(name: "dataspikemobilesdk", binaryMessenger: flutterVC.binaryMessenger)
    
    flutterVC.modalPresentationStyle = .fullScreen
    flutterVC.view.backgroundColor = .white
    
    channel.setMethodCallHandler { call, result in
      if call.method == "onVerificationCompleted" {
        if let args = call.arguments as? [String: String] {
          print("✅ verification completed:", args)
          if args["status"] == "Completed" {
            flutterVC.dismiss(animated: true, completion: nil)
          }
        }
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    
    present(flutterVC, animated: true) {
      channel.invokeMethod("startDataspikeFlow", arguments: [
        "dsApiToken": "YOUR_TOKEN",
        "shortId": "YOUR_SHORT_ID",
        "isDebug": true // false depends on impl
      ])
    }
  }
}
