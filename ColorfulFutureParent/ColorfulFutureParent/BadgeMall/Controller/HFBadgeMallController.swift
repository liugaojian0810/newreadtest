//
//  HFBadgeMallController.swift
//  ColorfulFutureParent
//
//  Created by 慧凡 on 2020/11/6.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFBadgeMallController: HFNewBaseViewController {

    @IBOutlet weak var badgeMallBalanceView: UIView!
    @IBOutlet weak var segView: UIView!
    
    lazy var seg: HFPubSegmentView = {
        let seg = HFPubSegmentView(frame: CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 44), itemNames: ["推荐","幼儿图书","IP周边"])
        return seg
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() -> Void {
        
        self.title = "徽章商城";
        
        segView.addSubview(seg)
        
        let balanceView = Bundle.main.loadNibNamed("HFBadgeMallBalanceViewCell", owner: self, options: nil)?.last as! HFBadgeMallBalanceViewCell
        badgeMallBalanceView.addSubview(balanceView)
        balanceView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
