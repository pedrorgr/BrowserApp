import Foundation
import SwiftUI

public class RemoteOrganizationLoader {
    private let url = URL(string: "https://api.github.com/organizations")

    public init() {
    }


    public func fetchOrganizations() async throws -> [Organization] {

        guard let url = url else {
            throw CustomError.invalidURL
        }

        let request = URLRequest(url: url)

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode([Organization].self, from: data)
        } catch {
            throw CustomError.invalidData
        }
    }
}
