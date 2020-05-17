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
    // MARK: POST Request Task
    class func POSTRequest <RequestType: Encodable, ResponseType: Decodable> (url: URL, body: RequestType, responseType: ResponseType.Type, completionHandler: @escaping (ResponseType?, Error?)->Void){
        //encoding request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONEncoder().encode(body)
        }catch{
            //error setting request body, call completion handler with error
            completionHandler(nil, error)
        }
        //getting response and decoding it
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            //make sure data is not nil
            guard let data = data else{
                // no data found call completion handler with error
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            do{
                let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                // response decoded successfully
                completionHandler(responseObject, nil)
            } catch{
                // error decoding response
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
}
