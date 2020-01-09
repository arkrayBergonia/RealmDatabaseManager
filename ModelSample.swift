//
//  User.swift
//  EmergencyCall_Swift
//
//  Created by Francis Jemuel Bergonia on 1/8/20.
//  Copyright © 2020 Arkray PHM. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var userID = 0
    @objc dynamic var fullName = ""
    @objc dynamic var institutionName = ""
    @objc dynamic var physicianName = ""
    @objc dynamic var telephoneNumber = ""
    @objc dynamic var treatmentContent = ""
    @objc dynamic var homeAddress = ""
    @objc dynamic var homePhoneNumber = ""
    @objc dynamic var emegencyContact: EmergencyContact?
    @objc dynamic var emailSettings: EmailSettings?
    @objc dynamic var phoneSettings: PhoneSettings?
    var memoSettings = List<MemoSettings>()
    
    var isUserHasSavedMemos: Bool {
        return memoSettings.count > 0
    }
    
    override static func primaryKey() -> String? {
        return "userID"
    }
    
    convenience init(fullName: String, userID: Int) {
        self.init()
        self.fullName = fullName
        self.userID = userID
    }
}


class EmergencyContact: Object {
    @objc dynamic var emergencyTitle = ""
    var emergencyMessage = List<EmergencyContactMessage>()
    
    var isUserHasSavedMessages: Bool {
        return emergencyMessage.count > 0
    }
    
    let ofUser = LinkingObjects(fromType: User.self, property: "emergencyContact")
}

class EmergencyContactMessage: Object {
    @objc dynamic var emergencyMessage = ""
    
    let ofEmergencyContact = LinkingObjects(fromType: EmergencyContact.self, property: "emergencyMessage")
}

class EmailSettings: Object {
    @objc dynamic var subject = ""
    @objc dynamic var message = ""
    var emailAddress = List<EmailAddress>()
    
    var isUserHasSavedMessages: Bool {
        return emailAddress.count > 0
    }
    
    let ofUser = LinkingObjects(fromType: User.self, property: "emailSettings")
    
}

class EmailAddress: Object {
    @objc dynamic var address = ""
    
    let ofEmail = LinkingObjects(fromType: EmailSettings.self, property: "emailAddress")
    
    convenience init(emailAddress: String) {
        self.init()
        self.address = emailAddress
    }
    
}


class PhoneSettings: Object {
    @objc dynamic var destination = ""
    @objc dynamic var phoneNumber = ""
    
    let ofUser = LinkingObjects(fromType: User.self, property: "phoneSettings")
    
}

class MemoSettings: Object {
    @objc dynamic var infoLabel = ""
    @objc dynamic var saveKey = ""
    @objc dynamic var memoText: String? = nil
    @objc dynamic var photoName = ""
    @objc dynamic var photoImg: NSData? = nil
    
    let ofUser = LinkingObjects(fromType: User.self, property: "memoSettings")
}



