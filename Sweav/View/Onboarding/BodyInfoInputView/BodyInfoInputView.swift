import SwiftUI

struct BodyInfoInputView: View {
    @State private var showMifflinSheet: Bool = false
    @State private var height: String = ""
    @State private var weight: String = ""
    @Binding var navigationPath: NavigationPath
    @FocusState private var isHeightFocused: Bool
    @FocusState private var isWeightFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                navigationPath.removeLast()
            } label: {
                Image("BackButton")
            }
            .padding(.leading, -20)
            .padding(.vertical, 14)
            
            Text("키와 몸무게를 알려주세요.")
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
            
            VStack {
                HStack(spacing: 12) {
                    TextField(
                        "",
                        text: $height,
                        prompt: Text("키")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(hex: "#BBBAB7"))
                    )
                    .keyboardType(.numberPad)
                    .focused($isHeightFocused)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.default)
                    .multilineTextAlignment(.center)
                    .frame(width: 120)
                    .padding(.vertical, 16)
                    .background(Color(hex: "#FAF8F4"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isHeightFocused ? Color.main : Color(hex: "#FAF8F4"), lineWidth: 4)
                    )
                    .cornerRadius(16)
                    .onChange(of: height) { newValue in
                        if newValue.count > 3 {
                            height = String(newValue.prefix(3))
                        }
                        if height.first == "0" {
                            height.removeFirst()
                        }
                    }
                    
                    Text("cm")
                        .font(.system(size: 20, weight: .semibold))
                }
                
                HStack(spacing: 12) {
                    TextField(
                        "",
                        text: $weight,
                        prompt: Text("몸무게")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(hex: "#BBBAB7"))
                    )
                    .keyboardType(.numberPad)
                    .focused($isWeightFocused)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.default)
                    .multilineTextAlignment(.center)
                    .frame(width: 120)
                    .padding(.vertical, 16)
                    .background(Color(hex: "#FAF8F4"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isWeightFocused ? Color.main : Color(hex: "#FAF8F4"), lineWidth: 4)
                    )
                    .cornerRadius(16)
                    .onChange(of: weight) { newValue in
                        if newValue.count > 3 {
                            weight = String(newValue.prefix(3))
                        }
                        if weight.first == "0" {
                            weight.removeFirst()
                        }
                    }
                    
                    Text("kg")
                        .font(.system(size: 20, weight: .semibold))
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 135)
            
            Spacer()
            
            Button {
                UserDefaults.standard.set(height, forKey: "height")
                UserDefaults.standard.set(weight, forKey: "weight")
                navigationPath.append(OnboardingRoute.activityLevelSelection)
            } label: {
                Text("다음")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 17)
                    .background(height.isEmpty || weight.isEmpty ? Color(hex: "#AAD8D2") : Color.main)
                    .cornerRadius(16)
            }
            .disabled(height.isEmpty || weight.isEmpty)
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
            BodyInfoInputView(navigationPath: $navigationPath)
        }
    }
    return PreviewWrapper()
}
