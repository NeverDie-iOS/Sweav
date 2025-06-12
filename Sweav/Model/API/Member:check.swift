import Foundation

struct IdCheck: Codable {
    // <Request URL>
    // http://ec2-54-253-28-13.ap-southeast-2.compute.amazonaws.com:8081/member/check
    // <Info>
    // GET /member/check

    let statusCode: String
    let message: String
    let data: Possibility
    
    struct Possibility: Codable {
        let possible: Bool
    }
}
