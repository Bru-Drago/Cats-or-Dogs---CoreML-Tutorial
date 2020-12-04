//
//  AnimalModel.swift
//  Cats or Dogs
//
//  Created by Bruna Fernanda Drago on 03/12/20.
//

import Foundation

class AnimalModel : ObservableObject {
    
   @Published var animal = Animal()
    
    func getAnimal(){
        
        let stringUrl = Bool.random() ? catUrl : dogUrl
        
        //create a URL object
        let url = URL(string: stringUrl)
        //check if the URL inst nil
        guard url != nil else {
            print("Não foi possível criar uma URL ")
            return
        }
        // get the URL session
        let session = URLSession.shared
        
        // create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil{
                
                //attemp to parse JSON
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]] {
                        
                        let item = json.isEmpty ? [:] : json[0]
                        
                        if let animal = Animal(json: item){
                            DispatchQueue.main.async {
                                
                                while animal.results.isEmpty {}
                                self.animal = animal
                            }
                        }
                    }
                }catch{
                    print("erro no parse do json")
                }
            }
        }
        // start the data task
        dataTask.resume()
    }
}
