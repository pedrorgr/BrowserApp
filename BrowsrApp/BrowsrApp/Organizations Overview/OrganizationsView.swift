import SwiftUI
import Browsr_Lib

struct OrganizationsView: View {
    @StateObject var organizationsViewModel = OrganizationsViewModel()
    @State var searchText = ""
    @State var isFavorite: Bool = false

    var body: some View {
        NavigationStack {
            List {
                switch organizationsViewModel.loadingStatus {
                case .error:
                    Text("Something went wrong")
                case .loading:
                    Text("Loading...")
                case .success:
                    ForEach(results) { organization in
                        Text(organization.name.capitalized).foregroundColor(organization.isFavorite ? .red : .blue)
                            .swipeActions {
                                if organization.isFavorite {
                                    Button("Remove Favorite") {
                                        organizationsViewModel.removeFavorite(id: organization.id)
                                    }
                                    .tint(.red)
                                } else {
                                    Button("Add Favorite") {
                                        organizationsViewModel.setFavorite(id: organization.id)
                                    }
                                    .tint(.green)
                                }
                            }
                    }
                }
            }
            .navigationTitle("Organizations")
        }
        .searchable(text: $searchText, prompt: "Search organizations..")
        .task {
            await organizationsViewModel.getOrganizations()
        }
    }

    var results: [OrganizationModel] {
        if searchText.isEmpty {
            return organizationsViewModel.organizations
        } else {
            return organizationsViewModel.queryResults(query: searchText)
        }
    }
}
