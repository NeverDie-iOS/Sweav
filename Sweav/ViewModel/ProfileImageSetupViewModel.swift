import Foundation
import Alamofire
import SwiftKeychainWrapper

class ProfileImageSetupViewModel: ObservableObject {
    func uploadImage(url: String, data: Data?) {
        if let data = data {
            let headers: HTTPHeaders = ["Content-Type": "image/jpeg"]
            AF.upload(data, to: url, method: .put, headers: headers)
                .response { response in
                    if let error = response.error {
                        print("업로드 실패: \(error)")
                    } else {
                        print("업로드 성공 url: \(url)")
                    }
                }
        } else {
            print("데이터 없음")
        }
    }
    
    func uploadProfileImage(imageData: Data?, completion: @escaping () -> Void) {
        let url = "http://ec2-54-253-28-13.ap-southeast-2.compute.amazonaws.com:8081/s3/presignedUploadUrl"
        guard let accessToken = KeychainWrapper.standard.string(forKey: "accessToken") else {
            print("토큰 X")
            completion()
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        let parameters: [String: String] = [
            "path": "profile",
            "contentType": "image/jpeg"
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .responseDecodable(of: UploadUrl.self) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let responseData):
                    UserDefaults.standard.set(responseData.data.uploadUrl, forKey: "uploadUrl")
                    UserDefaults.standard.set(responseData.data.imgUrl, forKey: "imgUrl")
                    if let imageData = imageData {
                        let uploadUrl = responseData.data.uploadUrl
                        self.uploadImage(url: uploadUrl, data: imageData)
                    }
                    completion()
                case .failure(let error):
                    print("업로드 주소 가져오기 실패 \(error)")
                    completion()
                }
            }
        }
    }
}
