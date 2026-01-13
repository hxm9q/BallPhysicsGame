import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Home")
        }
        .ignoresSafeArea(edges: .top)
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .idle, .loading:
            LoadingView()
        case .loaded:
            Text("Welcome to Ball Bounce Game!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        case .error:
            if let error = viewModel.error {
                ErrorView(error: error) {
                }
            }
        }
    }
    
}
