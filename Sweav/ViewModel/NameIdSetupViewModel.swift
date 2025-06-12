import SwiftUI
import SwiftKeychainWrapper
import Alamofire

class NameIdSetupViewModel: ObservableObject {
    
    @Published var randomNickname: String = ""
    @Published var randomId: String = ""
    
    init() {
        let url = "http://ec2-54-253-28-13.ap-southeast-2.compute.amazonaws.com:8081/member/onboarding/init"
        
        guard let accessToken = KeychainWrapper.standard.string(forKey: "accessToken") else {
            print("<RandomProfile> 토큰 X")
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        AF.request(url, method: .post, headers: headers)
            .responseDecodable(of: RandomProfile.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                        case .success(let responseData):
                            print("랜덤 닉네임: \(responseData.data.nickname)")
                            print("랜덤 아이디: \(responseData.data.feedId)")
                            self.randomNickname = responseData.data.nickname
                            self.randomId = responseData.data.feedId
                            
                        case .failure(let error):
                            print("랜덤 프로필 생성 에러 \(error)")
                    }
                }
            }
    }
}
