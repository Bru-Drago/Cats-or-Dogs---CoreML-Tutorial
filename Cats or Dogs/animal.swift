//
//  animal.swift
//  Cats or Dogs
//
//  Created by Bruna Fernanda Drago on 03/12/20.
//

import Foundation

class Animal {
    
    //url for the image
    var imageURL : String
    
    //image data
    var imageData : Data?
    
    init(){
        self.imageURL = ""
        self.imageData = nil
    }
    
    init(json: [String:Any]){
        
        //check that json has a url
        //set the animal properties
        //download the image data
    }
}
