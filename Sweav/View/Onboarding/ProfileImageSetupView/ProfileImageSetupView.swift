import SwiftUI
import PhotosUI
import Kingfisher

struct ProfileImageSetupView: View {
    @State private var isDefaultKakaoProfile: Bool = true
    @State private var kakaoProfileImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    
    let profileImageUrl = UserDefaults.standard.string(forKey: "profileImageUrl") ?? ""
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                // TODO: Back
            } label: {
                Image("BackButton")
            }
            .padding(.vertical, 14)
            .padding(.leading, -20)
            
            Text("프로필 사진이 있으신가요?")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.default)
                .padding(.top, 40)
            
            Text("설정하지 않으면 기본 프로필 이미지로 설정돼요.\n프로필 사진은 피드를 통해 다른 사람들에게 보여요.")
                .font(.system(size: 14))
                .foregroundStyle(Color.tertiary)
                .padding(.top, 12)
            
            ZStack(alignment: .bottomTrailing) {
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                    
                    Button {
                        self.selectedImage = nil
                    } label: {
                        Image("Delete")
                    }
                    .padding(8)
                } else if let url = URL(string: profileImageUrl) {
                    KFImage(URL(string: profileImageUrl))
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                    
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Image("Add")
                    }
                    .onChange(of: selectedItem) { newItem in
                        if let newItem {
                            Task {
                                if let data = try? await newItem.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    selectedImage = uiImage
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 100)
            
            Spacer()
            
            // TODO: Button 
            Button {
                
            } label: {
                Text("버튼")
            }
            
        }
        .padding(.horizontal, 40)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProfileImageSetupView()
}
