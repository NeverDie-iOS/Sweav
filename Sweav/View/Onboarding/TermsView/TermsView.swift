import SwiftUI

enum OnboardingRoute: String, Hashable {
    case nameIdSetup = "NameIdSetupView"
    case profileImageSetup = "ProfileImageSetupView"
    case genderSelection = "GenderSelectionView"
    case ageInput = "AgeInputView"
    case bodyInfoInput = "BodyInfoInputView"
    case activityLevelSelection = "ActivityLevelSelectionView"
    case goalInput = "GoalInputView"
    case planSetup = "PlanSetupView"
    case processing = "ProcessingView"
    case completeOnboading = "CompleteOnboardingView"
}

struct TermsView: View {
    @State private var isTermsAgreed: Bool = false
    @State private var isPrivacyAgreed: Bool = false
    @State private var isPushAgreed: Bool = false
    @State private var showTermsSheet: Bool = false
    @State private var showPrivacySheet: Bool = false
    @State private var showToast = false
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(alignment: .leading, spacing: 0) {
                Text("스위브 이용을 위해\n약관에 동의해주세요.")
                    .font(.system(size: 24, weight: .heavy))
                    .padding(.top, 87)
                
                HStack {
                    Button {
                        isTermsAgreed = true
                        isPrivacyAgreed = true
                        isPushAgreed = true
                    } label: {
                        Image("Unchecked")
                            .renderingMode(.template)
                            .foregroundStyle(Color.white)
                            .padding(9)
                            .background {
                                Circle()
                                    .foregroundStyle(
                                        isTermsAgreed && isPrivacyAgreed && isPushAgreed
                                        ? Color.main
                                        : Color(hex: "#DCDAD7")
                                    )
                            }
                    }
                    
                    Text("전체 동의")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.default)
                }
                .padding(.top, 153)
                
                VStack(spacing: 15) {
                    HStack(spacing: 0) {
                        Button {
                            isTermsAgreed.toggle()
                        } label: {
                            isTermsAgreed ? Image("Checked") : Image("Unchecked")
                        }
                        
                        Text("필수")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.main)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "#E9F5F4"))
                            )
                            .padding(.leading, 16)
                        
                        Text("서비스 이용약관")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.black)
                            .padding(.leading, 8)
                        
                        Spacer()
                        
                        Button {
                            showTermsSheet = true
                        } label: {
                            Text("보기")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.tertiary)
                        }
                        .sheet(isPresented: $showTermsSheet) {
                            TermsSheetView()
                        }
                    }
                    
                    HStack(spacing: 0) {
                        Button {
                            isPrivacyAgreed.toggle()
                        } label: {
                            isPrivacyAgreed ? Image("Checked") : Image("Unchecked")
                        }
                        
                        
                        Text("필수")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.main)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "#E9F5F4"))
                            )
                            .padding(.leading, 16)
                        
                        Text("개인정보 처리방침")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.black)
                            .padding(.leading, 8)
                        
                        Spacer()
                        
                        Button {
                            showPrivacySheet = true
                        } label: {
                            Text("보기")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.tertiary)
                        }
                        .sheet(isPresented: $showPrivacySheet) {
                            PrivacySheetView()
                        }
                    }
                    
                    HStack(spacing: 0) {
                        Button {
                            isPushAgreed.toggle()
                        } label: {
                            isPushAgreed ? Image("Checked") : Image("Unchecked")
                        }
                        
                        Text("선택")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color(hex: "#70706E"))
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "#F0EEEA"))
                            )
                            .padding(.leading, 16)
                        
                        Text("푸시 알림 기능")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.black)
                            .padding(.leading, 8)
                        
                        Spacer()
                        
                        EmptyView()
                    }
                }
                .padding(.top, 20)
                .padding(.leading, 9)
                
                Spacer()
                
                Button {
                    if isTermsAgreed && isPrivacyAgreed {
                        navigationPath.append(OnboardingRoute.nameIdSetup)
                    } else {
                        showToast = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showToast = false
                        }
                    }
                } label: {
                    Text("다음")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 17)
                        .background(isTermsAgreed && isPrivacyAgreed ? Color.main : Color.disabled)
                        .cornerRadius(16)
                }
                .overlay(
                    Group {
                        if showToast {
                            CustomToastMessageView(message: "서비스 이용을 위한 필수 항목에 동의해 주세요.")
                                .offset(y: -70)
                        }
                    }
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.3), value: showToast)
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
            .navigationDestination(for: OnboardingRoute.self) { route in
                switch route {
                    case .nameIdSetup:
                        NameIdSetupView(navigationPath: $navigationPath)
                    case .profileImageSetup:
                        ProfileImageSetupView(navigationPath: $navigationPath)
                    case .genderSelection:
                        GenderSelectionView(navigationPath: $navigationPath)
                    case .ageInput:
                        AgeInputView(navigationPath: $navigationPath)
                    case .bodyInfoInput:
                        BodyInfoInputView(navigationPath: $navigationPath)
                    case .activityLevelSelection:
                        ActivityLevelSelectionView(navigationPath: $navigationPath)
                    case .goalInput:
                        GoalInputView(navigationPath: $navigationPath)
                    case .planSetup:
                        PlanSetupView(navigationPath: $navigationPath)
                    case .processing:
                        ProcessingView(navigationPath: $navigationPath)
                    case .completeOnboading:
                        CompleteOnboardingView(navigationPath: $navigationPath)
                }
            }
            .navigationDestination(for: MainRoute.self) { route in
                switch route {
                    case .main:
                        MainView()
                }
            }
        }
    }
}

#Preview {
    TermsView()
}
