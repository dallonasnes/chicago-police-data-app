//
//  Pig.swift
//  AngryOinkers
//
//  Created by dev on 9/29/20.
//

import Foundation

class Pig : CustomDebugStringConvertible, Codable {
    var debugDescription: String {
        return "Pig(name: \(self.name), role: \(self.role), cost: \(self.total_payments), complaints: \(self.complaint_count)"
    }
    
    var name: String
    var total_payments: Int32 = 0
    var complaint_count: Int32 = 0
    var role: String
    var imageUrl: String = "https://pbs.twimg.com/profile_images/1308585737483251712/16zo68yy_400x400.jpg"
    var page_url: String
    var confirmedSighting: Bool = false
    var confirmedOingry: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case name, role, page_url, total_payments, complaint_count
    }
    
    init(named name: String, role: String, page_url: String, complaint_count: Int32, total_payments: Int32) {
        self.name = name
        self.role = role
        self.page_url = page_url
        self.complaint_count = complaint_count
        self.total_payments = total_payments
    }
    
}

struct PigResult: Codable {
    var cops = [Pig]()
}
