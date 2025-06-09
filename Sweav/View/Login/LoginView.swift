import SwiftUI

struct LoginView: View {
    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("sweav.")
                .font(.system(size: 48, weight: .heavy))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.main)
                .padding(.top, 146)
                .opacity(loginVM.showLogo ? 1 : 0)
            
            Text("운동과 일상이 만나는 곳\n스위브에서 함께, 더 건강하게!")
                .font(.system(size: 24, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.default)
                .lineSpacing(4)
                .padding(.top, 48)
                .opacity(loginVM.showMainText ? 1 : 0)
            
            Text("운동, 식단, 커뮤니티까지 한 번에!\n더 건강한 나를 위한 처음을 내딛으세요.")
                .font(.system(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.tertiary)
                .lineSpacing(4)
                .padding(.top, 16)
                .opacity(loginVM.showSubText ? 1 : 0)
            
            Spacer()
            
            VStack(spacing: 16) {
                Button {
                    // Kakao login
                } label: {
                    ZStack {
                        Text("카카오로 로그인하기")
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundStyle(Color(hex: "#1A1700"))
                            .padding(.vertical, 16.5)
                        
                        HStack {
                            Image("KakaoTalkLogo")
                                .padding(.leading, 21.5)
                            Spacer()
                        }
                    }
                }
                .background(Color(hex: "#FEE500"))
                .cornerRadius(16)
                
                Button {
                    // apple login
                } label: {
                    ZStack {
                        Text("Apple로 로그인하기")
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                            .padding(.vertical, 16.5)
                        
                        HStack {
                            Image("AppleLogo")
                                .padding(.leading, 21.5)
                            Spacer()
                        }
                    }
                }
                .background(Color.black)
                .cornerRadius(16)
            }
            .padding(.bottom, 40)
            .opacity(loginVM.showLoginButtons ? 1 : 0)
        }
        .padding(.horizontal, 40)
        .onAppear {
            loginVM.startAnimations()
        }
    }
}

#Preview {
    LoginView()
}
