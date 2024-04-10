//
//  NetworkingManager.swift
//  Wishlist
//
//  Created by 김시종 on 4/10/24.
//

import UIKit

class NetworkingManager {
    let productID = Int.random(in: 1 ... 100)
    
    func getMethod(completion: @escaping (Result<RemoteProduct, Error>) -> Void) {
        // URL구조체 만들기
        guard let url = URL(string: "https://dummyjson.com/products/\(productID)") else {
            print("Error: cannot create URL")
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        // URL요청 생성
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러가 없어야 넘어감
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                completion(.failure(NetworkingError.networkError))
                return
            }
            // 옵셔널 바인딩
            guard let safeData = data else {
                print("Error: Did not receive data")
                completion(.failure(NetworkingError.noData))
                return
            }
            // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 300) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                completion(.failure(NetworkingError.invalidResponse))
                return
            }
            
            do {
                let product = try JSONDecoder().decode(RemoteProduct.self, from: safeData)
                completion(.success(product))
            } catch {
                print("Error decoding product data:", error)
                completion(.failure(NetworkingError.decodingError))
            }
        }.resume()
    }
}

enum NetworkingError: Error {
    case invalidURL
    case networkError
    case noData
    case invalidResponse
    case decodingError
}
