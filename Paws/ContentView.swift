
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query private var pets: [Pet]
    
    @State private var path = [Pet]()
    
    @State private var isEditing: Bool = false
    
    let layout = [
        GridItem(.flexible(minimum: 120)),
        GridItem(.flexible(minimum: 120))
    ]
    
    func addPet() {
        isEditing = false
        let pet = Pet(name: "Best Friend")
        modelContext.insert(pet)
        path = [pet]
    }
    
    var body: some View {
        NavigationStack(path: $path){
            ScrollView{
                LazyVGrid(columns: layout){
                    GridRow{
                        ForEach(pets) { pet in
                            NavigationLink(value: pet){
                                VStack{
                                    if let imageData = pet.photo {
                                        if let image = UIImage(data:imageData){
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                                        }
                                    }else{
                                        Image(systemName: "pawprint.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(40)
                                            .foregroundStyle(.quaternary)
                                    }
                                    
                                    Spacer()
                                    Text(pet.name)
                                        .font(.title)
                                        .fontWeight(.light)
                                        .padding(.vertical)
                                    
                                    Spacer()
                                }//End Vstack
                                .frame(minWidth:0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                                .overlay(alignment: .topTrailing){
                                    if isEditing {
                                        Menu{
                                            Button("Delete", systemImage:"trash", role: .destructive){
                                                withAnimation{
                                                    modelContext.delete(pet)
                                                    try? modelContext.save()
                                                }
                                            }
                                        }label:{
                                            Image(systemName: "trash.circle.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 36, height: 36)
                                                .foregroundStyle(.red)
                                                .symbolRenderingMode(.multicolor)
                                                .padding()
                                        }
                                    }
                                }
                            }//End navigationlink
                            .foregroundStyle(.primary)
                        }//End foreach
                    }//End girdrow
                }//End lazyVgrid
                .padding(.horizontal)
                .padding(.vertical)
            }//End scrollView
            .navigationTitle(pets.isEmpty ? "" : "Paw")
            .navigationDestination(for: Pet.self, destination: EditPetView.init)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        withAnimation{
                            isEditing.toggle()
                        }
                    }label:{
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add new pet", systemImage: "plus.circle", action: addPet)
                }//End toolbarItem
                
                
            }//End toolbar
            .overlay{
                if pets.isEmpty{
                    CustomContentUnavailableView(icon: "dog.circle", title: "no photo", desription: "Add photo to start")
                }
            }
        }//End navigationStack
    }//End body
}


//Dummy Data
#Preview("Sample Data") {
    ContentView()
        .modelContainer(Pet.preview)
}


#Preview("No data") {
    ContentView()
        .modelContainer(for: Pet.self, inMemory: true)
}
