import Foundation

struct OrganizationModel: Codable, Identifiable {
    let id: Int
    let name: String
    let avatar_url: String
    var isFavorite: Bool

    init(id: Int, name: String, avatar_url: String, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.avatar_url = avatar_url
        self.isFavorite = isFavorite
    }
}
