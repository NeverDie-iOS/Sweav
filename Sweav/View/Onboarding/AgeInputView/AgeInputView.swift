import SwiftUI

struct AgeInputView: View {
    @State private var age: String = ""
    @State private var showMifflinSheet: Bool = false
    @Binding var navigationPath: NavigationPath
    @FocusState private var isAgeFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                navigationPath.removeLast()
            } label: {
                Image("BackButton")
            }
            .padding(.leading, -20)
            .padding(.vertical, 14)
            
            Text("나이는 어떻게 되시나요?")
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
                Text("만 나이로 입력해주세요.")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.tertiary)
                
                TextField(
                    "",
                    text: $age,
                    prompt: Text("만 나이")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(hex: "#BBBAB7"))
                )
                .keyboardType(.numberPad)
                .focused($isAgeFocused)
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.default)
                .frame(width: 120)
                .multilineTextAlignment(.center)
                .padding(.vertical, 16)
                .background(Color(hex: "#FAF8F4"))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isAgeFocused ? Color.main : Color(hex: "#FAF8F4"), lineWidth: 4)
                )
                .cornerRadius(16)
                .onChange(of: age) {
                    if age.count > 2 {
                        age = String(age.prefix(2))
                    }
                    if age.first == "0" {
                        age.removeFirst()
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 153)
            
            Spacer()
            
            Button {
                UserDefaults.standard.set(age, forKey: "age")
                navigationPath.append(OnboardingRoute.bodyInfoInput)
            } label: {
                Text("다음")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 17)
                    .background(age.isEmpty ? Color(hex: "#AAD8D2") : Color.main)
                    .cornerRadius(16)
            }
            .disabled(age.isEmpty)
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
            AgeInputView(navigationPath: $navigationPath)
        }
    }
    return PreviewWrapper()
}
