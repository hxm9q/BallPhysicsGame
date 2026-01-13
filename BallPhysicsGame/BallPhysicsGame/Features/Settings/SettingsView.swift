import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            Text("Settings Screen")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .navigationTitle("Settings")
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
}
