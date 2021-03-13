//
//  HFPurcheSuccessController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/16.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFPurcheSuccessController: HFNewBaseViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var congratulationslabel: UILabel!
    
    @IBOutlet weak var bottomBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "购买结果"

    }
    
    @IBAction func lookMyIntecket(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
}
