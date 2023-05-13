//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by mustafa ölmezses on 13.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var jryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getButtonClicked(_ sender: Any) {
        
        // 1.Request & Session
               // 2.Response & Data
               // 3.Parsing & JSON Serialization
               
               
               let url = URL(string: "https://api.apilayer.com/fixer/latest?base=EUR&apikey=x4nzL4Qpk67NT6amOuicQVg0KiTycX4U")
               
               let session = URLSession.shared
               
               let task = session.dataTask(with: url!) { data, response, error in
                   
                   if error != nil {
                       
                       let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                       let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                       alert.addAction(okButton)
                       self.present(alert, animated: true)
                       
                   }else{
                       
                       if data != nil{
                           
                           do{
                               let jsonResponse = try JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String , Any>
                               
                               //ARKA PLANDA ÇAKIŞMAMASI İÇİN  -> ASYNC
                               
                               DispatchQueue.main.async {
                                    
                                   if let rates = jsonResponse["rates"] as? [String : Any]{
                                       
                                       if let turkish = rates["TRY"] as? Double{
                                           
                                           self.eurLabel.text = String("TRY : \(turkish)")
                                           
                                       }
                                       
                                       if let usd = rates["USD"] as? Double{
                                           
                                           self.usdLabel.text = String("USD : \(usd)")
                                           
                                       }
                                       
                                       
                                       if let jpy = rates["JPY"] as? Double{
                                           
                                           self.jryLabel.text = String("JPY : \(jpy)")
                                           
                                       }
                                       
                                   }
                               }
                               
                           }catch{
                               print("ERROR : JSON Response")
                           }
                           
                          
                           
                       }
                       
                       
                   }
                       
                   
               }
               
               task.resume()
               
           }

        
        
    }
    



