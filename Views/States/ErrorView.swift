import SwiftUI  // Import du framework SwiftUI pour créer des interfaces graphiques

// Vue pour afficher un message d'erreur
struct ErrorView: View {
    
    // Message d'erreur à afficher
    let message: String

    var body: some View {
        // Affiche le texte du message
        Text(message)
            .foregroundColor(.red) // Texte en rouge
            .padding()             // Ajoute un espace autour du texte
            .background(Color.red.opacity(0.1)) // Fond rouge clair avec transparence
            .cornerRadius(12)      // Coins arrondis pour un style "card"
    }
}
