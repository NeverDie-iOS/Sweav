import Foundation

struct AuthLoginKakaoResponse: Codable {
    // <Request URL>
    // http://ec2-54-253-28-13.ap-southeast-2.compute.amazonaws.com:8081/auth/login/kakao
    // <Info>
    // POST /auth/login/kakao
    
    let data: UserData
    let message: String
    let statusCode: String
    
    struct UserData: Codable {
        let memberId: Int
        let accessToken: String
        let profileImgUrl: String
        let onboardingComplete: Bool
        let profileImgDefault: Bool
    }
}
