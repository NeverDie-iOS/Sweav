import SwiftUI

struct TermsSheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    struct TermsSection: Identifiable {
        let id = UUID()
        let sectionTitle: String
        let contents: [(subTitle: String, content: String)]
    }
    
    let termsSections: [TermsSection] = [
        TermsSection(sectionTitle: "[서비스 이용약관]",
                     contents: [
                        (subTitle: "제1조 (목적)", content: "이 약관은 사용자가 당사에서 제공하는 피트니스 커뮤니티 앱(이하 \"sweav\")을 이용함에 있어 필요한 권리, 의무 및 책임 사항을 규정하는 것을 목적으로 합니다."),
                        (subTitle: "제2조 (서비스 이용)", content: "1. 사용자는 본 약관에 동의하는 경우에 한하여 서비스를 이용할 수 있습니다.\n2. 회사는 서비스의 내용을 자유롭게 추가, 변경, 종료할 수 있으며, 이에 대한 사항을 사전 공지합니다."),
                        (subTitle: "제3조 (계정 생성 및 관리)", content: "1. 사용자는 정확한 정보를 제공하여 계정을 생성해야 합니다.\n2. 타인의 계정을 무단으로 사용하거나 공유할 수 없습니다."),
                        (subTitle: "제4조 (서비스 이용 제한)", content: "1. 사용자는 다음과 같은 행위를 해서는 안 됩니다.\n• 허위 정보 등록\n• 타인의 개인정보 도용\n• 불법 콘텐츠 게시\n• 혐오, 차별, 폭력적 발언 게시\n2. 위반 시, 서비스 이용이 제한될 수 있습니다."),
                        (subTitle: "제5조 (책임의 한계)", content: "1. 회사는 서비스 이용 중 발생하는 건강 문제, 데이터 유실 등에 대해 책임을 지지 않습니다.\n2. 회사는 서비스 운영을 위해 구글 애널리틱스를 활용하며, 서비스 이용 데이터가 수집될 수 있습니다.\n3. 사용자는 자신의 건강 상태를 고려하여 서비스를 이용해야 하며, 필요한 경우 전문가와 상담해야 합니다."),
                        (subTitle: "제6조 (사용자 콘텐츠 및 저작권)", content: "1. 사용자는 sweav에 업로드하는 모든 콘텐츠(이미지, 글, 영상 등)의 저작권을 직접 보유하거나, 정당한 사용 권한을 가지고 있어야 합니다.\n2. 저작권이 있는 타인의 이미지, 영상, 글 등을 무단으로 업로드할 경우, 법적 책임은 사용자에게 있으며, 회사는 이에 대한 책임을 지지 않습니다.\n3. 회사는 사용자가 업로드한 콘텐츠를 사전 검수하지 않으며, 모든 책임은 콘텐츠를 업로드한 사용자에게 있습니다.\n4. 저작권 위반 신고가 접수될 경우, 회사는 해당 콘텐츠를 삭제할 수 있으며, 반복적인 위반 시 서비스 이용이 제한될 수 있습니다.")
                     ]
                    ),
        TermsSection(sectionTitle: "[개인정보 처리방침]",
                     contents: [
                        (subTitle: "제1조 (수집하는 개인정보 항목)", content: "회사는 다음과 같은 개인정보를 수집할 수 있습니다.\n• 이메일, 닉네임, 프로필 사진\n• 운동 및 식단 기록\n• 서비스 이용 기록 및 접속 정보"),
                        (subTitle: "제2조 (개인정보 이용 목적)", content: "1. 사용자 맞춤형 서비스 제공\n2. 커뮤니티 기능 운영\n3. 서비스 개선 및 고객 지원\n4. 구글 애널리틱스를 활용한 서비스 이용 분석"),
                        (subTitle: "제3조 (개인정보 보관 및 삭제)", content: "1. 사용자의 개인정보는 회원 탈퇴 후 1년간 보관되며, 이후 안전하게 삭제됩니다.\n2. 관련 법령에 따라 일정 기간 보관될 수도 있습니다."),
                        (subTitle: "제4조 (개인정보 보호)", content: "1. 회사는 사용자의 개인정보를 보호하기 위해 최선을 다하며, 보안 조치를 시행합니다.\n2. 사용자의 개인정보는 해외 서버에 저장되지 않으며, 제3자에게 제공되지 않습니다."),
                     ]
                    ),
        TermsSection(sectionTitle: "[커뮤니티 가이드라인]",
                     contents: [
                        (subTitle: "", content: "1. 사용자는 건강한 커뮤니티 환경을 위해 예의를 갖춰야 합니다.\n2. 다음과 같은 콘텐츠는 금지됩니다.\n• 허위 정보, 광고성 게시물\n• 욕설, 차별, 혐오 표현\n• 지나치게 자극적인 신체 사진\n• 타인의 개인정보를 무단으로 공유하는 행위\n• 폭력적이거나 불법적인 내용\n• 저작권이 있는 이미지, 영상, 글을 무단으로 게시하는 행위 (회사는 사전 검수를 하지 않으며, 저작권 침해 신고가 접수되면 콘텐츠를 삭제할 수 있습니다.)\n3. 신고된 게시물은 운영진이 검토 후 조치할 수 있습니다.\n4. 가이드라인을 위반할 경우, 위반 정도에 따라 다음과 같은 조치를 취할 수 있습니다.\n• 경고 조치\n• 일정 기간 이용 제한 (일시 정지)\n• 영구 이용 정지 (회원 탈퇴 및 재가입 제한)\n5. 중대한 위반 행위(불법 콘텐츠 게시, 심각한 혐오 표현 등)가 발생할 경우, 별도의 경고 없이 즉시 영구 정지될 수 있습니다.\n6. 제재 조치에 대한 이의 제기는 고객 지원을 통해 신청할 수 있습니다.")
                     ]
                    ),
        TermsSection(sectionTitle: "[책임 면책 조항]",
                     contents: [
                        (subTitle: "", content: "1. 서비스에서 제공하는 운동 및 식단 정보는 참고용이며, 의료적 조언이 아닙니다.\n2. 사용자는 자신의 건강 상태를 고려하여 서비스를 이용해야 하며, 필요한 경우 전문가와 상담해야 합니다.\n3. 서비스를 이용하는 과정에서 발생하는 부상, 건강 이상 등에 대해 회사는 책임을 지지 않습니다.\n4. 회사는 사용자의 데이터 유실, 보안 침해 등에 대한 책임을 부담하지 않습니다.")
                     ]
                    ),
        TermsSection(sectionTitle: "[쿠키 및 트래킹 정책]",
                     contents: [
                        (subTitle: "제1조 (쿠키의 사용)", content: "1. 회사는 서비스 개선을 위해 쿠키 및 유사한 기술을 사용할 수 있습니다.\n2. 회사는 서비스 이용 패턴 분석을 위해 구글 애널리틱스를 사용합니다."),
                        (subTitle: "제2조 (쿠키의 목적)", content: "1. 사용자 맞춤형 서비스 제공\n2. 서비스 이용 분석 및 개선"),
                        (subTitle: "제3조 (쿠키 설정 및 거부)", content: "사용자는 브라우저 설정을 통해 쿠키 사용을 거부할 수 있습니다. 다만, 이 경우 일부 기능이 제한될 수 있습니다."),
                     ]
                    )
    ]
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Text("서비스 이용약관")
                    .font(.system(size: 20).weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .center)
                Button {
                    dismiss()
                } label: {
                    Text("닫기")
                        .foregroundColor(Color(Color(hex: "#BBBAB7")))
                }
            }
            .padding(.top, 24)
            .padding(.bottom, 24)
            
            ScrollView() {
                ForEach(termsSections.indices, id: \.self) { idx in
                    VStack(alignment: .leading) {
                        Text(termsSections[idx].sectionTitle)
                            .font(.system(size: 16))
                            .padding(.bottom, 8)
                        ForEach(termsSections[idx].contents.indices, id: \.self) { index in
                            let article = termsSections[idx].contents[index]
                            
                            if !article.subTitle.isEmpty {
                                Text(article.subTitle)
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color(hex: "#252525"))
                                    .padding(.bottom, 8)
                            }
                            
                            Text(article.content)
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(Color(hex: "#70706E"))
                                .lineSpacing(4)
                                .padding(.bottom, 8)
                        }
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                }
                Spacer().frame(height: 120)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    TermsSheetView()
}
