import Foundation
import SwiftUI

class UserSettings: ObservableObject {
    @Published var inhaleDuration: Double {
        didSet { UserDefaults.standard.set(inhaleDuration, forKey: "inhaleDuration") }
    }
    @Published var exhaleDuration: Double {
        didSet { UserDefaults.standard.set(exhaleDuration, forKey: "exhaleDuration") }
    }
    @Published var holdDuration: Double {
        didSet { UserDefaults.standard.set(holdDuration, forKey: "holdDuration") }
    }
    @Published var sessionLength: Int {
        didSet { UserDefaults.standard.set(sessionLength, forKey: "sessionLength") }
    }
    @Published var soundEnabled: Bool {
        didSet { UserDefaults.standard.set(soundEnabled, forKey: "soundEnabled") }
    }
    @Published var hapticsEnabled: Bool {
        didSet { UserDefaults.standard.set(hapticsEnabled, forKey: "hapticsEnabled") }
    }
    init() {
        self.inhaleDuration = UserDefaults.standard.double(forKey: "inhaleDuration")
        if inhaleDuration == 0 { inhaleDuration = 5 }
        self.exhaleDuration = UserDefaults.standard.double(forKey: "exhaleDuration")
        if exhaleDuration == 0 { exhaleDuration = 5 }
        self.holdDuration = UserDefaults.standard.double(forKey: "holdDuration")
        self.sessionLength = UserDefaults.standard.integer(forKey: "sessionLength")
        if sessionLength == 0 { sessionLength = 60 }
        self.soundEnabled = UserDefaults.standard.bool(forKey: "soundEnabled")
        self.hapticsEnabled = UserDefaults.standard.bool(forKey: "hapticsEnabled")
    }
}
