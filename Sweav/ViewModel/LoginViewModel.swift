import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var showLogo = false
    @Published var showMainText = false
    @Published var showSubText = false
    @Published var showLoginButtons = false
    
    func startAnimations() {
        withAnimation(.easeInOut(duration: 0.6)) {
            showLogo = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.easeInOut(duration: 0.6)) {
                self.showMainText = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            withAnimation(.easeInOut(duration: 0.6)) {
                self.showSubText = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
            withAnimation(.easeInOut(duration: 0.6)) {
                self.showLoginButtons = true
            }
        }
    }
}
