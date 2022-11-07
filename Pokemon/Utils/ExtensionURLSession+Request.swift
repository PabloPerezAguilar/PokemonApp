//
//  ExtensionURLSession+Request.swift
//  Pokemon
//
//  Created by Consultant on 6/17/22.
//

import Foundation

extension URLSession{
    
    func getRequest(components: URLComponents?, completion: @escaping(Result<[String: Any], Error>) -> ()){
        
//        var newComponents = components
//        newComponents?.queryItems?.append(contentsOf: [
//            URLQueryItem(name: "offset", value: "\(offset)"),
//            URLQueryItem(name: "limit", value: "30")
//        ])
        
        guard let url = components?.url else {
                completion(.failure(RequestError.invalidUrl))
                return
        }
        let urlRequest = URLRequest(url: url, timeoutInterval: 10)
        URLSession.shared.dataTask(with: urlRequest){ data, response, error in
            if let error = error {
                completion(.failure(RequestError.failed(error: error)))
            }
            
            guard data != nil else{
                completion(.failure(RequestError.unknownError))
                return
            }
            
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: [])
                let parsedData = jsonResult as! [String: Any]
//                print(parsedData)
//                let jsonResult = try JSONDecoder().decode(decoding, from: data!)
                completion(.success(parsedData))
            }catch{
                completion(.failure(RequestError.errorDecode))
            }
        }.resume()
    }
}
