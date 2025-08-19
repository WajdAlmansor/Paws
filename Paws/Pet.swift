import SwiftData
import Foundation

@Model
final class Pet {
    var name:String
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, photo: Data? = nil) {
        self.name = name
        self.photo = photo
    }
}

extension Pet {
    @MainActor
    static var preview: ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Pet.self, configurations: configuration)
        
        container.mainContext.insert(Pet(name: "Rexy"))
        container.mainContext.insert(Pet(name: "Belly"))
        container.mainContext.insert(Pet(name: "Diasy"))
        container.mainContext.insert(Pet(name: "Mimi"))
        container.mainContext.insert(Pet(name: "Fido"))
        container.mainContext.insert(Pet(name: "Gus"))
        container.mainContext.insert(Pet(name: "Luna"))
        container.mainContext.insert(Pet(name: "Nona"))
        
        return container
    }
}
