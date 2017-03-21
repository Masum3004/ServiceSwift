//
//  ViewController.swift
//  ConsumeWebservice
//
//  Created by webmyne on 06/02/17.
//  Copyright © 2017 Webmyne. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


   
    @IBAction func btnGETcalling(_ sender: Any) {
       
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://ws-srv-net.in.webmyne.com/Applications/KidsCrown_V03/WCF/Services/Home.svc/json/GetPageDetails")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        
                        //Implement your logic
                        print(json)
                        
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
            
        })
        task.resume()
       
    }
   
    @IBAction func btnPOSTcalling(_ sender: Any) {
        
        let todosEndpoint: String = "http://demo.webmynehost.com/amgsale_live/services/login_post.php?format=json"
        guard let todosURL = URL(string: todosEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var todosUrlRequest = URLRequest(url: todosURL)
        todosUrlRequest.httpMethod = "POST"
    
        let newTodo: [String: Any] = ["username": "RM_guj_001" , "password": "12345678", "type": 1, "token" : "1234567890", "islogin" : true]
    
    let jsonTodo: Data
   
    do {
    
        jsonTodo = try JSONSerialization.data(withJSONObject: newTodo, options: [])
    
        todosUrlRequest.httpBody = jsonTodo
      
        print(jsonTodo)
        
    } catch {
    
        print("Error: cannot create JSON from todo")
        return
    }
        let session = URLSession.shared
        
        let task = session.dataTask(with: todosUrlRequest) {
            (data, response, error) in
           guard error == nil else {
            
            print("error calling POST on /todos/1")
                print(error ?? "Errors >")
                return
            }
            guard let responseData = data else {
              
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData,
                                                                          options: []) as? [String: Any] else {
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                print("The todo is: " + receivedTodo.description)
                
                let responseDict = (receivedTodo["Response"] as? [String : Any])!
                
                print("Here  is Array \(responseDict)")

                let responseArr = (responseDict["ResponseCode"] as? [String : Any])!
                
                print("Here  is Dict \(responseArr)")
               
                guard let todoID = receivedTodo["id"] as? Int else {
                   
                    print("Could not get todoID as int from JSON")
                    return
                }
                
                print("The ID is: \(todoID)")
            
            } catch  {
              
                print("error parsing response from POST on /todos")
                return
            }
        }
        task.resume()
    }/*{
     "username": "username",
     "password": "Remark rrrrrrm",
     "type": "AND",
     "token": "C",
     "islogin": true
     }

     */
}

