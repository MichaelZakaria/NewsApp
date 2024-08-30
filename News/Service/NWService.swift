//
//  GetDataController.swift
//  News
//
//  Created by Marco on 2024-08-01.
//

import Foundation

protocol NWSeviceProtocol {
    func getData(handler: (@escaping ([News]) -> Void))
}

class NWSevice : NWSeviceProtocol {
    func getData(handler: (@escaping ([News]) -> Void)) {
        // 1
        let url = URL(string: "https://raw.githubusercontent.com/DevTides/NewsApi/master/news.json")
        
        // 2
        let request = URLRequest(url: url!)
        
        // 3
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // 4
        let task = session.dataTask(with: request) { data, response, error in
            
            // 6
            guard response is HTTPURLResponse else {
                let allNews: [News] = []
                handler(allNews)
                return
            }
            do {
                let news = try JSONDecoder().decode([News].self, from: data!)
                handler(news)
            } catch {
                print("Error")
            }
            
        }
        
        // 5
        task.resume()
    }
}
