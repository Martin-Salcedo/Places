//
//  Place.swift
//  Lugares
//
//  Created by Jose Martin Salcedo Lazaro on 11/3/17.
//  Copyright © 2017 Jose Martin Salcedo Lazaro. All rights reserved.
//

import Foundation
import UIKit

class Place{
  
  var name: String!
  var location: String!
  var type: String!
  var image: UIImage!
  var phone: String!
  var pageWeb: String!
  var rating: String = "rating"
  
  init(name: String, type: String, location:String, image: UIImage){
    self.name = name
    self.type = type
    self.location = location
    self.image = image
  }
  
  init(name: String, type: String, location: String, image: UIImage, phone: String, pageWeb:String) {
    self.name = name
    self.type = type
    self.location = location
    self.image = image
    self.phone = phone
    self.pageWeb = pageWeb
  }
  
}
