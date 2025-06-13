import SwiftUI

struct GoalInputView: View {
    @State private var showMifflinSheet: Bool = false
    @State private var showPopover: Bool = false
    @State private var goalDate: Date = Date()
    @State private var goalWeight: String = ""
    @State private var isDateChanged: Bool = false
    @Binding var navigationPath: NavigationPath
    @FocusState private var isGoalWeightFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                navigationPath.removeLast()
            } label: {
                Image("BackButton")
            }
            .padding(.leading, -20)
            .padding(.vertical, 14)
            
            Text("목표를 정해볼까요?")
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
            
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    Text("목표 날짜")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color(hex: "#BBBAB7"))
                        .frame(width: 90, alignment: .leading)
                    
                    Button {
                        showPopover = true
                        isGoalWeightFocused = false
                        isDateChanged = true
                    } label: {
                        Text("\(CommonUtils.formattedDateWithDots(goalDate))")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(
                                isDateChanged ? Color.default : Color(hex: "#BBBAB7"))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13.5)
                    .background(Color(hex: "#FAF8F4"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(showPopover ? Color.main : Color(hex: "#FAF8F4"), lineWidth: 4)
                    )
                    .cornerRadius(16)
                    .popover(isPresented: $showPopover, attachmentAnchor: .rect(.bounds), arrowEdge: .top) {
                        VStack {
                            DatePicker(
                                "",
                                selection: $goalDate,
                                in: Date()...Date.distantFuture,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .padding()
                        }
                        .frame(width: 300)
                        .presentationCompactAdaptation(.popover)
                    }
                }
                
                HStack(spacing: 12) {
                    Text("목표 몸무게")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color(hex: "#BBBAB7"))
                        .frame(width: 90, alignment: .leading)
                    
                    TextField(
                        "",
                        text: $goalWeight,
                        prompt: Text("몸무게")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.tertiary)
                    )
                    .keyboardType(.decimalPad)
                    .focused($isGoalWeightFocused)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.default)
                    .frame(width: 120)
                    .padding(.vertical, 16)
                    .background(Color(hex: "#FAF8F4"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isGoalWeightFocused ? Color.main : Color(hex: "#FAF8F4"), lineWidth: 4)
                    )
                    .cornerRadius(16)
                    .onChange(of: goalWeight) { newValue in
                        if newValue.count > 3 {
                            goalWeight = String(goalWeight.prefix(3))
                        }
                    }
                    
                    Text("kg")
                        .font(.system(size: 20, weight: .semibold))
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 130)
            
            Spacer()
            
            Button {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                
                UserDefaults.standard.set(formatter.string(from: goalDate), forKey: "goalDate")
                UserDefaults.standard.set(goalWeight, forKey: "goalWeight")
                
                navigationPath.append(OnboardingRoute.planSetup)
            } label: {
                Text("다음")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 17)
                    .background(!isDateChanged || goalWeight.isEmpty ? Color(hex: "#AAD8D2") : Color.main)
                    .cornerRadius(16)
            }
            .disabled(!isDateChanged || goalWeight.isEmpty)
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
            GoalInputView(navigationPath: $navigationPath)
        }
    }
    return PreviewWrapper()
}
