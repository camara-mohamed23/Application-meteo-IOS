import SwiftData   // Import pour utiliser SwiftData et les modèles persistants
import Foundation  // Import nécessaire pour Date

// Modèle SwiftData représentant une ville recherchée
@Model
class City {
    
    // Nom de la ville, doit être unique dans la base de données
    @Attribute(.unique) var name: String
    
    // Date à laquelle la ville a été ajoutée (pour trier l'historique)
    var date: Date
    
    // Constructeur
    init(name: String) {
        self.name = name
        self.date = Date() // Initialise avec la date actuelle
    }
}
