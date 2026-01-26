import UIKit
import Flutter
import SwiftUI

struct TestControllerView : UIViewControllerRepresentable {
  func updateUIViewController(
    _ uiViewController: UIViewControllerType,
    context: Context
  ) { }
  
  func makeUIViewController(
    context: Context
  ) -> some UIViewController {
    let vc = SomeViewController()
    return vc
  }
}
