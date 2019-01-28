//
//  ViewController.swift
//  LoginPageApiApp
//
//  Created by Priya on 1/16/19.
//  Copyright © 2019 Priya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var actObj: UIActivityIndicatorView!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func getLogin(_ sender: Any) {
        
        actObj.startAnimating()
        let user = txt_username.text
        let pass = txt_password.text
        
        self.login(struser: user!, strpassword: pass!)
        
    }
    
    func login(struser: String , strpassword: String){
        
        
        let api = "http://softgen/login?username=\(struser)&paasword=\(strpassword)"
        
        let url = URL.init(string: api)
        
        var req = URLRequest.init(url: url!)
        
        req.httpMethod = "POST"
        
        let strkey = "softgen"
        
        let dataObj = strkey.data(using: .utf8, allowLossyConversion: true)
        
        req.httpBody = dataObj
        
        let sessionconf = URLSessionConfiguration.default
        
        let sessionobj = URLSession.init(configuration: sessionconf)
        
        let dataTask = sessionobj.dataTask(with: req, completionHandler: {(data,response,error) in
            if data != nil{
                self.jsondata(dataObj: data!)

            }else{
                //alert
            }
        })
        dataTask.resume()
        
    }
    func jsondata(dataObj : Data){
        
        do{
            
            let jsonObj = try JSONSerialization.jsonObject(with: dataObj, options: []) as? NSDictionary
            
            let statusObj = jsonObj?.value(forKey: "status") as? String
            
            if  statusObj == "1" {
                // goto next page logic
            }
            if  statusObj == "2" {
                // alert username and password not register
            }
            if  statusObj == "3" {
                // invalid
            }
            if  statusObj == "-1" {
                // error
            }
            
            
            
        }catch{
            //handling
        }
        
    }


}
// output
//{
    //status:1
//}
