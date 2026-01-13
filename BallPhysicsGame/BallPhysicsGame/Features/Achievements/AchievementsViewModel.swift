import Foundation
import Combine

final class AchievementsViewModel: BaseViewModel {
    @Published var achievements: [Achievement] = []
    
    private let service = AchievementService.shared
    
    func load() {
        achievements = service.achievements
    }
    
    func onAppear() {
        Logger.log(.info, "Achievements appeared")
    }
    
}
