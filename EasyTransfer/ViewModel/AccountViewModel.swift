//
//  AccountViewModel.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit


class AccountViewModel: NSObject {
    
    private let account:Account!;
    
    init(account:Account) {
        self.account = account;
    }
    
    public var showName:String {
        return self.account.name;
    }
    
    public var showAccountStr:String {
        return "(\(String(format: "%03i", self.account.bankCode!))) \(self.account.accountNumber!)";
    }
    
    public var showBalance:String{
        let format = NumberFormatter();
        format.numberStyle = .decimal
        return "\(format.string(from: NSNumber(value: self.account.balance)) ?? "")"
    }
    
    public func getAccount() -> Account{
        return account;
    }
    
    public func getCanTransferAccount(accountViewModels:[AccountViewModel]) -> [AccountViewModel]{
        var otherAccountViewModels:[AccountViewModel] = [];
        for accountViewModel in accountViewModels {
            if accountViewModel != self {
                otherAccountViewModels.append(accountViewModel);
            }
        }
        return otherAccountViewModels;
    }
    
}

//var accountViewModels:[AccountViewModel] = [
//    AccountViewModel(account: panTSAccount),
//    AccountViewModel(account: panHNAccount),
//    AccountViewModel(account: panUFAccount)
//]

//var canTransferAccountModels:[AccountViewModel] = [];
