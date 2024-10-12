import SwiftUI

struct lanuch: View {
   
    var body: some View {
        
        NavigationView{
            
            VStack (spacing :50){
  
                
                Image("image1")
                VStack{
                    Text("Wanna save some cash?")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Text("Know where your money goes")
                        .font(.title3)
                     //   .foregroundColor(.color)
                        .padding(.trailing)
                }
                
                NavigationLink(destination: Splash()){
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 280 ,height: 50)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10.0)
                    
                }
                    
                
            }
       }
        .padding()
    }
}
//#Preview {
//    lanuch()
//}
