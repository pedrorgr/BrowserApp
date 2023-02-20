import Foundation

public struct Organization: Codable, Identifiable {
    public let id: Int
    public let login: String
    public let avatar_url: String
}
