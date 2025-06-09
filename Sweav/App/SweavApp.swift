import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct SweavApp: App {
    init() {
        let appKey = (Bundle.main.infoDictionary?["KAKAO_NATIVE_APPKEY"]) as! String
        KakaoSDK.initSDK(appKey: appKey)
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .onOpenURL(
                    perform: { url in
                        if (AuthApi.isKakaoTalkLoginUrl(url)) {
                            AuthController.handleOpenUrl(url: url)
                        }
                    }
                )
        }
    }
}
