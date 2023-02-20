import Browsr_Lib
import Foundation

class MapHelper {

    static func mapToOrganizationModel(organization: Organization) -> OrganizationModel {
        let favorites = UserDefaultsHelper.getFavorites()
        let isFavorite = favorites.contains(where: { $0 == organization.id })
        return OrganizationModel(id: organization.id,
                                 name: organization.login,
                                 avatar_url: organization.avatar_url,
                                 isFavorite: isFavorite)
    }

}
