//
//  animal.swift
//  Cats or Dogs
//
//  Created by Bruna Fernanda Drago on 03/12/20.
//

import Foundation
import CoreML
import Vision

struct Result : Identifiable {
    var imageLabel : String
    var confidence : Double
    var id = UUID()
}

class Animal {
    
    //url for the image
    var imageURL : String
    
    //image data
    var imageData : Data?
    
    //classified results
    var results : [Result]
    
    let modelFile = try! MobileNetV2(configuration: MLModelConfiguration())
    
    init(){
        self.imageURL = ""
        self.imageData = nil
        self.results = []
    }
    
    init?(json: [String:Any]){
        
        //check that json has a url
        guard let imageURL = json["url"] as? String else { return nil}
        
        //set the animal properties
        self.imageURL = imageURL
        self.imageData = nil
        self.results = []
        
        //download the image data
        getImage()
    }
    func getImage(){
        
        //create a URL
        let url = URL(string: imageURL)
        
        //check that url isnt nil
        guard url != nil else{
            print("não foi possivel criar uma url")
            return
        }
        
        //get a url session
        let session = URLSession.shared
        
        //create a task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //check that there are no errors and that there was data
            if error == nil && data != nil {
                self.imageData = data
                self.classifyAnimal()
            }
        }
        //start the data task
        dataTask.resume()
    }
    
    func classifyAnimal(){
        
        //get a reference to the model
        let model = try! VNCoreMLModel(for: modelFile.model)
        
        //create an image handler
        let handler = VNImageRequestHandler(data: imageData!)
        
        // create a request to the model
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let results = request.results as? [VNClassificationObservation] else {
                print("Não foi possível classificar o animal")
                return
            }
            //update the results
            for classification in results{
                
                var identifier = classification.identifier
                identifier = identifier.prefix(1).capitalized + identifier.dropFirst()
                self.results.append(Result(imageLabel: identifier, confidence: Double(classification.confidence)))
            }
        }
        //execute the request
        do{
            try handler.perform([request])
        }catch{
            print("ïnvalid image")
        }
    }
}
