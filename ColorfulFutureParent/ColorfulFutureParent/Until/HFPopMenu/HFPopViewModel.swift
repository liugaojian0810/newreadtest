//
//  HFPopViewModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/11.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFPopViewModel: NSObject {
    var title: String?
    var imageName: String?
    
    public init?(title: String) {
        super.init()
        
        self.title = title
    }
    
    public init?(title: String, imageName: String) {
        super.init()
        
        self.title = title
        self.imageName = imageName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
