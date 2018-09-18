//
//  ViewController.swift
//  Assessment
//
//  Created by admin on 12/09/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SwiftLocation
import CoreLocation
import Alamofire
import NVActivityIndicatorView
import SwiftGifOrigin


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,CLLocationManagerDelegate {
    
    @IBAction func CheckNetworkConnection(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            self.NetworkConnectionErrorView.isHidden = true
            loadData()
        }else {
            self.NetworkConnectionErrorView.isHidden = false
        }
    }
    @IBOutlet weak var NetworkConnectionErrorView: UIView!
    @IBOutlet weak var NetworkErrorImg: UIImageView!
    
    var  locationManager  = CLLocationManager()
    var lat = Float()
    var lon = Float()
   var Api = ApiRequest()
    var weathrModel = [WeatherModel]()
    var citymodel : City?
    var coordmodel : Coord?
     var listmodel = [List]()
    var mainmodel : Main?
     var weatherm = [Weather]()
    var cloudsmodel : Cloud?
    var windmodel : Wind?
    var rainmodel : Rain?
    var sysmodel : Sys?
    var Ali = String()
    
    @IBOutlet weak var LoadingViewRadar: NVActivityIndicatorView!
    
    @IBOutlet weak var WeatherCastDailyColV: UICollectionView!
  

    @objc func loadpopularResturant(){
        print("Ali")
        performSegue(withIdentifier: "Resturant", sender: nil)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == WeatherCastDailyColV {
             return listmodel.count
        }else {
            return listmodel.count
        }
        
        }
       
    
  
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    
        if let layout = WeatherMainColV.collectionViewLayout as? UICollectionViewFlowLayout {
            var itemHeight = CGFloat()
            let itemWidth = view.bounds.width
            if UIDevice.current.model.contains("iPhone") {
                itemHeight = view.bounds.height - 200
            }else if UIDevice.current.model.contains("iPad") {
                 itemHeight = view.bounds.height - 300
            }
           
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
        
        if let layout = WeatherCastDailyColV.collectionViewLayout as? UICollectionViewFlowLayout {
            var itemHeight = CGFloat()
            let itemWidth = CGFloat(150)
            if UIDevice.current.model.contains("iPhone") {
                itemHeight = 120
            }else if UIDevice.current.model.contains("iPad") {
                 itemHeight = 150
            }
            
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
    }
   
    func loadData() {
        LoadingViewRadar.type = NVActivityIndicatorType.circleStrokeSpin
        
        LoadingViewRadar.isHidden = false
        LoadingViewRadar.startAnimating()
        locationManager.delegate = self
        Locator.requestAuthorizationIfNeeded()
        let token = Locator.events.listen { newStatus in
            print("Authorization status changed to \(newStatus)")
        }
        
        Locator.currentPosition(accuracy: .city, onSuccess: { (loc) -> (Void) in
            print(loc)
            
        }) { (error, loc) -> (Void) in
            print(error)
        }
        
        Locator.currentPosition(accuracy: .city, onSuccess: { location in
            self.lat = Float(location.coordinate.latitude)
            self.lon = Float(location.coordinate.longitude)
            print(location)
            print(self.lat)
            print(self.lon)
            self.Api.Get_Weather_Results(lat: Float(location.coordinate.latitude),lon: Float(location.coordinate.longitude)) {
                (staus,data,code) in
                print(staus)
                if staus {
                    self.LoadingViewRadar.isHidden = true
                    self.LoadingViewRadar.stopAnimating()
                    print("Result = \(String(describing: data))")
                    self.Ali = "Ahmed"
                    let citydata = data!["city"]
                    let coorddata = citydata["coord"]
                    
                    let listdata = data!["list"]
                    
                    
                    
                    self.coordmodel = Coord.init(lat: coorddata["lat"].floatValue, lon: coorddata["lon"].floatValue)
                    
                    self.citymodel = City.init(id: citydata["id"].intValue, name: citydata["name"].stringValue, country: citydata["country"].stringValue, coord: self.coordmodel!)
                    
                    for x in 0..<listdata.count {
                        
                        print(x)
                        
                        let listdataarray = listdata[x]
                        let listdatasys = listdataarray["sys"]
                        let listdatarain = listdataarray["rain"]
                        let listdatawind = listdataarray["wind"]
                        let listdataclouds = listdataarray["clouds"]
                        let listdataweatherarray = listdataarray["weather"]
                        
                        let listdatamain = listdataarray["main"]
                        
                        
                        
                        
                        
                        self.mainmodel = Main.init(temp: listdatamain["temp"].floatValue, temp_min: listdatamain["temp_min"].floatValue, temp_max: listdatamain["temp_max"].floatValue, pressure: listdatamain["pressure"].floatValue, sea_level: listdatamain["sea_level"].floatValue, grnd_level: listdatamain["grnd_level"].floatValue, humidity: listdatamain["humidity"].floatValue, temp_kf: listdatamain["temp_kf"].floatValue)
                        
                        
                        for y in  0..<listdataweatherarray.count {
                            let listdataweather = listdataweatherarray[y]
                            let data = Weather.init(id: listdataweather["id"].intValue, main: listdataweather["main"].stringValue, description: listdataweather["description"].stringValue, icon: listdataweather["icon"].stringValue)
                            self.weatherm.append(data)
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        self.cloudsmodel = Cloud.init(all: listdataclouds["all"].intValue)
                        
                        
                        
                        self.windmodel = Wind.init(speed: listdatawind["speed"].floatValue, deg: listdatawind["deg"].floatValue)
                        
                        
                        self.rainmodel = Rain.init(threeh: listdatarain["3h"].floatValue)
                        
                        self.sysmodel = Sys.init(pod: listdatasys["pod"].stringValue)
                        let data = List.init(dt: listdataarray["dt"].intValue, dt_txt: listdataarray["dt_txt"].stringValue, main: self.mainmodel!, weather: self.weatherm, clouds: self.cloudsmodel!, wind: self.windmodel!, rain: self.rainmodel!, sys: self.sysmodel!)
                        self.listmodel.append(data)
                        
                        
                        
                        //
                    }
                    
                    
                    self.WeatherCastDailyColV.reloadData()
                    self.WeatherMainColV.reloadData()
                    
                    
                }
                let dataweather = WeatherModel.init(cod: data!["cod"].intValue, message: data!["message"].floatValue, cnt: data!["cnt"].intValue, list: self.listmodel, city: self.citymodel!)
                self.weathrModel.append(dataweather)
            }
        }) { (locationerror, CCl) -> (Void) in
            print("locationerror = \(locationerror)")
        }
        
        
        
        
        
        Locator.events.removeAll()
        WeatherMainColV.delegate = self
        WeatherMainColV.dataSource = self
        WeatherCastDailyColV.delegate = self
        WeatherCastDailyColV.dataSource = self
        
        
        WeatherMainColV.register(UINib.init(nibName: "WeatherMainCell", bundle: nil), forCellWithReuseIdentifier: "weatherCell")
        
        
        WeatherCastDailyColV.register(UINib.init(nibName: "WeatherCastCell", bundle: nil), forCellWithReuseIdentifier: "weatherCast")
        
    }
    
    @IBOutlet weak var WeatherMainColV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.NetworkErrorImg.image = UIImage.gif(name: "networkError")
        if Reachability.isConnectedToNetwork() {
            self.NetworkConnectionErrorView.isHidden = true
            loadData()
        }else {
            self.NetworkConnectionErrorView.isHidden = false
            
        
        
       }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.WeatherMainColV {
            let cellWeather = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherMainViewColV
            
            cellWeather?.popularRestaurantsBtn.addTarget(self, action: #selector(loadpopularResturant), for: .touchUpInside)
            
            cellWeather?.countryName.text = self.weathrModel[0].city?.country
            print("Weather Count = \(self.weathrModel[0].city?.country)")
            cellWeather?.weatherStatus.text = self.weathrModel[0].list[indexPath.row].weather[indexPath.row].description
            let celsiusTemp = (self.listmodel[indexPath.row].main?.temp)! - (273.15)
            cellWeather?.weatherMeter.text = String(format: "%.0f", celsiusTemp.rounded())
            let date = self.listmodel[indexPath.row].dt_txt
            
            cellWeather?.dayName.text = self.Api.dateconverttoday(date: date)
            
            let humidity = self.listmodel[indexPath.row].main?.humidity
            cellWeather?.humidityValue.text = String(format: "%.0f", humidity! ) + "%"
            let wind = self.listmodel[indexPath.row].wind?.speed
            
            cellWeather?.windValue.text = String(format: "%.0f", wind! ) + " Kmh"
            
            let precipitationValue = self.listmodel[indexPath.row].rain?.threeh
            if precipitationValue == nil {
                cellWeather?.precipitationValue.text = String(format: "%.0f", 0 ) + "%"
                
            }else {
                cellWeather?.precipitationValue.text = String(format: "%.0f", precipitationValue! * 100 ) + "%"
            }
            
          cellWeather?.weatherImg.image = UIImage(named: self.listmodel[indexPath.row].weather[indexPath.row].icon + ".png")
            
         
            return cellWeather!
        }else {
            let cellWeatherCast = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCast", for: indexPath) as? WeatherDailyCastView
            let date = self.listmodel[indexPath.row].dt_txt
            
            cellWeatherCast?.weatherDay.text = Api.dateconverttoday(date: date)
            
            let weathertime =  Api.dateconvertdatetime(date: date)
 
            cellWeatherCast?.weatherTime.text = weathertime
            
            print("Icon img =\(self.listmodel[indexPath.row].weather[indexPath.row].icon)")
            let celsiusTemp = (self.listmodel[indexPath.row].main?.temp)! - (273.15)
            cellWeatherCast?.weatherDailyCastValue.text = String(format: "%.0f", celsiusTemp.rounded()) + "ºC"
            cellWeatherCast?.weatherDailyCastImg.image = UIImage(named: self.listmodel[indexPath.row].weather[indexPath.row].icon + ".png")
            return cellWeatherCast!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == WeatherCastDailyColV {
            self.WeatherMainColV.selectItem(at: indexPath, animated: false, scrollPosition: .right)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

