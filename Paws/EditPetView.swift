//
//  EditPetView.swift
//  Paws
//
//  Created by Wajd on 19/08/2025.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPetView: View {
    @Bindable var pet: Pet
    
    @State private var photosPickerItem: PhotosPickerItem?
    
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        Form{
            // MARK: - IMAGE
            if let imageData = pet.photo {
                if let image = UIImage(data:imageData){
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                    //to clip the photo rectangle shape
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                        .frame(minWidth: 0 , maxWidth: .infinity, minHeight: 0, maxHeight: 300)
                        .padding(.top)
                }
            }else{
                CustomContentUnavailableView(icon: "pawprint.circle", title: "No photo", desription: "Add a photo of your pet.")
                    .padding(.top)
            }
            
            // MARK: - PHOTO PICKER
            PhotosPicker(selection: $photosPickerItem, matching: .images){
                Label("Select a photo", systemImage: "photo.badge.plus")
                    .frame(minWidth: 0 , maxWidth: .infinity)
            }
            .listRowSeparator(.hidden)
            
            // MARK: - TEXT FIELD
            TextField("Name", text: $pet.name)
                .textFieldStyle(.roundedBorder)
                .font(.largeTitle)
                .fontWeight(.light)
                .padding(.vertical)
            
            // MARK: - BUTTON
            Button{
                dismiss()
            }label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(8)
                    .frame(minWidth: 0 , maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .listRowSeparator(.hidden)
            .padding(.bottom)
            
        }//End form
        .listStyle(.plain)
        .navigationTitle("Edit \(pet.name)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .onChange(of: photosPickerItem){
            Task{
                pet.photo = try? await photosPickerItem?.loadTransferable(type: Data.self)
            }
        }//End onChange
    }
}

#Preview {
    NavigationStack{
        do{
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Pet.self, configurations: configuration)
            let sampleData = Pet(name: "Daisy")
            
            return EditPetView(pet: sampleData)
                .modelContainer(container)
        } catch {
            fatalError("Could not load preview data.\(error.localizedDescription)")
        }
    }
}
