import SwiftUI

struct CompleteOnboardingView: View {
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                Text("건강해질 준비 완료!")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.default)
                
                Text("입력한 정보는 마이페이지에서 언제든 수정할 수 있어요.")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.tertiary)
                    .padding(.top, 6)
            }
            .padding(.top, 88)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                if let savedData = UserDefaults.standard.data(forKey: "profileImageData"),
                   let savedImage = UIImage(data: savedData) {
                    Image(uiImage: savedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }
                
                if let nickname = UserDefaults.standard.string(forKey: "nickname") {
                    Text(nickname)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.default)
                        .padding(.leading, 4)
                }
                
                if let feedId = UserDefaults.standard.string(forKey: "feedId") {
                    Text("@\(feedId)")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(hex: "#70706E"))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 40)
            
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("목표 몸무게")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.default)
                    
                    HStack(spacing: 0) {
                        if let weight = UserDefaults.standard.string(forKey: "weight") {
                            Text(weight)
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(Color.default)
                        } else {
                            Text("60")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(Color.default)
                        }
                        
                        Text("kg")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.tertiary)
                            .padding(.leading, 4)
                        
                        Image("Triangle")
                            .padding(.horizontal, 12)
                        
                        if let goalWeight = UserDefaults.standard.string(forKey: "goalWeight") {
                            Text(goalWeight)
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(Color.default)
                        } else {
                            Text("50")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(Color.default)
                        }
                        
                        Text("kg")
                            .padding(.leading, 4)
                            .font(.system(size: 16))
                            .foregroundStyle(Color.tertiary)
                    }
                }
                .padding(.top, 50)
                
                HStack(spacing: 40) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("탄수화물")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.default)
                        
                        HStack(spacing: 2) {
                            if let calcCarb = UserDefaults.standard.string(forKey: "calcCarb") {
                                Text(calcCarb)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(Color.default)
                            } else {
                                Text("200")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(Color.default)
                            }
                            
                            Text("g")
                                .font(.system(size: 16))
                                .foregroundStyle(Color.tertiary)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("단백질")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.default)
                        
                        HStack(spacing: 2) {
                            if let calcProtein = UserDefaults.standard.string(forKey: "calcProtein") {
                                Text(calcProtein)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(Color.default)
                            } else {
                                Text("200")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(Color.default)
                            }
                            
                            Text("g")
                                .font(.system(size: 16))
                                .foregroundStyle(Color.tertiary)
                        }
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("지방")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.default)
                        
                        HStack(spacing: 2) {
                            if let calcFat = UserDefaults.standard.string(forKey: "calcFat") {
                                Text(calcFat)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(Color.default)
                            } else {
                                Text("200")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(Color.default)
                            }
                            
                            Text("g")
                                .font(.system(size: 16))
                                .foregroundStyle(Color.tertiary)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button {
                navigationPath.append(MainRoute.main)
            } label: {
                Text("시작하기")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 17)
                    .background(Color.main)
                    .cornerRadius(16)
            }
            .padding(.bottom, 20)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 40)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var navigationPath = NavigationPath()
        
        var body: some View {
            CompleteOnboardingView(navigationPath: $navigationPath)
        }
    }
    return PreviewWrapper()
}

