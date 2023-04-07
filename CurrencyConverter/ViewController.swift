//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Yusuf Pektaş on 7.04.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cadLbl: UILabel!
    @IBOutlet weak var chfLbl: UILabel!
    @IBOutlet weak var usdLbl: UILabel!
    @IBOutlet weak var jpyLbl: UILabel!
    @IBOutlet weak var tryLbl: UILabel!
    
    let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
    let session = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func requestNewRates() {
        if let url = url {
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("\(String(describing: error?.localizedDescription))")
                } else {
                    if let data = data {
                        do {
                            let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                            DispatchQueue.main.async {
                                guard let rates = response?["rates"] as? [String:Double] else { return }
                                
                                if let cad = rates["CAD"] {
                                    self.cadLbl.text = "CAD: \(String(cad))"
                                }
                                if let chf = rates["CHF"] {
                                    self.chfLbl.text = "CHF: \(String(chf))"
                                }
                                if let jpy = rates["JPY"] {
                                    self.jpyLbl.text = "JPY: \(String(jpy))"
                                }
                                if let usd = rates["USD"] {
                                    self.usdLbl.text = "USD: \(String(usd))"
                                }
                                if let tryCurrrency = rates["TRY"] {
                                    self.tryLbl.text = "TRY: \(String(tryCurrrency))"
                                }
                                
                                
                            }
                        } catch {
                            print("error happened while serialization.")
                        }
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    @IBAction func getRates(_ sender: Any) {
        // 1) Request - Session
        // 2) Response - Data
        // 3) Parsing - Json Serialization
        
        requestNewRates()
    }
}

