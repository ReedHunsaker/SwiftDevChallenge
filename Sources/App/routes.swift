import Vapor

func routes(_ app: Application) throws {
    app.get("") { req async -> [Framework] in
        let amount: Int = abs(req.query["count"] ?? 2)
        let challenges = Task { @MainActor in
            return Challenges.shared.random(n: amount)
        }
        return await challenges.value
    }
}
