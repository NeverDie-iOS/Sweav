import Foundation

struct OnboardingData: Codable {
    // <Request URL>
    // http://ec2-54-253-28-13.ap-southeast-2.compute.amazonaws.com:8081/member/onboarding
    // <Info>
    // POST /member/onboarding

    let statusCode: String
    let message: String
    let data: ProfileData
    
    struct ProfileData: Codable {
        let memberId: Int?
        let nickname: String
        let feedId: String
        let profileImgUrl: String
        let weight: Int
        let goalWeight: Int
        let intakeKcal: Int
        let calcCarb: Double
        let calcProtein: Double
        let calcFat: Double
    }
}
