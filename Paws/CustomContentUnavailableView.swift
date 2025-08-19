
import SwiftUI

struct CustomContentUnavailableView: View {
    var icon:String
    var title:String
    var desription:String
    
    var body: some View {
        ContentUnavailableView{
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 96)
            
            Text(title)
                .font(.title)
            
            
        }description: {
            Text(desription)
        }
        .foregroundStyle(.tertiary)
    }//End body
}//End struct

#Preview {
    CustomContentUnavailableView(icon: "cat.circle", title: "no photo", desription: "Add a photo tot start")
}



