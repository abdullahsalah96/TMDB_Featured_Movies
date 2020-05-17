//
//  Client.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation

class Client{
    // MARK: GET Request Task
    class func GETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping (ResponseType?, Error?)->Void){
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            //make sure data is not nil
            guard let data = data else{
                DispatchQueue.main.async{
                    // no data found call completion handler with error
                    completionHandler(nil, error)
                }
                return
            }
            do{
                let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                // decoded response successfully
                DispatchQueue.main.async {
                    completionHandler(responseObject, nil)
                }
            } catch{
                //error decoding response
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
        })
        task.resume()
    }
}
