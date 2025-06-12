import SwiftUI
import SwiftKeychainWrapper
import Alamofire

class NameIdSetupViewModel: ObservableObject {
    
    @Published var randomNickname: String = ""
    @Published var randomId: String = ""
    
    // 닉네임-ID 유효성 검사 에러 시 토스트메시지
    @Published var toastMessage: String? = nil
    @Published var showToast = false
    @Published var isDuplicatedId = false
    
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
    
    // MARK: 닉네임 유효성 검사
    func validateNickname(_ nickname: String) -> Bool {
        let trimmedNickname = nickname.trimmingCharacters(in: .whitespaces)
        
        if nickname != trimmedNickname {
            toastMessage = "닉네임 앞뒤에 공백을 사용할 수 없습니다."
            showToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showToast = false
            }
            return false
        }
        
        if nickname.count < 2 || nickname.count > 8 {
            toastMessage = "닉네임은 2~8자로 설정해주세요."
            showToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showToast = false
            }
            return false
        }
        
        toastMessage = nil
        showToast = false
        return true
    }
    
    
    // MARK: ID 유효성 검사
    func validateIdCharacters(_ id: String) -> Bool {
        let pattern = "^[a-z0-9_.-]*$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let range = NSRange(location: 0, length: id.utf16.count)
        return regex.firstMatch(in: id, options: [], range: range) != nil
    }
    
    func validateIdLength(_ id: String) -> Bool {
        return id.count >= 4 && id.count <= 10
    }
    
    func checkIdDuplicate(_ id: String, completion: @escaping (Bool) -> Void) {
        let url = "http://ec2-54-253-28-13.ap-southeast-2.compute.amazonaws.com:8081/member/check"
        guard let accessToken = KeychainWrapper.standard.string(forKey: "accessToken") else {
            print("<checkIdDuplicate> 토큰 X")
            completion(false)
            return
        }
        
        let parameters: [String: String] = [
            "type": "feedId",
            "value": id
        ]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: IdCheck.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let responseData):
                        completion(!responseData.data.possible)
                    case .failure(let error):
                        print(error)
                        completion(true)
                    }
                }
            }
    }
    
    func validateId(_ id: String, completion: @escaping (Bool) -> Void) {
        if !validateIdCharacters(id) {
            toastMessage = "ID는 소문자 영문, 숫자, 하이픈(-),\n언더바(_), 마침표(.)만 사용할 수 있어요."
            showToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showToast = false
            }
            completion(false)
            return
        }
        
        if !validateIdLength(id) {
            toastMessage = "ID는 4~10자로 설정해주세요."
            showToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showToast = false
            }
            completion(false)
            return
        }
        
        checkIdDuplicate(id) { [weak self] isDuplicate in
            DispatchQueue.main.async {
                if isDuplicate {
                    self?.toastMessage = "중복된 ID 입니다. 다른 ID를 사용해주세요."
                    self?.showToast = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self?.showToast = false
                    }
                    completion(false)
                } else {
                    self?.toastMessage = nil
                    self?.showToast = false
                    completion(true)
                }
            }
        }
    }
}
