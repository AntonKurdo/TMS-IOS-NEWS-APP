import SwiftUI
import SkeletonUI

struct ProfileView: View {
    @Environment(AppSettings.self) var appSetting
    
    @ObservedObject var vm = ProfileViewModal()
    
    var body: some View {
        VStack {
            Avatar(uiImage: $vm.uiImage, imageSelection: $vm.imageSelection, avatarUrl: $vm.avatarUrl)
                .skeleton(with: vm.loading, size: CGSize(width: 160, height: 160), shape: .circle)
            Spacer().frame(height: 32)
            TextInput(label: "First Name", placeholder: "Enter name...", isRequired: true, value: $vm.firstName)
                .skeleton(with: vm.loading, size: CGSize(width: UIScreen.main.bounds.width * 0.95, height: 45), shape: .capsule)
            Spacer().frame(height: 16)
            TextInput(label: "Last Name", placeholder: "Enter lastname...", isRequired: true, value: $vm.lastName)
                .skeleton(with: vm.loading, size: CGSize(width: UIScreen.main.bounds.width * 0.95, height: 45), shape: .capsule)
            Spacer().frame(height: 16)
            HStack {
                Text("Choose the language:")
                Spacer()
                Picker("", selection: $vm.selectedLanguage) {
                    ForEach(vm.languages, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: vm.selectedLanguage) {
                    if self.vm.selectedLanguage == "Russian" {
                        appSetting.locale = Locale(identifier:  "ru")
                    } else {
                        appSetting.locale = Locale(identifier:  "en")
                    }
                }
            }
            .padding()
            .skeleton(with: vm.loading, size: CGSize(width: UIScreen.main.bounds.width * 0.95, height: 45), shape: .capsule)
            Spacer().frame(height: 64)
            if !vm.loading {
                Button {
                    vm.logout()
                } label: {
                    Text("Logout")
                }
                .buttonStyle(.borderedProminent)
            }
            Spacer()
        }
        .navigationTitle("Settings")
        .onAppear {
            vm.getDataFromStorage()
        }
    }
}
