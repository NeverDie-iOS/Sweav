import SwiftUI
enum MainRoute: String, Hashable{
    case main = "MainView"
}

struct MainView: View {
    var body: some View {
        Text("Main View")
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainView()
}
