//
//  HFScheduleController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/14.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFScheduleController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
//    var curIndexPath: NSIndexPath! = nil
//    var curIndex: Int?
    @IBOutlet weak var noContentImg: UIImageView!
    var schdu:HFSchedulModel?
    var datas:NSMutableArray! = nil
    var alerts: Set! = Set<Int>()
    
    //课表实例
    var schduleClass : SchduleClass?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        requestSchduleData()
    }
    
    
    func config() {
        self.datas = NSMutableArray.init()
        self.bgView.layer.contents = UIImage.init(named: "schdule_bg_big")?.cgImage
        self.monthBtn.backgroundColor = .init(white: 0, alpha: 0.3)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 140, height: self.view.frame.size.height-60)
        layout.scrollDirection = .horizontal
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        self.collectionView.register(UINib.init(nibName: "HFScheduleScrollCell", bundle: .main), forCellWithReuseIdentifier: "HFScheduleScrollCell")
    }
    
    
    func requestSchduleData() {
                
        var parameters = [String:Any]()
        
        //宝宝id
        parameters["id"] = HFTools_Swift.babyId
        Service.request(withUrl: GetScheduleTimeLineAPI, params: parameters, method: .GET, success: { (responseObject: Any?) in
            let dataDic = responseObject as! [String:Any]
            self.schduleClass = SchduleClass(JSON: dataDic)
        
            if self.schduleClass?.model != nil{
                self.noContentImg.isHidden = ((self.schduleClass?.model!.count)! > 0) ? true : false
            }else{
                self.noContentImg.isHidden = false
            }
            self.collectionView.reloadData()
        }) { (error: HFError?) in
             MBProgressHUD.showMessage( error?.errorMessage)
            self.collectionView.reloadData()
        }
        
    }
    
//    func checkIndexOfItem() -> Void {
//
//        let indexpath = self.collectionView.indexPathForLastItem
//        let data = self.schduleClass?.model?[indexpath!.row]
//        let date = data?.studyDate!.components(separatedBy: "-")
//        if (Int(date![1]) != nil) {
//            let month = Int(date![1])
//            let monthStr  = "\(String(describing: month))月"
//            self.monthBtn.setTitle(monthStr, for: .normal)
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return self.schduleClass?.model?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HFScheduleScrollCell", for: indexPath) as! HFScheduleScrollCell
        let data = self.schduleClass?.model?[indexPath.row]
        cell.updateMsg(indexPath: indexPath as NSIndexPath, data: data!)
        if self.alerts.contains(indexPath.row) {
            cell.showTip(show: true)
        }else{
            cell.showTip(show: false)
        }
//        self.checkIndexOfItem()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let headerV = collectionView .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerIdentifier", for: indexPath)
            headerV.backgroundColor = .red
            return headerV
        }else if kind == UICollectionView.elementKindSectionFooter{
            let footerV = collectionView .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footIdentifier", for: indexPath)
            footerV.backgroundColor = .yellow
            return footerV
        }
        return UICollectionReusableView.init()
    }
    
    //    MARK: - item 点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        ///这个是暂时注释掉的代码
//        if self.alerts.contains(indexPath.row){
//            self.alerts.remove(indexPath.row)
//        }else{
//            self.alerts.insert(indexPath.row)
//        }
//        self.collectionView .reloadData()
        
    }
    
    @IBAction func backClick(_ sender: Any) {
        self .dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeMonthClick(_ sender: Any) {
        
    }
    
    @IBAction func changeTableClick(_ sender: Any) {
        self .dismiss(animated: true, completion: nil)
    }
    
}
