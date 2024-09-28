//
//  ChatViewController.swift
//  Chat App
//
//  Created by Apple on 28/09/24.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController {
    
    var viewModel: ChatViewModel?
    var messages: [MessageType] = []
    var currentSenderInfo: SenderType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ChatViewModel(networkingService: NetworkingService())
        
        currentSenderInfo = Sender(senderId: "1", displayName: "You")
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageInputBar.delegate = self
        
        fetchMessages()
    }
    
    func fetchMessages() {
        viewModel?.fetchMessages {
            self.messages = self.viewModel?.messages.map { message in
                return ChatMessage(sender: Sender(senderId: "\(message.userId)", displayName: "User \(message.userId)"),
                               messageId: "\(message.id)",
                               sentDate: Date(),
                               kind: .text(message.body))
            } ?? []
            
            DispatchQueue.main.async {
                self.messagesCollectionView.reloadData()
            }
        }
    }
}

// MARK: - MessageKit DataSource
extension ChatViewController: MessagesDataSource {
    
    func currentSender() -> SenderType {
        return currentSenderInfo
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
}

// MARK: - MessageKit Layout and Display Delegates
extension ChatViewController: MessagesLayoutDelegate, MessagesDisplayDelegate {
}

// MARK: - Message Input Bar Delegate
extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = ChatMessage(sender: currentSender(), messageId: UUID().uuidString, sentDate: Date(), kind: .text(text))
        
        messages.append(message)
        
        messagesCollectionView.insertSections([messages.count - 1])
        
        inputBar.inputTextView.text = ""
    }
}
