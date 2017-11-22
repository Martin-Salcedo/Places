//
//  AddPlaceViewController.swift
//  Lugares
//
//  Created by Jose Martin Salcedo Lazaro on 11/6/17.
//  Copyright © 2017 Jose Martin Salcedo Lazaro. All rights reserved.
//

import UIKit

class AddPlaceViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
  
  @IBOutlet weak var userImage: UIImageView!
  
  @IBOutlet weak var txtPhonePlace: UITextField!
  @IBOutlet weak var txtPagePlace: UITextField!
  @IBOutlet weak var txtNamePlace: UITextField!
  @IBOutlet weak var txtTypePlace: UITextField!
  @IBOutlet weak var txtDirectionPlace: UITextField!
  
  
  @IBOutlet weak var btnUno: UIButton!
  @IBOutlet weak var btnDos: UIButton!
  @IBOutlet weak var btnTres: UIButton!
  
  var place: Place?
  
  var rating: String!
  

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      print("seleccion de la imagen")
      
      if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true)
      }
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    self.userImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    
    self.userImage.contentMode = .scaleAspectFill
    self.userImage.clipsToBounds = true
    
//    autocontraint for code
    /*
     -- del elemento
     item: el elemento que se va a configurar
     attribute: que se configura (izquierdo, derecho, abajo y arriba)
     relatedBy: es el tipo de relacion (equal, greaterOrEqual, lessThanOrEqual)
     -- del elemento que lo contiene
     toItem: el elemento a que se iguale(al view que se encuentra)
     attribute: que se configura (izquierdo, derecho, abajo y arriba)
     multipler: el factor del tamaño que sea el elemento
     constant: es el numero que se indica para el tamaño de la constraint
     */
    
//    declaracion de una constraint por codigo
//    let leadingConstraint = NSLayoutConstraint(item: self.userImage, attribute: .leading, relatedBy: .equal, toItem: self.userImage.superview, attribute: .leading, multiplier: 1.0, constant: 0)
//    se manda a activar
//    leadingConstraint.isActive = false
    
    
    dismiss(animated: true)
  }
  
  let redColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
  let greenColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
  
  @IBAction func ratingPressed(_ sender: UIButton) {
    
    switch sender.tag {
    case 0:
      self.rating = "deslike"
      self.btnUno.backgroundColor = greenColor
      self.btnDos.backgroundColor = redColor
      self.btnTres.backgroundColor = redColor
    case 1:
      self.rating = "good"
      self.btnUno.backgroundColor = redColor
      self.btnDos.backgroundColor = greenColor
      self.btnTres.backgroundColor = redColor
    case 2:
      self.rating = "great"
      self.btnUno.backgroundColor = redColor
      self.btnDos.backgroundColor = redColor
      self.btnTres.backgroundColor = greenColor
    default:
      break
    }
    
  }
  
  
  
  
  @IBAction func saveData(_ sender: UIBarButtonItem) {
    
    if let namePlace = txtNamePlace.text, let typePlace = txtTypePlace.text,
          let directionPlace = txtDirectionPlace.text,
          let phoneNumber = txtPhonePlace.text,
          let site = txtPagePlace.text,
          let userImage = self.userImage.image,
          let ratingUser = self.rating {
      
      place = Place(name: namePlace, type: typePlace, location: directionPlace, image: userImage, phone: phoneNumber, pageWeb: site)
      place!.rating = ratingUser
      print("name : \(place!.name)")
      self.performSegue(withIdentifier: "unwindToMainViewController", sender: self)
  }else {
      print("Error")
      return
    }
    
   
    
  }
  
  
  

}
