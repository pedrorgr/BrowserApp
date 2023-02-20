import Foundation

class UserDefaultsHelper {
    static private let favoritesKey: String = "favorites"

    static func getFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
    }

    static func setFavorites(favorites: [Int]) {
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }
}
