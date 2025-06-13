import SwiftUI

struct ActivityLevelSelectionView: View {
    @State private var showMifflinSheet: Bool = false
    @State private var activityLevel: String = ""
    @State private var selectedIndex: Int? = nil
    @Binding var navigationPath: NavigationPath
    
    let activityLevels = ["몸을 거의 안움직여요", "가벼운 산책 정도만 해요", "규칙적인 활동을 해요", "거의 매일 운동을 해요", "매일 강도 높은 운동을 해요"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                navigationPath.removeLast()
            } label: {
                Image("BackButton")
            }
            .padding(.leading, -20)
            .padding(.vertical, 14)
            
            Text("활동량이 얼마나 되시나요?")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.default)
                .padding(.top, 40)
            
            HStack(spacing: 4) {
                Button {
                    showMifflinSheet = true
                } label: {
                    HStack(spacing: 4) {
                        Image("HelpCon")
                        Text("Mifflin-St Jeor")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.tertiary)
                            .underline(true, pattern: .solid)
                    }
                }
                .sheet(isPresented: $showMifflinSheet) {
                    MifflinSheetView()
                }
                
                Text("공식을 활용해")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.tertiary)
            }
            
            Text("적정 칼로리 및 영양분 섭취를 제안하기 위해 활용돼요.")
                .font(.system(size: 14))
                .foregroundStyle(Color.tertiary)
            
            VStack(spacing: 16) {
                ForEach(0..<5, id: \.self) { index in
                    Button {
                        selectedIndex = index
                        activityLevel = self.activityLevels[index]
                    } label: {
                        Text(activityLevels[index])
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(selectedIndex == index ? Color.main : Color(hex: "#70706E"))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 18.5)
                    .background(selectedIndex == index ? Color(hex: "#D4EBE9") : Color(hex: "#FAF8F4"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(selectedIndex == index ? Color.main : Color(hex: "#FAF8F4"), lineWidth: 4)
                    )
                    .cornerRadius(16)
                }
            }
            .padding(.top, 90)
            
            Spacer()
            
            Button {
                if let selectedIndex {
                    switch selectedIndex {
                        case 0 :
                            UserDefaults.standard.set("ALMOST_NO_EXERCISE", forKey: "activityType")
                        case 1 :
                            UserDefaults.standard.set("LIGHT_EXERCISE", forKey: "activityType")
                        case 2 :
                            UserDefaults.standard.set("MODERATE_EXERCISE", forKey: "activityType")
                        case 3 :
                            UserDefaults.standard.set("HIGH_EXERCISE", forKey: "activityType")
                        default:
                            UserDefaults.standard.set("ATHLETE_EXERCISE", forKey: "activityType")
                    }
                }
                
                navigationPath.append(OnboardingRoute.goalInput)
            } label: {
                Text("다음")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 17)
                    .background(selectedIndex == nil ? Color(hex: "#AAD8D2") : Color.main)
                    .cornerRadius(16)
            }
            .disabled(activityLevel.isEmpty)
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 40)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var navigationPath = NavigationPath()
        
        var body: some View {
            ActivityLevelSelectionView(navigationPath: $navigationPath)
        }
    }
    return PreviewWrapper()
}
