//
//  ViewController.swift
//  MisRecetas
//
//  Created by Juan Gabriel Gomila Salas on 31/8/16.
//  Copyright © 2016 Juan Gabriel Gomila Salas. All rights reserved...
//

import UIKit

class ViewController: UITableViewController { /*UIViewController, UITableViewDataSource, UITableViewDelegate*/
  
  var places : [Place] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
//    var place =
    
    places.append(Place(name: "Alexandreplatz", type: "plaza", location: "10178 Berlín, Alemania", image: #imageLiteral(resourceName: "alexanderplatz"), phone: "N/A", pageWeb:"berlin.de"))
    places.append(Place(name: "Atomium", type: "museo", location: "Square de l'Atomium, 1020 Bruxelles, Bélgica", image: #imageLiteral(resourceName: "atomium"), phone: "+32 2 475 47 75", pageWeb:"atomium.be"))
    places.append(Place(name: "Big Ben", type: "munumento", location: "Westminster, Londres SW1A 0AA, Reino Unido", image: #imageLiteral(resourceName: "bigben"), phone: "+44 20 7219 4272", pageWeb:"parliament.uk"))
    places.append(Place(name: "Cristo Redentor", type: "onumento", location: "Santa Teresa, Río de Janeiro - Estado de Río de Janeiro, Brasil", image: #imageLiteral(resourceName: "cristoredentor"), phone: "N/A", pageWeb:"N/A"))
    places.append(Place(name: "Torre Eifel", type: "onumento", location: "Champ de Mars, 5 Avenue Anatole France, 75007 Paris, Francia", image: #imageLiteral(resourceName: "torreeiffel"), phone: "+33 892 70 12 39", pageWeb:"toureiffel.paris"))
    places.append(Place(name: "Muralla China", type: "monumento", location: "Huairou, China", image: #imageLiteral(resourceName: "murallachina"), phone: "N/A", pageWeb:"N/A"))
    places.append(Place(name: "Torre de Pisa", type: "plaza", location: "Piazza del Duomo, 56126 Pisa PI, Italia", image: #imageLiteral(resourceName: "torrepisa"), phone: "+39 050 835011", pageWeb:"opapisa.it"))
    places.append(Place(name: "Mallorca", type: "plaza", location: "Plaza Almoina, s/n, 07001 Palma, Illes Balears, España", image: #imageLiteral(resourceName: "mallorca"), phone: "+34 902 02 24 45", pageWeb:"catedraldemallorca.org"))
    places.append(Place(name: "Estadio Azteca", type: "estadio", location: "Calz. de Tlalpan 3465, Sta. Úrsula Coapa, Coyoacán, 04650 Ciudad de México, CDMX", image: #imageLiteral(resourceName: "estadioAzteca"), phone: "01 55 5487 3100", pageWeb:"estadioazteca.com.mx"))
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnSwipe = true
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  
  //MARK: - UITableViewDataSource
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.places.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let place = places[indexPath.row]
    let cellID = "PlaceCell"
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PlaceCell
    
    cell.thumbnailImageView.image = place.image
    cell.nameLabel.text = place.name
    cell.direccionLabel.text = place.location
    
    
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      
      self.places.remove(at: indexPath.row)
      
    }
    
    self.tableView.deleteRows(at: [indexPath], with: .fade)
    
  }
  
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    //Compartir
    let shareAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
      
      let shareDefaultText = "Estoy mirando la receta de \(self.places[indexPath.row].name!) en la App del curso de iOS 10 con Juan Gabriel"
      
      let activityController = UIActivityViewController(activityItems: [shareDefaultText, self.places[indexPath.row].image!], applicationActivities: nil)
      self.present(activityController, animated: true, completion: nil)
    }
    
    shareAction.backgroundColor = UIColor(red: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)
    
    //Borrar
    let deleteAction = UITableViewRowAction(style: .default, title: "Borrar") { (action, indexPath) in
      self.places.remove(at: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    
    return [shareAction, deleteAction]
  }
  
  
  
  //MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let selectedPlace = self.places[indexPath.row]
        let destinationViewController = segue.destination as! DetailViewController
        destinationViewController.place = selectedPlace
      }
    }
  }
  
  @IBAction func unwindToMainViewController(segue: UIStoryboardSegue){
    if segue.identifier  == "unwindToMainViewController"{
      if let addplaceVC = segue.source as? AddPlaceViewController {
        let newPlace = addplaceVC.place
        self.places.append(newPlace!)
        self.tableView.reloadData()
      }
    }
  }
  
  
  
}

