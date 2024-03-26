//
//  FirestoreHelper.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-22.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirestoreHelper {
    
    static let shared :FirestoreHelper = {
        let instant = FirestoreHelper()
        return instant
    }()
    
    var isChatClosed: ((_ isClosed: Bool) -> ())? = nil
    var chatListener: ListenerRegistration?
    let firestorePath = Firestore.firestore().collection("stores").document(Constants.shared.currentLoggedInFireStoreUser?.id ?? "").collection("orders")
    
    public func setRecievedMessagesCount(_ orderNo: String, count: Int) {
        UserDefaults.standard.set(count, forKey: "ORDER_CHAT_MESSAGE_COUNT_\(orderNo)")
    }
    
    public func getRecievedMessagesCount(_ orderNo: String) -> Int {
        return UserDefaults.standard.integer(forKey: "ORDER_CHAT_MESSAGE_COUNT_\(orderNo)")
    }
    
    public func removeRecievedMessagesCount(_ orderNo: String) {
        UserDefaults.standard.removeObject(forKey: "ORDER_CHAT_MESSAGE_COUNT_\(orderNo)")
    }
    
    func sendMessage(orderId: String, _ message: String, customerName: String, customerId: String, customerImage: String) {
        
        guard orderId.isEmpty == false else { return }
        let chatPath = firestorePath.document("\(orderId)").collection("chat").document("order_chat")
        
        let newMessage: [String: Any?] = [
            "pharmacyId": Constants.shared.currentLoggedInFireStoreUser?.id,
            "message": "\(message)",
            "sender": [
                "name": "\(customerName)",
                "phoneNumber": "\(customerId)",
                "imageUrl": "\(customerImage)"
            ],
            "receiver": [
                "name": Constants.shared.currentLoggedInFireStoreUser?.fName,
                "phoneNumber": Constants.shared.currentLoggedInFireStoreUser?.phone,
                "imageUrl": Constants.shared.currentLoggedInFireStoreUser?.avatarUrl
            ],
            "status": "Recived",
            "timestamp": utcDateFormater.string(from: Date())
        ]
        
        chatPath
            .updateData(["message": FieldValue.arrayUnion([newMessage])])
    }
    
    func getOrderChatData(orderNo: String, CustomerId: String, customerName: String, customerImage: String, _ complition: @escaping (_ messageData: [MessageFireData],_ isClosed: Bool) -> ()) {
        guard orderNo.isEmpty == false else { return }
        let chatPath = firestorePath.document("\(orderNo)").collection("chat").document("order_chat")
        self.checkChatExistForUser(orderNo: orderNo) { [weak self] (isChatExist) in
            guard let _ = self else { return }
            if isChatExist == true {
                FirestoreHelper.shared.chatListener?.remove()
                FirestoreHelper.shared.chatListener = chatPath
                    .addSnapshotListener { documentSnap, error in
                        guard let document = documentSnap, let data = document.data() else {
                            return
                        }
                        
                        var messages: [MessageFireData] = []
                        
                        guard let msgs = data["message"] as? [Any] else {
                            return
                        }
                        
                        for msg in msgs {
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: msg, options: .prettyPrinted)
                                let firestoreChatModel: MessageFireData = try JSONDecoder().decode(MessageFireData.self, from: jsonData)
                                let _driverId = Constants.shared.currentLoggedInFireStoreUser?.phone

                                messages.append(firestoreChatModel)
                            } catch {
                                print(error)
                            }
                        }
                        
//                        self?.updateMessagesSeen(data, orderNo: orderNo)
                                           
                        let senderId = Constants.shared.currentLoggedInFireStoreUser?.id
                        let reciveMessge = FirestoreHelper.shared.getRecievedMessagesCount(orderNo)
//                        if let _lastMessage = messages.last, _lastMessage.sender?.senderId != senderId {
//                            if reciveMessge < messages.count {
//                                FirestoreHelper.shared.setRecievedMessagesCount(orderNo, count: messages.count)
//                                guard let isRecieved = self?.isNewMessageRecieved, let _lastMessage = messages.last else { return }
//                                
//                                isRecieved(CustomerId, _lastMessage, orderNo)
////                                HapticFeedbackManager.generate(.medium)
//                            }
//                        }
                        
                        //                        self?.updateLastMessage(orderNo: orderNo, messages.last)
                        
//                        let isChatClosed = (data["status"] as! String) == "close"
//                        self!.isChatClosed?(isChatClosed)
//                        if isChatClosed {
//                            FirestoreHelper.shared.removeRecievedMessagesCount(orderNo)
//                            FirestoreHelper.shared.chatListener?.remove()
//                        }
                        complition(messages, false)
                    }
            } else {
//                self?.createNewChat(orderId: orderNo, customerName: customerName, customerId: CustomerId, customerImage: customerImage)
                self?.getOrderChatData(orderNo: orderNo, CustomerId: CustomerId, customerName: customerName, customerImage: customerImage, { messageData, isClosed in
                    complition(messageData, isClosed)
                })
            }
        }
    }

    
    private func checkChatExistForUser(orderNo: String, _ complition: @escaping (_ isChatExist: Bool) -> ()) {
        guard orderNo.isEmpty == false else { return }
        let chatPath = firestorePath.document("\(orderNo)").collection("chat").document("order_chat")
        
        chatPath.getDocument { docSnap, err in
            if let _ = docSnap?.data() {
                complition(true)
            } else {
                complition(false)
            }
        }
    }
    
    var utcDateFormater: DateFormatter {
        get {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            formatter.timeZone = TimeZone(identifier: "UTC")
            return formatter
        }
    }
}
