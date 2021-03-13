//
//  HFTableView.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/9/23.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation

extension UITableView {
    
    ///结束刷新
    func endRefrash() -> Void {
        
        self.mj_header?.endRefreshing()
        self.mj_footer?.endRefreshing()

    }
    
    
    
    
    
    
}
