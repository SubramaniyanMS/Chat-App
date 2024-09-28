//
//  ChatViewModel.swift
//  Chat App
//
//  Created by Apple on 28/09/24.
//

import Foundation

class ChatViewModel {
    var messages: [Message] = []
    var networkingService: NetworkingServiceProtocol
    
    init(networkingService: NetworkingServiceProtocol) {
        self.networkingService = networkingService
    }
    
    func fetchMessages(completion: @escaping () -> Void) {
        networkingService.fetchMessages { [weak self] messages in
            if let messages = messages {
                self?.messages = messages
            }
            completion()
        }
    }
}

