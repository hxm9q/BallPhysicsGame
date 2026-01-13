import SwiftUI

struct AchievementsView: View {
    @StateObject private var viewModel = AchievementsViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.achievements) { achievement in
                HStack {
                    Image(systemName: achievement.iconName)
                        .font(.title2)
                        .foregroundStyle(achievement.isUnlocked ? .yellow : .gray)
                        .frame(width: 44)
                    
                    VStack(alignment: .leading) {
                        Text(achievement.title)
                            .font(.headline)
                        Text(achievement.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Text(achievement.progressText)
                        .font(.caption)
                        .foregroundStyle(achievement.isUnlocked ? .green : .gray)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Achievements")
            .onAppear {
                viewModel.load()
            }
        }
    }
    
}
