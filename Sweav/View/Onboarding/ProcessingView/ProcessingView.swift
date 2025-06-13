import SwiftUI

struct ProcessingView: View {
    @State private var isAnimating = false
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("이제 계산해볼게요..!")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.default)
                
                Text("잠시만 기다려주세요..!")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.tertiary)
                    .padding(.top, 6)
            }
            .padding(.top, 88)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Circle()
                .trim(from: 0, to: 1)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Color.white.opacity(0.3), Color.main]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 15, lineCap: .round)
                )
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
                .onAppear {
                    isAnimating = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        navigationPath.append(OnboardingRoute.completeOnboading)
                    }
                }
                .padding(.top, 200)
            
            Spacer()
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
            ProcessingView(navigationPath: $navigationPath)
        }
    }
    return PreviewWrapper()
}
