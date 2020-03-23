//
//  TransferDB+CoreDataProperties.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/23.
//  Copyright © 2020 PanJianTing. All rights reserved.
//
//

import Foundation
import CoreData


extension TransferDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransferDB> {
        return NSFetchRequest<TransferDB>(entityName: "TransferDB")
    }

    @NSManaged public var detail: String?
    @NSManaged public var price: Int64
    @NSManaged public var transactionTime: Date?
    @NSManaged public var fromAccount: AccountDB?
    @NSManaged public var toAccount: AccountDB?

}
