//
//  HFMemberZoneHomeController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/9.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFMemberZoneHomeController: HFNewBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func test1(_ sender: Any) {
        
        let memberPurchase = HFMemberPurchseTipController()
        memberPurchase.modalPresentationStyle = .overFullScreen
        memberPurchase.closure = {
            
            let vc = HFMemberPurchTypeSelecrController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.present(memberPurchase, animated: true, completion: {})
    }

}
