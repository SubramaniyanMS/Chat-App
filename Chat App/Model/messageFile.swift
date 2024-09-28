//
//  messageFile.swift
//  Chat App
//
//  Created by Apple on 27/09/24.
//

import Foundation
import MessageKit

struct Message: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

struct ChatMessage: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}
