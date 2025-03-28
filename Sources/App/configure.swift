import Vapor

public func configure(_ app: Application) async throws {
    Task { @MainActor in
        do {
            try Challenges.shared.load()
        } catch {
            print("Error loading challenges: \(error)")
        }
        
    }
    try routes(app)
}
