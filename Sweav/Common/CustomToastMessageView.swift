import SwiftUI

struct CustomToastMessageView: View {
    @State private var isVisible = false
    let message: String
    
    var body: some View {
        Text(message)
            .font(.system(size: 14, weight: .semibold))
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .padding(.vertical, 19.5)
            .background(Color(hex: "#2A9D8F").opacity(0.4))
            .cornerRadius(200)
            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    CustomToastMessageView(message: "서비스 이용을 위한 필수 항목에 동의해 주세요.")
}
