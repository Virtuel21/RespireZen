# RespireZen

RespireZen est une application iOS de respiration guidée permettant de réduire le stress sans connexion réseau ni compte utilisateur.

## Fonctionnalités
- Animation de cercle synchronisée avec la respiration
- Sons d'ambiance optionnels chargés localement
- Vibrations haptiques lors des transitions
- Paramètres de rythme et de durée stockés via `UserDefaults`

## Structure du code
Le dossier `Sources/RespireZen` contient un projet SwiftUI minimal :
- `RespireZenApp.swift` : point d'entrée de l'application
- `ContentView.swift` : écran principal et logique de session
- `SettingsView.swift` : écran de configuration
- `UserSettings.swift` : stockage des préférences
- `AudioManager.swift` et `HapticsManager.swift` : gestion du son et des vibrations

Les ressources audio et visuelles sont attendues dans `Resources/Sounds` et `Resources/Icons`.

## Compilation
Ouvrez le projet dans Xcode 14+ et lancez l'exécution sur un simulateur ou un appareil iOS.

