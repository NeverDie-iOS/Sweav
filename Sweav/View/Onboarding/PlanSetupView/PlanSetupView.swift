import SwiftUI

struct PlanSetupView: View {
    @State private var showMifflinSheet: Bool = false
    @State private var isValueChanged: Bool = false
    @State private var workoutDays: Double = 0
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                navigationPath.removeLast()
            } label: {
                Image("BackButton")
            }
            .padding(.leading, -20)
            .padding(.vertical, 14)
            
            Text("운동 계획은 어떻게 되시나요?")
                .font(.system(size: 24, weight: .semibold))
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
            
            VStack(alignment: .center) {
                HStack(spacing: 12) {
                    Text("매주")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.default)
                    
                    Text("\(Int(workoutDays))")
                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                        .foregroundStyle(Color.default)
                    
                    Text("일 운동")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.default)
                }
                
                CustomSlider(value: $workoutDays, isValueChanged: $isValueChanged)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 150)
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button {
                UserDefaults.standard.set(workoutDays, forKey: "inputWeekExerciseCnt")
            } label: {
                Text("Button")
            }
        }
        .padding(.horizontal, 40)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var navigationPath = NavigationPath()
        
        var body: some View {
            PlanSetupView(navigationPath: $navigationPath)
        }
    }
    return PreviewWrapper()
}
