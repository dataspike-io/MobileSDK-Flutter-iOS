import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      NavigationStack {
        VStack(spacing: 20) {
          NavigationLink("Open TestViewController") {
            TestControllerView()
          }
        }
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
