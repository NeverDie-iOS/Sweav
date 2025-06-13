import Foundation

struct CommonUtils {
    static func formattedDateWithDots(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.  M  .  d"
        return formatter.string(from: date)
    }
}
