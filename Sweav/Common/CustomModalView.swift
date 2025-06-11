import SwiftUI

struct CustomModalView<Content: View>: View {
    @Binding var isShowingModal: Bool
    let title: String
    let cancelTitle: String
    let confirmTitle: String
    let modalAction: () -> Void
    @ViewBuilder let content: Content
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    isShowingModal = false
                }
            
            VStack(spacing: 24) {
                Text(title)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color(hex: "#252525"))
                
                content
                
                HStack(spacing: 16) {
                    Button {
                        isShowingModal = false
                    } label: {
                        Text(cancelTitle)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 17)
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.main)
                    .background(Color.white)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .inset(by: 1)
                            .stroke(Color.main, lineWidth: 2)
                    )
                    
                    Button {
                        modalAction()
                        isShowingModal = false
                    } label: {
                        Text(confirmTitle)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 17)
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .background(Color.main)
                    .cornerRadius(16)
                }
                .padding(.horizontal, 24)
            }
            .padding(.vertical, 24)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            )
            .padding(.horizontal, 20)
        }
        .transition(.opacity)
        .animation(.easeInOut, value: isShowingModal)
    }
}


#Preview {
    CustomModalView(
        isShowingModal: .constant(true),
        title: "title",
        cancelTitle: "취소",
        confirmTitle: "확인",
        modalAction: {}
    ) {
        VStack {
            Text("content")
        }
    }
}
