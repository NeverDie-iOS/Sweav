import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewModel: ObservableObject {
    @Published var showLogo = false
    @Published var showMainText = false
    @Published var showSubText = false
    @Published var showLoginButtons = false
    
    @Published var userEmail: String?
    @Published var userNickname: String?
    @Published var loginError: String?
    @Published var isLoggedIn: Bool = false
    
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
    
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                self?.handleKakaoLoginResult(oauthToken: oauthToken, error: error)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                self?.handleKakaoLoginResult(oauthToken: oauthToken, error: error)
            }
        }
    }

    private func handleKakaoLoginResult(oauthToken: OAuthToken?, error: Error?) {
        if let error = error {
            DispatchQueue.main.async {
                self.loginError = error.localizedDescription
            }
            return
        }
        
        UserApi.shared.me { [weak self] (user, error) in
            DispatchQueue.main.async {
                if let user = user {
                    self?.userEmail = user.kakaoAccount?.email
                    self?.userNickname = user.kakaoAccount?.profile?.nickname
                    self?.isLoggedIn = true
                } else {
                    self?.loginError = error?.localizedDescription ?? "Unknown error"
                }
            }
        }
        
    }
}
