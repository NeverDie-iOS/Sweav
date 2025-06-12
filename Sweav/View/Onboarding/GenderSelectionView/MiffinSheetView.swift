import SwiftUI

struct MifflinSheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 40) {
                    Text("""
                💡  **Mifflin-St Jeor 공식이란?**
                
                이 공식은 기초대사량(BMR)을 계산하는 공식이에요! 즉, **하루 종일 가만히 있어도 우리 몸이 쓰는 최소한의 칼로리**를 알려주는 거죠.
                """)
                    
                    Text("""
                💬  **왜 중요할까?**
                
                1990년에 만들어진 공식으로,\n예전보다 더 **정확하게 BMR을 계산**할 수 있어요.
                **키·체중·나이·성별**을 입력하면 내 BMR이 나와요. 이후 **활동량을 곱하면 하루 총 소비 칼로리(TDEE)\u{200B}**도 알 수 있어요.
                """)
                    
                    Text("""
                🚗  *몸도 자동차처럼 연비가 있어요!*
                
                내 몸이 기본적으로 **하루에 얼마나 연료(칼로리)를 쓰는지** 알려주는 공식이에요.
                거기에 **운동이나 활동량을 추가하면 하루에 필요한 총 칼로리**가 나오게 됩니다. 🙂
                """)
                }
            }
            .padding(.top, 60)
            
            Button {
                dismiss()
            } label: {
                Text("확인")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 17)
                    .background(Color.main)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    MifflinSheetView()
}
