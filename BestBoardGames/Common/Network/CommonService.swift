//
//  CommonService.swift
//  BestBoardGames
//
//  Created by Kate on 14.09.2023.
//

import Foundation
import Alamofire

class CommonService<T: Decodable> {
    
    let urlString: String
    
     init(urlString: String) {
        self.urlString = urlString
    }
    
   private func parseJSON(withData data: Data) -> T? {
            let decoder = JSONDecoder()
            do {
                let t = try decoder.decode(T.self, from: data)
                return t
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            return nil
    }
    
    
    func fetchInformation(with id: String, completion: @escaping (T) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            AF.request(urlString + id).response { response in   //??
                
                if let data = response.data {
                    
                    if let object = self.parseJSON(withData: data) {
                        completion(object)
                    }
                }
            }
        }
    }
}
