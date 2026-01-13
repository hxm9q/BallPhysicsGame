import Foundation

@MainActor
class AchievementService {
    static let shared = AchievementService()
    
    private let defaults = UserDefaults.standard
    private let key = AchievementsData.storageKey
    
    private(set) var achievements: [Achievement] = []
    
    init() {
        load()
        if achievements.isEmpty {
            achievements = AchievementsData.all
            save()
        }
    }
    
    func load() {
        if let data = defaults.data(forKey: key),
           let saved = try? JSONDecoder().decode([Achievement].self, from: data) {
            achievements = saved
        }
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(achievements) {
            defaults.set(data, forKey: key)
        }
    }
    
    func updateProgress(for id: AchievementID, progress: Double) {
        guard let index = achievements.firstIndex(where: { $0.id == id.rawValue }) else { return }
        
        var achievement = achievements[index]
        
        if achievement.isUnlocked { return }
        
        achievement.progress = min(max(progress, achievement.progress), 100)
        
        if achievement.progress >= 100 {
            achievement.isUnlocked = true
            achievement.unlockDate = Date()
        }
        
        achievements[index] = achievement
        save()
    }
    
    func unlock(_ id: AchievementID) {
        updateProgress(for: id, progress: 100)
    }
    
    func resetAll() {
        achievements = AchievementsData.all
        save()
    }
    
}
