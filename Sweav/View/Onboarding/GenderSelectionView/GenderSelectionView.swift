import SwiftUI

struct GenderSelectionView: View {
    @State private var showMifflinSheet: Bool = false
    @State private var selectedGender: String? = nil
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
            
            Text("성별을 알려주세요.")
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
            
            
            HStack(spacing: 24) {
                Button {
                    selectedGender = "M"
                } label: {
                    Text("남자")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(selectedGender == "M" ? Color(hex: "#2A9D8F") : Color(hex: "#70706E"))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18.5)
                }
                .background(selectedGender == "M" ? Color(hex: "#D4EBE9") : Color(hex: "#FAF8F4"))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(selectedGender == "M" ? Color.main : Color(hex: "#FAF8F4"), lineWidth: 4)
                )
                .cornerRadius(16)
                
                Button {
                    selectedGender = "F"
                } label: {
                    Text("여자")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(selectedGender == "F" ? Color(hex: "#2A9D8F") : Color(hex: "#70706E"))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18.5)
                }
                .background(selectedGender == "F" ? Color(hex: "#D4EBE9") : Color(hex: "#FAF8F4"))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(selectedGender == "F" ? Color.main : Color(hex: "#FAF8F4"), lineWidth: 4)
                )
                .cornerRadius(16)
            }
            .padding(.top, 170)
            
            Spacer()
            
            Button {
                //TODO: Navigate
                UserDefaults.standard.set(selectedGender, forKey: "gender")
            } label: {
                Text("Button")
            }
            .disabled(selectedGender == nil)
        }
        .padding(.horizontal, 40)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var navigationPath = NavigationPath()
        
        var body: some View {
            GenderSelectionView(navigationPath: $navigationPath)
        }
    }
    return PreviewWrapper()
}
