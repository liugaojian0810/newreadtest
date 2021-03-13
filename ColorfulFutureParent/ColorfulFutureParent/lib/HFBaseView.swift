//
//  HFBaseView.swift
//  ColorfulFutureParent
//
//  Created by huifan on 2020/7/15.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFBaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addMySubViews()
        self.addSnap()
    }
    
    func addMySubViews() -> Void {
        
    }
    
    func addSnap() -> Void {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
