//
//  HFMemberPurchseTipController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/15.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFMemberPurchseTipController: HFNewBaseViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var desTextView: UITextView!
    var closure: OptionClosure? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
    }
    
    @IBAction func open(_ sender: UIButton) {

        self.dismiss(animated: false, completion: {})
        
        if self.closure != nil {
            self.closure!()
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
