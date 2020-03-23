//
//  HistoryTransferViewController + TableviewDelegate.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit

extension HistoryTransferViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true);
        
        guard var detail = self.transferViewModels![indexPath.row].detailStr else {
            return;
        }
        
        if (detail == ""){
            detail = "無交易內容";
        }
        let alert = ViewUtil.setAlertViewController(title: "交易內容", message: detail, confirmStr: "確認", cancelStr: nil);
        self.present(alert, animated: true, completion: nil);
        print(self.transferViewModels![indexPath.row].showTime() ?? "");
    }
}
