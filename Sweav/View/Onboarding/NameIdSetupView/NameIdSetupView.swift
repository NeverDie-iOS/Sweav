import SwiftUI

struct NameIdSetupView: View {
    @State private var nickname: String = ""
    @State private var id: String = ""
    @State private var isEditing: Bool = false
    @FocusState private var isNicknameFocused: Bool
    @FocusState private var isIdFocused: Bool
    
    @Binding var navigationPath: NavigationPath
    @StateObject private var nameIdSetupVM = NameIdSetupViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("만나서 반가워요!\n제가 어떻게 부르면 될까요?")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.default)
                .padding(.top, 87)
            
            VStack(spacing: 16) {
                HStack {
                    Text("닉네임")
                        .frame(width: 60)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color(hex: "#70706E"))
                    
                    TextField("", text: $nickname)
                        .focused($isNicknameFocused)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.default)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 14)
                        .background(Color(hex: "#FAF8F4"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(isNicknameFocused ? Color.main : Color(hex: "#FAF8F4"), lineWidth: 4)
                        )
                        .cornerRadius(16)
                }
                
                HStack {
                    Text("ID")
                        .frame(width: 60)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color(hex: "#70706E"))
                    
                    TextField("", text: $id)
                        .keyboardType(.asciiCapable)
                        .focused($isIdFocused)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.default)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 16)
                        .background(Color(hex: "#FAF8F4"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(isIdFocused ? Color.main : Color(hex: "#FAF8F4"), lineWidth: 4)
                        )
                        .cornerRadius(16)
                }
            }
            .padding(.top, 50)
            
            Text("ID는 개인에게 부여되는 고유값이며, 닉네임 중복 사용 및 검색에 활용하기 위해 설정해요.")
                .font(.system(size: 14))
                .foregroundStyle(Color.tertiary)
                .padding(.top, 12)
            
            Spacer()
            
            Button {
                Task {
                    guard nameIdSetupVM.validateNickname(nickname) else { return }
                    
                    nameIdSetupVM.validateId(id) { isValid in
                        if isValid {
                            navigationPath.append(OnboardingRoute.profileImageSetup)
                        }
                    }
                }
            } label: {
                if !nickname.isEmpty && !id.isEmpty {
                    Text("다음")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 17)
                        .background(Color.main)
                        .cornerRadius(16)
                } else {
                    Text("다음")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 17)
                        .background(Color.disabled)
                        .cornerRadius(16)
                }
            }
            .disabled(nickname.isEmpty || id.isEmpty)
            .padding(.bottom, 20)
            .overlay(
                Group {
                    if nameIdSetupVM.showToast {
                        CustomToastMessageView(message: nameIdSetupVM.toastMessage ?? "잘못된 입력입니다.")
                            .offset(y: -90)
                    }
                }
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: nameIdSetupVM.showToast)
            )
        }
        .padding(.horizontal, 40)
        .navigationBarBackButtonHidden(true)
        .onReceive(nameIdSetupVM.$randomNickname) { newNickname in
            nickname = newNickname
        }
        .onReceive(nameIdSetupVM.$randomId) { newId in
            id = newId
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var navigationPath = NavigationPath()
        
        var body: some View {
            NameIdSetupView(navigationPath: $navigationPath)
        }
    }
    return PreviewWrapper()
}
