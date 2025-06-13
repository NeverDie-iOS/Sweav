import SwiftUI
import PhotosUI
import Kingfisher
import Alamofire

struct ProfileImageSetupView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @Binding var navigationPath: NavigationPath
    
    @StateObject var profileImageSetupVM = ProfileImageSetupViewModel()
    
    let profileImageUrl = UserDefaults.standard.string(forKey: "profileImageUrl") ?? ""
    let isDefaultImage = UserDefaults.standard.string(forKey: "profileImgDefault") ?? "0"
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                navigationPath.removeLast()
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
            
            Button {
                if isDefaultImage == "1" && selectedImage == nil {
                    let image = UIImage(named: "DefaultProfileImage")
                    let imageData = image?.jpegData(compressionQuality: 0.8)
                    UserDefaults.standard.set(imageData, forKey: "profileImageData")
                } else if isDefaultImage == "0" && selectedImage == nil{
                    if let url = URL(string: profileImageUrl) {
                        AF.request(url).responseData { response in
                            if let data = response.data {
                                UserDefaults.standard.set(data, forKey: "profileImageData")
                            }
                        }
                    }
                } else {
                    let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
                    UserDefaults.standard.set(imageData, forKey: "profileImageData")
                    profileImageSetupVM.uploadProfileImage(imageData: imageData) {
                        navigationPath.append(OnboardingRoute.genderSelection)
                    }
                }
            } label: {
                if isDefaultImage == "1" && selectedImage == nil {
                    Text("건너뛰기")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.main)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 17)
                        .background(Color.white)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 1)
                                .stroke(Color.main, lineWidth: 2)
                        )
                } else {
                    Text("다음")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 17)
                        .background(Color.main)
                        .cornerRadius(16)
                }
            }
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
            ProfileImageSetupView(navigationPath: $navigationPath)
        }
    }
    return PreviewWrapper()
}
