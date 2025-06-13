import SwiftUI
import Alamofire
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import SwiftKeychainWrapper

class LoginViewModel: ObservableObject {
    @Published var navigationState: NavigationState?
    
    enum NavigationState: Identifiable {
        case onboarding
        case main
        
        var id: String { "\(self)" }
    }
    
    
    @Published var showLogo = false
    @Published var showMainText = false
    @Published var showSubText = false
    @Published var showLoginButtons = false
    
    @Published var loginError: String?
    
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
    
    
    // MARK: - 카카오 로그인
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
        
        guard let accessToken = oauthToken?.accessToken else {
            DispatchQueue.main.async {
                self.loginError = "카카오 토큰이 없습니다."
            }
            return
        }
        
        sendKakaoTokenToServer(accessToken: accessToken)
    }
    
    private func sendKakaoTokenToServer(accessToken: String) {
        let url = "http://ec2-54-253-28-13.ap-southeast-2.compute.amazonaws.com:8081/auth/login/kakao"
        let headers: HTTPHeaders = ["KakaoAccessToken": accessToken]
        
        AF.request(url, method: .post, headers: headers)
            .responseDecodable(of: AuthLoginKakaoResponse.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                        case .success(let authResponse):
                            KeychainWrapper.standard.set(authResponse.data.accessToken, forKey: "accessToken")
                            UserDefaults.standard.set(authResponse.data.profileImgUrl, forKey: "profileImageUrl")
                            UserDefaults.standard.set(authResponse.data.profileImgDefault, forKey: "profileImgDefault")
                            
                            if !authResponse.data.onboardingComplete {
                                self.navigationState = .onboarding
                            } else {
                                // Expired refreshtoken && complete onboarding
                                // TODO: Navigate to Main View
                            }
                            
                            
                        case .failure(let error):
                            print("카카오 로그인 실패: \(error)")
                            self.loginError = error.localizedDescription
                    }
                }
            }
    }
    
    
}
