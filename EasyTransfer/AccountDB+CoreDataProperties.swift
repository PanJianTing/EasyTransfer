//
//  AccountDB+CoreDataProperties.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//
//

import Foundation
import CoreData


extension AccountDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountDB> {
        return NSFetchRequest<AccountDB>(entityName: "AccountDB")
    }

    @NSManaged public var accountNumber: String?
    @NSManaged public var balance: Int64
    @NSManaged public var bankCode: Int16
    @NSManaged public var name: String?

}
