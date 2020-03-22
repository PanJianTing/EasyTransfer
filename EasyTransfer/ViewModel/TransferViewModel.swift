//
//  TransferViewModel.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit

class TransferViewModel: NSObject {
    
    var price:Int! = 0
    var detailStr:String?
    var fromAccount:AccountViewModel!
    var toAccount:AccountViewModel!
    
//    public func setFromAccount(account:AccountViewModel){
//        self.fromAccount = account;
//    }
//
//    public func setToAccount(account:AccountViewModel){
//        self.toAccount = account;
//    }
//
//    public func setPriceAndDetail(price:Int, detail:String){
//        self.price = price;
//        self.detailStr = detail;
//    }
    
    public func showToAccountStr() -> String {
        return "轉帳給 \(toAccount.showName)";
    }
    
    public func handleTransfer() -> String{
        
        if fromAccount!.getAccount().balance < price{
            return "\(fromAccount.showName)帳戶餘額不足"
        }
        fromAccount?.getAccount().balance = fromAccount.getAccount().balance - price;
        toAccount?.getAccount().balance = toAccount.getAccount().balance + price;
        
        let coreData = (UIApplication.shared.delegate as! AppDelegate).coreData;
        
        print("Update From Account : \(coreData.updateAccountBalance(updateAccount: self.fromAccount))");
        print("Update To Account : \(coreData.updateAccountBalance(updateAccount: self.toAccount))");
        print("Insert Transfer : \(coreData.insertTranfer(transferViewModel: self))");
        return "";
    }
    
    public func showTransferDetail() -> String{
        let format = NumberFormatter();
        format.numberStyle = .decimal;
        return "從 \(fromAccount.showName) 轉出\(format.string(from: NSNumber(value: price)) ?? "")元 到 \(toAccount.showName)";
    }
}

//var transferViewModels:[TransferViewModel] = [];
