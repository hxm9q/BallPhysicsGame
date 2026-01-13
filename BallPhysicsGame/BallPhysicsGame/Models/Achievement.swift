import Foundation

struct Achievement: Identifiable, Codable {
    let id: String
    var title: String
    var description: String
    var progress: Double = 0
    var isUnlocked: Bool = false
    var unlockDate: Date? = nil
    
    var iconName: String {
        isUnlocked ? "medal.fill" : "medal"
    }
    
    var progressText: String {
        isUnlocked ? "Unlocked" : "\(Int(progress))%"
    }
}
