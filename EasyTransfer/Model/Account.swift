//
//  Account.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit

class Account: NSObject {
    
    var bankCode:Int!
    var name:String!
    var accountNumber:String!
    var balance:Int!
    
    init(bankCode:Int, name:String, accountNumber:String, balance:Int) {
        super.init();
        self.bankCode = bankCode;
        self.name = name;
        self.accountNumber = accountNumber;
        self.balance = balance;
    }
}


let panTSAccount = Account(bankCode: 812, name: "Pan的台新", accountNumber: "28881001694201", balance: 100000);

let panHNAccount = Account(bankCode: 807, name: "Pan的華南", accountNumber: "16801800750909", balance: 300000);

let panUFAccount = Account(bankCode: 8, name: "Pan的永豐", accountNumber: "187200609171", balance: 400000);
