//
//  CoreDataConnect.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit
import CoreData


class CoreDataConnect: NSObject {
    
    var context:NSManagedObjectContext! = nil
    
    init(context:NSManagedObjectContext) {
        self.context = context
    }
    
    func insertAccount(account:Account) -> Bool {
        
        if self.isHaveAccount(account: account) {
            print("已經有此帳戶");
            return false;
        }
        
        
        let accountDB = NSEntityDescription.insertNewObject(forEntityName: "AccountDB", into: self.context) as! AccountDB;
        accountDB.name = account.name;
        accountDB.accountNumber = account.accountNumber;
        accountDB.bankCode = Int16(account.bankCode!);
        accountDB.balance = Int64(account.balance)
        
        do{
            try self.context.save();
        }catch{
            fatalError("Insert Account Fail");
        }
        
        return true;
    }
    
    func getAccounts(queryStr:String?) -> [AccountViewModel] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AccountDB");
        var accountViewModels:[AccountViewModel] = [];
        
        if let predicate = queryStr{
            request.predicate = NSPredicate(format: predicate);
        }
        
        do {
            let fetchResult:[AccountDB]? =  try self.context.fetch(request) as? [AccountDB];
            if let accountDBs = fetchResult{
                for accountDB in accountDBs {
                    
                    let accountViewModel = accountDBToAccountViewModel(accountDB: accountDB);
                    
                    accountViewModels.append(accountViewModel);
                }
            }
            
        } catch {
            fatalError("\(error)")
        }
        
        return accountViewModels;
    }
    
    private func isHaveAccount(account:Account) -> Bool{
        
        let quertStr = "bankCode ==\(account.bankCode!) && accountNumber==\(account.accountNumber!)"
        let result = self.getAccount(queryStr: quertStr);
        
        guard result != nil else {
            return false;
        }
    
        return true;
    }
    
    private func getAccount(queryStr:String?) -> AccountDB?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AccountDB");
        var accountDB:AccountDB?;
        
        if let predicate = queryStr{
            request.predicate = NSPredicate(format: predicate);
        }
        
        do {
            let fetchResult:[AccountDB]? =  try self.context.fetch(request) as? [AccountDB];
            if let accountDBs = fetchResult{
                
                accountDB = accountDBs.first;
            }
            
        } catch {
            fatalError("\(error)")
        }
        
        return accountDB;
    }
    
    func updateAccountBalance(updateAccount:AccountViewModel?) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AccountDB");
        guard let account = updateAccount else {
            return false
        }
        let query = "bankCode ==\(account.getAccount().bankCode!) && accountNumber==\(account.getAccount().accountNumber!)"
        request.predicate = NSPredicate(format: query);

        
        do {
            let fetchResult:[AccountDB]? =  try self.context.fetch(request) as? [AccountDB];
            if let accountDBs = fetchResult{
                for accountDB in accountDBs {
                    accountDB.balance = Int64(account.getAccount().balance)
                }
            }
            try self.context.save();
            
        } catch {
            fatalError("\(error)")
        }
        return true;
    }
    
    
    
    func insertTranfer(transferViewModel:TransferViewModel) -> Bool {
        
        let transferDB = NSEntityDescription.insertNewObject(forEntityName: "TransferDB", into: self.context) as! TransferDB;
        transferDB.price = Int64(transferViewModel.price);
        transferDB.detail = transferViewModel.detailStr;
        transferDB.transactionTime = transferViewModel.transactionTime;
        
        let fromAccountQueryStr = "bankCode ==\(transferViewModel.fromAccount.getAccount().bankCode!) && accountNumber==\(transferViewModel.fromAccount.getAccount().accountNumber!)"
        
        let toAccountQueryStr = "bankCode ==\(transferViewModel.toAccount.getAccount().bankCode!) && accountNumber==\(transferViewModel.toAccount.getAccount().accountNumber!)"
        
        transferDB.fromAccount = self.getAccount(queryStr: fromAccountQueryStr);
        transferDB.toAccount = self.getAccount(queryStr: toAccountQueryStr);
        do{
            try self.context.save();
        }catch{
            fatalError("Insert Account Fail");
        }
        return true;
    }
    
    func getTransfers(queryStr:String?) -> [TransferViewModel] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TransferDB");
        var transferViewModels:[TransferViewModel] = [];
        
        if let predicate = queryStr{
            request.predicate = NSPredicate(format: predicate);
        }
        
        request.sortDescriptors = [NSSortDescriptor(key: "transactionTime", ascending: false)]
        
        do {
            let fetchResult:[TransferDB]? =  try self.context.fetch(request) as? [TransferDB];
            if let transferDBs = fetchResult{
                for transferDB in transferDBs {
                    
                    let transferViewModel = TransferViewModel();
                    transferViewModel.detailStr = transferDB.detail;
                    transferViewModel.price = Int(transferDB.price);
                    transferViewModel.fromAccount = self.accountDBToAccountViewModel(accountDB: transferDB.fromAccount!);
                    transferViewModel.toAccount = self.accountDBToAccountViewModel(accountDB: transferDB.toAccount!);
                    transferViewModel.transactionTime = transferDB.transactionTime;
                    
                    transferViewModels.append(transferViewModel);
                }
            }
            
        } catch {
            fatalError("\(error)")
        }
        
        return transferViewModels;
    }
    
    
    func accountToAccountDB(account:Account, _ db:AccountDB?) -> AccountDB {
        guard let accountDB = db else {
            return AccountDB();
        }
        accountDB.name = account.name;
        accountDB.accountNumber = account.accountNumber;
        accountDB.bankCode = Int16(account.bankCode!);
        accountDB.balance = Int64(account.balance)
        return accountDB;
    }
    
    func accountDBToAccountViewModel(accountDB:AccountDB) -> AccountViewModel {
        
        let account = Account(bankCode: Int(accountDB.bankCode),
                              name: accountDB.name!,
                              accountNumber: accountDB.accountNumber!,
                              balance: Int(accountDB.balance))
        
        
        
        return AccountViewModel(account: account);
    }
    

}
