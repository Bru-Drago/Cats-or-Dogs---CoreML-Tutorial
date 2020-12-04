//
//  ContentView.swift
//  Cats or Dogs
//
//  Created by Bruna Fernanda Drago on 03/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model : AnimalModel
    var body: some View {
        VStack{
            GeometryReader { geometry in
            
            Image(uiImage: UIImage(data: model.animal.imageData ?? Data()) ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width,
                       height: geometry.size.height)
                .clipped()
                .edgesIgnoringSafeArea(.all)
            }
            
            HStack{
              Text("What is it?")
                .font(.title)
                .bold()
                .padding(.leading,10)
                
                Spacer()
                
                Button(action: {
                    self.model.getAnimal()
                }, label: {
                    Text("Next")
                        .bold()
                })
                .padding(.trailing,10)
            }
            List(model.animal.results){ result in
                HStack {
                    Text(result.imageLabel)
                    Spacer()
                    Text(
                        String(format: "%.2f%%",result.confidence * 100))
                }
                
            }
        }
        .onAppear(perform: model.getAnimal)
        .opacity(model.animal.imageData == nil ? 0 : 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: AnimalModel())
    }
}
