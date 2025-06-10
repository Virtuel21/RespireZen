import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: UserSettings
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Rythme")) {
                    Stepper(value: $settings.inhaleDuration, in: 1...10, step: 1) {
                        HStack {
                            Text("Inspiration")
                            Spacer()
                            Text("\(Int(settings.inhaleDuration))s")
                        }
                    }
                    Stepper(value: $settings.holdDuration, in: 0...10, step: 1) {
                        HStack {
                            Text("Rétention")
                            Spacer()
                            Text("\(Int(settings.holdDuration))s")
                        }
                    }
                    Stepper(value: $settings.exhaleDuration, in: 1...10, step: 1) {
                        HStack {
                            Text("Expiration")
                            Spacer()
                            Text("\(Int(settings.exhaleDuration))s")
                        }
                    }
                }
                Section(header: Text("Durée")) {
                    Picker("Durée de la session", selection: $settings.sessionLength) {
                        Text("1 min").tag(60)
                        Text("3 min").tag(180)
                        Text("5 min").tag(300)
                        Text("10 min").tag(600)
                    }
                    .pickerStyle(.segmented)
                }
                Section(header: Text("Options")) {
                    Toggle("Sons d'ambiance", isOn: $settings.soundEnabled)
                    Toggle("Vibrations", isOn: $settings.hapticsEnabled)
                }
            }
            .navigationTitle("Paramètres")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK") { presentationMode.wrappedValue.dismiss() }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(UserSettings())
    }
}
