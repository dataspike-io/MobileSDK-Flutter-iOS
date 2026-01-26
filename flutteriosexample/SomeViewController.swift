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
        "dsApiToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiJvMzU0ZDUyZjlmZDQzNDMyIiwidHBlIjowLCJhcCI6bnVsbCwicyI6IjFmMDc0OGZmLWExY2QtNmE5OS1iMjBlLTFmMWU1MzU2YmI3YiIsImlzcyI6ImRhdGFzcGlrZS5pbyJ9.6KGLVIUScny77MthbXDM9Rg8zd7on-zT3fCpPLp27_4",
        "shortId": "VBB1DB6C98EB4E650",
        "isDebug": true // false depends on impl
      ])
    }
  }
}
