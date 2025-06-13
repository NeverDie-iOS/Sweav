import Foundation
import SwiftKeychainWrapper
import Alamofire

class PlanSetupViewModel: ObservableObject {
    func sendToServer() {
        let url = "http://ec2-54-253-28-13.ap-southeast-2.compute.amazonaws.com:8081/member/onboarding"
        guard let accessToken = KeychainWrapper.standard.string(forKey: "accessToken") else {
            print("토큰 X")
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        let parameters: [String: Any] = [
            "nickname": UserDefaults.standard.string(forKey: "nickname") ?? "",
            "feedId": UserDefaults.standard.string(forKey: "feedId") ?? "",
            "profileImgUrl": UserDefaults.standard.string(forKey: "profileImgUrl") ?? "",
            "gender": UserDefaults.standard.string(forKey: "gender") ?? "",
            "age": Int(UserDefaults.standard.string(forKey: "age") ?? "")!,
            "height": Int(UserDefaults.standard.string(forKey: "height") ?? "")!,
            "weight": Int(UserDefaults.standard.string(forKey: "weight") ?? "")!,
            "activityType": UserDefaults.standard.string(forKey: "activityType") ?? "",
            "goalDate": UserDefaults.standard.string(forKey: "goalDate") ?? "",
            "goalWeight": Int(UserDefaults.standard.string(forKey: "goalWeight") ?? "")!,
            "inputWeekExerciseCnt": Int(UserDefaults.standard.string(forKey: "inputWeekExerciseCnt") ?? "")!
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .responseDecodable(of: OnboardingData.self) { response in
            DispatchQueue.main.async {
                switch response.result {
                    case .success(let responseData):
                        UserDefaults.standard.set(responseData.data.calcCarb, forKey: "calcCarb")
                        UserDefaults.standard.set(responseData.data.calcProtein, forKey: "calcProtein")
                        UserDefaults.standard.set(responseData.data.calcFat, forKey: "calcFat")
                        print("온보딩 데이터 전송 성공")
                    case .failure(let error):
                        print("온보딩 데이터 전송 실패")
                        print(error)
                }
            }
        }
    }
}

