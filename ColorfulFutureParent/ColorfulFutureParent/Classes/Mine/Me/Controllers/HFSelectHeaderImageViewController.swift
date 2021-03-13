//
//  HFSelectHeaderImageViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by wzz on 2020/10/19.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFSelectHeaderImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imgView: UIImageView!
    var takingPicture: UIImagePickerController!
    var img: UIImage?
    
    typealias SelectImageClosure = (_ img: UIImage) -> ()
    @objc var selectClosure: SelectImageClosure?

    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    ///拍照
    @IBAction func takingPictures(_ sender: UIButton) {
        
        getImageGo(type: 1)
    }
    
    ///选择照片
    @IBAction func selectPhoto(_ sender: UIButton) {
        
        getImageGo(type: 2)
    }
    
    ///查看大图
    @IBAction func lookBigPicture(_ sender: UIButton) {
        
        self.imgView.isHidden = false
        self.bgView.isHidden = true
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {})
    }
    
    //去拍照或者去相册选择图片
    func getImageGo(type:Int){
        takingPicture =  UIImagePickerController.init()
        takingPicture.allowsEditing = true
        if(type==1){
            takingPicture.sourceType = .camera
            //拍照时是否显示工具栏
            //takingPicture.showsCameraControls = true
        }else if(type==2){
            takingPicture.sourceType = .photoLibrary
        }
        //是否截取，设置为true在获取图片后可以将其截取成正方形
        takingPicture.allowsEditing = true
        takingPicture.delegate = self
        present(takingPicture, animated: true, completion: nil)
    }
    
    //拍照或是相册选择返回的图片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        takingPicture.dismiss(animated: true, completion: nil)
        if(takingPicture.allowsEditing == false){
            //原图
            img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }else{
            //截图
            img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        }
        if self.selectClosure != nil {
            self.selectClosure!(img!)
        }
        self.dismiss(animated: false, completion: {})
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: false, completion: {})
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.dismiss(animated: true, completion: {})
        
    }
}
