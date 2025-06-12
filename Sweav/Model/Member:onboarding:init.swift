import Foundation

struct RandomProfile: Codable {
    // <Request URL>
    // http://ec2-54-253-28-13.ap-southeast-2.compute.amazonaws.com:8081/member/onboarding/init
    // <Info>
    // POST /member/onboarding/init

    let statusCode: String
    let message: String
    let data: ProfileData
    
    struct ProfileData: Codable {
        let nickname: String
        let feedId: String
    }
}
