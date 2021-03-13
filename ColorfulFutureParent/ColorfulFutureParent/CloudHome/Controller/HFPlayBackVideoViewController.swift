//
//  HFPlayBackVideoViewController.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/17.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFPlayBackVideoViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nullImageView: UIImageView!
    var backModel: HUIClassPlayBackModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib.init(nibName: "HFPlayBackVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "playBackVideoCell")
        self.collectionView.register(UINib.init(nibName: "HFPlayBackViewCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        self.requestDataSource()
    }
    
    func requestDataSource() -> Void {
        Service.post(withUrl: GetCoursePlaybackAPI, params: ["id":HFUserManager.shared().getUserInfo().babyInfo.babyID
            ], success: { (responseObject: Any?) in
                let dic = NSDictionary(dictionary:responseObject! as! [NSObject : AnyObject])
                self.backModel = try? HUIClassPlayBackModel.fromJSON(dic.mj_JSONString(), encoding: 4)
                if (self.backModel?.model.count)! > 0 {
                    self.collectionView.reloadData()
                } else {
                    self.reloadNullView(status: 1)
                }
                
        }) { (error: HFError?) in
            self.reloadNullView(status: 0)
             MBProgressHUD.showMessage( error?.errorMessage)
        }
    }
    
    func reloadNullView(status: NSInteger) -> () {
        self.nullImageView.isHidden = false
        self.nullImageView.image = status > 0 ? UIImage.init(named: "zanwuhuifang") : UIImage.init(named: "interactiveCamp_nullData_icon")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.backModel?.model.count ?? 0
      }
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionModel: HUIModel = (self.backModel?.model[section])!
        return sectionModel.lists.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playBackVideoCell", for: indexPath) as! HFPlayBackVideoCollectionViewCell
        cell.rowModel = self.backModel?.model[indexPath.section].lists[indexPath.row]
          return cell
      }
      
      func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          if kind == UICollectionView.elementKindSectionHeader {
              // 1.取出HeaderView
              let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HFPlayBackViewCollectionReusableView
            let section: HUIModel = (self.backModel?.model[indexPath.section])!
            headerView.sectionModel = section
              return headerView
          }else{
            return UIView.init() as! UICollectionReusableView
          }
      }
      
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 84, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //上、左、下、右距四边的间距
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 205)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ShowHUD.showHUDLoading()
        Service.post(withUrl: PlayVideoAPI, params: ["babyId": HFUserManager.getUserInfo().babyInfo.babyID, "videoId": self.backModel?.model[indexPath.section].lists[indexPath.row].courseURL], success: { (responseObject: Any?) in
            ShowHUD.hiddenHUDLoading()
            let dic:NSDictionary = NSDictionary.init(dictionary: responseObject as! [NSObject: AnyObject])
            let model:HFClassVideoURLModel = try! HFClassVideoURLModel.fromJSON(dic["model"] as! String, encoding: 4)
            let video = HFVideoController.init()
            video.url = model.data.videoURL.last!.originURL
            video.courseId = "\(self.backModel!.model[indexPath.section].lists[indexPath.row].identifier)"
            video.hiddenBottomBar = false
            video.titleText = self.backModel!.model[indexPath.section].lists[indexPath.row].courseName

            let list = self.backModel!.model[indexPath.section].lists[indexPath.row]
            video.weekDetailId = "\(list.weekDetailId)"
            self.present(video, animated: false, completion: nil)
            
        }) { (error: HFError?) in
            ShowHUD.hiddenHUDLoading()
             MBProgressHUD.showMessage( error?.errorMessage)
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
