//
//  EditView.swift
//  MICHAELMCGINNIS-BucketList
//
//  Created by Michael Mcginnis on 4/17/22.
//

import SwiftUI

struct EditView: View {
    //let location: Location
    //self.onSave = onSave
    @StateObject var viewModel: EditViewModel

    @Environment(\.dismiss) var dismiss
    
    var onSave: (Location) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description

                    onSave(newLocation)
                    dismiss()
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task{
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
}

/*
struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example){newLocation in}
    }
}*/
