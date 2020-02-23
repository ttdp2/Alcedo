//
//  HTTP.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

class HTTP {
    
    let session = URLSession.shared
    
    let base: String
    
    init(base: String) {
        self.base = base
    }
    
    func get(_ path: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: base + path) else { return }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
        
            if let data = data {
                completion(.success(data))
            }
        }
        .resume()
    }
    
}
