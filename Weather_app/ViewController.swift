//
//  ViewController.swift
//  Weather_app
//
//  Created by Macbook on 8/30/20.
//  Copyright © 2020 MacOthmane. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {
    var lg : String="fr"
    var mkey = "0ebedf2dc33f33ac38341d1afab45846"
    @IBOutlet weak var photo: UIImageView!
    
    
    @IBOutlet weak var mondesc: UILabel!
    
    @IBOutlet weak var recherche: UISearchBar!
    
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var temp: UILabel!
    
    @IBOutlet weak var minmax: UILabel!
    @IBOutlet var myview: UIView!
    let gl = CAGradientLayer()
    var mydate : String = ""
    let c1 = UIColor(red: 46/255, green: 0/255, blue: 252/255, alpha: 1.0)
    let c2 = UIColor(red: 41/255, green: 0/255, blue: 209/255, alpha: 1.0)
    let c3 = UIColor(red: 0/255, green: 44/255, blue: 122/255, alpha: 1.0)
    let c4 = UIColor(red: 0/255, green: 62/255, blue: 150/255, alpha: 1.0)
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        gl.frame = self.view.bounds

        self.view.layer.insertSublayer(gl, at: 0)
        
        let ville :String = recherche.text ?? ""
        let villef = ville.replacingOccurrences(of: " ", with: "%20")
        recherche.text=""
        let urls = "https://api.openweathermap.org/data/2.5/weather?q=\(villef)&appid=\(self.mkey)&units=metric&lang=\(self.lg)"
   
        let urlW = URL(string: urls)
    _ = URLSession.shared.dataTask(with: urlW!) { (data, response, err) in
        if err != nil {
            print(err?.localizedDescription as Any)
        }
        if let d = data {
            do {
                let req = try JSONDecoder().decode(Meteo.self, from: d) 
                DispatchQueue.main.async {
        
                        self.temp.text = "\(Int(req.main.temp))°C"
                    self.city.text = req.name + " - " + self.mydate
                    self.mondesc.text = req.weather[0].description
                    self.photo.image = UIImage(named: req.weather[0].icon)
                    self.minmax.text = "Maximum : " + "\(Int(req.main.temp_max))" + "°C   Minimum : " + "\(Int(req.main.temp_min))" + "°C"
                    if(req.weather[0].icon.suffix(1).elementsEqual("d")){
                        self.gl.removeFromSuperlayer()
                        self.gl.colors = [self.c1.cgColor, self.c2.cgColor]
                        self.recherche.barTintColor = self.c1
                        self.view.layer.insertSublayer(self.gl, at: 0)

                    }
                    else if(req.weather[0].icon.suffix(1).elementsEqual("n")){
                       
                        self.gl.removeFromSuperlayer()
                        self.gl.colors = [self.c3.cgColor, self.c4.cgColor]
                        self.recherche.barTintColor = self.c3
                        self.view.layer.insertSublayer(self.gl, at: 0)

                        
                    }
                    
                    
                }
            }catch {
                DispatchQueue.main.async {
                    self.temp.text = "-- °C"
                    self.city.text = "Ville introuvable"
                    self.mondesc.text = ""
                    self.minmax.text = ""
                    self.photo.image = UIImage(named: "404")
                        }
               
                print(error.localizedDescription)
            }
        }
    }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recherche.delegate = self
        gl.frame = self.view.bounds

        self.gl.colors = [self.c3.cgColor, self.c4.cgColor]
        self.recherche.barTintColor = self.c3
        self.view.layer.insertSublayer(self.gl, at: 0)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "fr_FR") as Locale
        formatter.dateFormat = "EEEE dd"
        mydate = formatter.string(from: date)

    }
}

