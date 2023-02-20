import Browsr_Lib
import SwiftUI

@MainActor
public class OrganizationsViewModel: ObservableObject {
    let remoteOrganizationLoader = RemoteOrganizationLoader()
    @Published var loadingStatus: LoadingStatus = .loading
    @Published var organizations: [OrganizationModel] = []

    func getOrganizations(query: String? = nil) async {
        do {
            let fetchedOrganizations = try await remoteOrganizationLoader.fetchOrganizations()
            organizations = fetchedOrganizations.map { MapHelper.mapToOrganizationModel(organization: $0) }
            loadingStatus = .success
        } catch {
            loadingStatus = .error
        }
    }

    func queryResults(query: String) -> [OrganizationModel] {
        organizations.filter { $0.name.lowercased().contains(query.lowercased()) }
    }

    func setFavorite(id: Int) {
        if var organization = organizations.first(where: { $0.id == id }) {
            organization.isFavorite = true
            var favorites = UserDefaultsHelper.getFavorites()
            favorites.append(id)
            UserDefaultsHelper.setFavorites(favorites: favorites)
        }
    }

    func removeFavorite(id: Int) {
        if var organization = organizations.first(where: { $0.id == id }) {
            organization.isFavorite = false
            var favorites = UserDefaultsHelper.getFavorites()
            favorites.removeAll(where: { $0 == id })
            UserDefaultsHelper.setFavorites(favorites: favorites)
        }
    }
}
