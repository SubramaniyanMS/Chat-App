//
//  Api.swift
//  Chat App
//
//  Created by Apple on 28/09/24.
//

import Alamofire

protocol NetworkingServiceProtocol {
    func fetchMessages(completion: @escaping ([Message]?) -> Void)
}

class NetworkingService: NetworkingServiceProtocol {
    func fetchMessages(completion: @escaping ([Message]?) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        AF.request(url).responseDecodable(of: [Message].self) { response in
            switch response.result {
            case .success(let messages):
                print("####\(messages)######")
                completion(messages)
            case .failure(let error):
                print("Failed to fetch messages: \(error)")
                completion(nil)
            }
        }
    }
}
