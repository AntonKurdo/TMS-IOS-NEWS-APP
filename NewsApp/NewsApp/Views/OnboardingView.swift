import SwiftUI

struct OnboardingView: View {
    private struct OnboardingItem {
        let img: UIImage
        let text: String
    }
    
    @State private var images: [OnboardingItem] = [OnboardingItem(img: .onboarding1, text: "Get the news faster than others..."), OnboardingItem(img: .onboarding2, text: "Read about important events on fly..."), OnboardingItem(img: .onboarding3, text: "Always in your pockets")]
    
    @ObservedObject var vm: OnboardingViewModel = OnboardingViewModel()
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 0) {
                    ForEach(0..<images.count) { imageIdx in
                        ZStack(alignment: .top) {
                            Image(uiImage: images[imageIdx].img)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.75)
                                .aspectRatio(contentMode: .fit)
                            LinearGradient(colors: [.black.opacity(0), .black.opacity(0.8)], startPoint: .center, endPoint: .bottom)
                        }
                        .id(imageIdx)
                    }
                }
                .scrollTargetLayout()
                .overlay(alignment: .bottom) {
                    PaginationIndicator()
                }
            }
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $vm.scrolledID)
            .scrollIndicators(.hidden)
            .edgesIgnoringSafeArea(.all)
        }
        .overlay(alignment: .bottom) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.3)
                    .foregroundStyle(.ultraThinMaterial).overlay(alignment: .top) {
                        HStack {
                            Button(action: {
                                withAnimation {
                                    vm.scrolledID! -= 1
                                }
                            }) {
                                Text("Prev").foregroundStyle(.accent)
                            }
                            .disabled(vm.scrolledID == 0)
                            .buttonStyle(.borderedProminent)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                   vm.scrolledID! += 1
                                }

                            }) {
                                Text("Next").foregroundStyle(.accent)
                            }
                            .disabled(vm.scrolledID == images.count - 1)
                            .buttonStyle(.borderedProminent)
                        }.padding(16)
             
                    }
                Text(LocalizedStringKey(vm.scrolledID == 0 ? images[0].text : vm.scrolledID == 1 ? images[1].text : images[2].text)).font(.title).foregroundColor(.white).padding().multilineTextAlignment(.center)
            }
        }
        .overlay(alignment: .top) {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink {
                        Tabs().navigationBarBackButtonHidden(true)
                    } label: {
                        Text(vm.scrolledID ?? 0 < images.count - 1 ? "Skip" : "Finish").foregroundColor(.white).buttonStyle(.borderedProminent).font(.system(size: 20))
                    }
                    .padding(16)
                    .simultaneousGesture(TapGesture().onEnded {
                        vm.isOnboardingFinished = true
                        
                    })
                }
            }
        }
    }
}
