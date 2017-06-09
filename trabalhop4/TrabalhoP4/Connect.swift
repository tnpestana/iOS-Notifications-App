//
//  Sync.swift
//  TrabalhoP4
//
//  Created by SP4 on 09/06/17.
//  Copyright © 2017 Tiago Pestana. All rights reserved.
//

import Foundation

class Http {
    
    var resultArray:Array<AnyObject>?
    
    func getData(urlString: String) -> Array<AnyObject>{
        
        let url = URL(string: urlString)
        let data = try? Data(contentsOf: url!)
        resultArray = try? JSONSerialization.jsonObject(
            with: data!,
            options: JSONSerialization.ReadingOptions.mutableContainers) as! Array<AnyObject>
        return resultArray!
        
    }
    
    func postData(urlString: String, postString: String) {
        
        let url = URL(string: urlString)
        var httpRequest = URLRequest(url: url!)
        httpRequest.httpMethod = "POST"
        // tentar entender o que usar como postString
        httpRequest.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: httpRequest)
        task.resume()
        
    }
}
