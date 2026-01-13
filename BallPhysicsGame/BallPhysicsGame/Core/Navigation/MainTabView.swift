import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            GameView()
                .tabItem {
                    Label("Game", systemImage: "gamecontroller")
                }
            
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar")
                }
            
            AchievementsView()
                .tabItem {
                    Label("Achievements", systemImage: "medal.star")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
    
}
