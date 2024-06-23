import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var alerter: Alerter
    
    @State var viewDidMount = false
    
    @ObservedObject var vm: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
            PopularNews(news: $vm.popularNews, loading: $vm.popularNewsLoading)
            Spacer().frame(height: 32)
            CategoryNews(newsCategories: vm.newsCategories, news: $vm.categoryNews, loading: $vm.categoryNewsLoading, activeCategory: $vm.activeCategory)
        }
        .contentMargins(.bottom, 75)
        .onChange(of: vm.activeCategory, { _, _ in
            vm.fetchCategoryNews(alerter: alerter)
        })
        .onAppear {
            if !viewDidMount {
                vm.fetchPopularNews(alerter: alerter)
                vm.fetchCategoryNews(alerter: alerter)
                viewDidMount = true
            }
        }
    }
}
