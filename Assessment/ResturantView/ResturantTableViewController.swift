//
//  ResturantTableViewController.swift
//  Assessment
//
//  Created by admin on 14/09/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftLocation
import NVActivityIndicatorView
import SwiftGifOrigin

class ResturantTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    
    @IBAction func CheckInternetConnection(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            self.NetworkErrorView.isHidden = true
        }else {
            self.NetworkErrorView.isHidden = false
        }
        
    }
    
    
    @IBOutlet weak var NetworkErrorView: UIView!
    @IBOutlet weak var LoadingViewRadar: NVActivityIndicatorView!
    
    @IBOutlet weak var Networkerrorimg: UIImageView!
    
    
    var Resturantdata = [ResturantData]()
    var photos = [UIImage]()
   private let locationManager = CLLocationManager()
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            print("status = \(status)")
            return
        }
        
        
        
        locationManager.startUpdatingLocation()
        
        
    }
    
    
    
    private let dataProvider = GoogleDataProvider()
    private let searchRadius: Double = 5000
    var searchedTypes = ["restaurant"]
    
    
    
    private func fetchPhotoFromReference(image : UIImage) {
        
    }
    private func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: searchedTypes) { places in
            places.forEach {x in
               
               
                
                if !x.address.isEmpty && (x.isopen) != nil && !x.name.isEmpty && (x.rating) != nil {
                    
                    if x.photoReference != nil {
                        let data = ResturantData.init(isopen: x.isopen!, address: x.address, coordinate: x.coordinate, name: x.name, placeType: x.placeType, rating: x.rating!,refrences: x.photoReference!)
                        self.Resturantdata.append(data)
                        self.resturantTable.reloadData()
                        
                        self.LoadingViewRadar.stopAnimating()
                    }
                    
                   
                }else {
                    let alertbox = UIAlertController(title: "Data Error", message: "No Data Avialable Or Request Limit", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .cancel, handler: { (Void) in
                        
                    })
                    alertbox.addAction(ok)
                    self.present(alertbox, animated: true, completion: nil)
                   
                }
                
              
                
            
                
               
            }
        }
    }

    
    @IBAction func Backbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   var device =  UIDevice.current.model
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Resturantdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Rcell", for: indexPath) as? RestaurantTableViewCell
        LoadingViewRadar.isHidden = true
        LoadingViewRadar.stopAnimating()
        
        cell?.ResturantName.text = self.Resturantdata[indexPath.row].name
        cell?.ResturantAddress.text = self.Resturantdata[indexPath.row].address
  
        if self.Resturantdata[indexPath.row].isopen  {
            cell?.OpenValue.text = "Open"
            let image = UIImage(named: "isopen")
            cell?.Openimg.image = image
            
        }else {
             cell?.OpenValue.text = "Closed"
            let image = UIImage(named: "isclose")
            cell?.Openimg.image = image
        }

        self.dataProvider.fetchPhotoFromReference(self.Resturantdata[indexPath.row].refrences) {
            images in
          cell?.resturantImg.image = images
        }
      
      
            
            
            
       
        
        
       
        
       
        
     

  
       
        
 
        let ratev = self.Resturantdata[indexPath.row].rating
       cell?.RatingValue.rating = Double(ratev)
        cell?.RateValue.text = ratev.description
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(device == "iPhone")
        if UIDevice.current.model.contains("iPhone") {
            return self.resturantTable.rowHeight
        }else {
            return self.resturantTable.rowHeight
        }
       
    }

    @IBOutlet weak var resturantTable: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingViewRadar.type = NVActivityIndicatorType.circleStrokeSpin
        LoadingViewRadar.isHidden = false
        LoadingViewRadar.startAnimating()
        Networkerrorimg.image = UIImage.gif(name: "networkError")
        if Reachability.isConnectedToNetwork() {
            self.NetworkErrorView.isHidden = true
        }else {
            self.NetworkErrorView.isHidden = false
        }
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        Locator.requestAuthorizationIfNeeded()
        
        Locator.currentPosition(accuracy: .city, onSuccess: { (loc) -> (Void) in
            print(loc)
            self.fetchNearbyPlaces(coordinate: loc.coordinate)
            
        }) { (error, loc) -> (Void) in
            print(error)
        }
      
        resturantTable.delegate = self
        resturantTable.dataSource = self
        resturantTable.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellReuseIdentifier: "Rcell")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
