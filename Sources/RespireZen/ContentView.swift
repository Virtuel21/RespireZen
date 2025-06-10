import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings
    @State private var running = false
    @State private var timeRemaining: Int = 0
    @State private var phase: BreathingPhase = .inhale
    @State private var progress: Double = 0
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            GradientBackground()
            VStack {
                Spacer()
                BreathingCircle(progress: progress)
                    .frame(width: 200, height: 200)
                    .padding()
                Spacer()
                Button(action: toggle) {
                    Text(running ? "Stop" : "Commencer")
                        .font(.title)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("startButton")
                Spacer()
            }
        }
        .sheet(isPresented: .constant(false)) {
            // placeholder for future history view
            Text("Historique")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                }
            }
        }
        .onAppear { reset() }
    }

    func toggle() {
        running.toggle()
        if running {
            startSession()
        } else {
            stopSession()
        }
    }

    func startSession() {
        timeRemaining = settings.sessionLength
        phase = .inhale
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            update()
        }
    }

    func stopSession() {
        timer?.invalidate()
        timer = nil
        running = false
    }

    func reset() {
        timeRemaining = settings.sessionLength
        progress = 0
    }

    func update() {
        guard running else { return }
        progress += 0.1 / durationForCurrentPhase
        if progress >= 1.0 {
            progress = 0
            phase = phase.next
            if phase == .complete {
                stopSession()
            }
            playHaptic()
        }
        if timeRemaining > 0 {
            timeRemaining -= 1
        }
    }

    var durationForCurrentPhase: Double {
        switch phase {
        case .inhale: return settings.inhaleDuration
        case .exhale: return settings.exhaleDuration
        case .hold: return settings.holdDuration
        case .complete: return 0
        }
    }

    func playHaptic() {
        guard settings.hapticsEnabled else { return }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

enum BreathingPhase {
    case inhale, hold, exhale, complete
    var next: BreathingPhase {
        switch self {
        case .inhale: return .hold
        case .hold: return .exhale
        case .exhale: return .inhale
        case .complete: return .complete
        }
    }
}

struct BreathingCircle: View {
    var progress: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.3), lineWidth: 8)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.white, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
        .animation(.easeInOut(duration: 0.1), value: progress)
    }
}

struct GradientBackground: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    var gradientColors: [Color] {
        if colorScheme == .dark {
            return [Color.black, Color.blue]
        } else {
            return [Color.blue, Color.cyan]
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSettings())
    }
}
