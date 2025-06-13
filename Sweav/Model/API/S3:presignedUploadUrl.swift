import Foundation

struct UploadUrl: Codable {
    // <Request URL>
    // http://ec2-54-253-28-13.ap-southeast-2.compute.amazonaws.com:8081/s3/presignedUploadUrl
    // <Info>
    // POST /s3/presignedUploadUrl

    let statusCode: String
    let message: String
    let data: UrlData
    
    struct UrlData: Codable {
        let uploadUrl: String
        let imgUrl: String
    }
}
