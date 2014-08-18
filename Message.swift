//
//  Message.swift
//  ChatLogsDemo
//
//  Created by Josh Chung on 8/15/14.
//  Copyright (c) 2014 Josh Chung. All rights reserved.
//

import Foundation

let message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quid attinet de rebus tam apertis plura requirere? Virtutis, magnitudinis animi, patientiae, fortitudinis fomentis dolor mitigari solet. Deinde disputat, quod cuiusque generis animantium statui deceat extremum. Consequentia exquirere, quoad sit id, quod volumus, effectum."

enum MessageType {
    case SentMessage, ReceivedMessage
}

class Message {
    var senderName: String
    var message: String
    var updatedAt: NSDate
    var type: MessageType
    
    init(senderName: String, message: String, updatedAt: NSDate, type: MessageType) {
        self.senderName = senderName
        self.message = message
        self.updatedAt = updatedAt
        self.type = type
    }
}

func createRandomMessage() -> Message {
    let type: MessageType = Int(arc4random() % 2) == 0 ? .ReceivedMessage : .SentMessage;
    let length = Int(arc4random()) % countElements(message)
    return Message(senderName: "sender",
        message: message.substringToIndex(advance(message.startIndex, length)),
        updatedAt: NSDate(),
        type: type)
}