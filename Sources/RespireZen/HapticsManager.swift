import Foundation
import UIKit

class HapticsManager {
    static let shared = HapticsManager()
    private init() {}
    private let generator = UIImpactFeedbackGenerator(style: .light)

    func trigger() {
        generator.prepare()
        generator.impactOccurred()
    }
}
