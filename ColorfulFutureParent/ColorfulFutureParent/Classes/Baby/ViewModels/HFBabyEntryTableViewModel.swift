//
//  HFBabyEntryTableViewModel.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/1/11.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation

enum HFEditBabyInfoType: CaseIterable {
    /// 编辑基础信息
    case baseInfo
    /// 编辑、添加家长信息
    case parentInfo
    /// 编辑入园信息
    case intoKindergarten
    /// 编辑健康信息
    case healthInfo
    /// 编辑幼儿园信息
    case kindergarten
    
    func next() -> HFEditBabyInfoType {
        let all = type(of: self).allCases
        if self == all.last! {
            return all.first!
        } else {
            let index = all.firstIndex(of: self)!
            return all[index + 1]
        }
    }
}

class HFEditBabyInfoViewModel: NSObject {
    
    var title: String = "宝宝信息"
    
    var babyModel: HFBabyModel? // 宝宝数据
    var parentModel: HFParentModel? // 家长数据模型
    
    var dataArr: [[HFPersonnelEditCellModel]]? {
        get {
            switch editType {
            case .parentInfo:
                if otherParentInfoDataArr.count == 0 {
                    return [parentInfoDataArr]
                }
                return [parentInfoDataArr] + otherParentInfoDataArr
            case .baseInfo:
                return [baseInfoDataArr]
            case .intoKindergarten:
                return [intoKindergartenDataArr]
            case .healthInfo:
                return [healthInfoDataArr]
            default:
                return nil
            }
        }
    }
    
    var parentInfoArr = [HFBaseParentInfoModel]()
    
    // 亲属信息
    var parentInfoDataArr = [HFPersonnelEditCellModel]()
    // 其他亲属
    var otherParentInfoDataArr: [[HFPersonnelEditCellModel]] = []
    var baseInfoDataArr = [HFPersonnelEditCellModel]()
    var intoKindergartenDataArr = [HFPersonnelEditCellModel]()
    var healthInfoDataArr = [HFPersonnelEditCellModel]()
    
    override init() {
        super.init()
        
        let baaseParentInfoModel = HFBaseParentInfoModel.init()
        parentInfoArr.append(baaseParentInfoModel)
        
        // 家属信息
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "与宝宝关系", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            if self?.relationModel != nil {
                let baaseParentInfoModel = self?.parentInfoArr.first
                baaseParentInfoModel?.cprRelp = self?.relationModel?.dicFieldCode ?? ""
                baaseParentInfoModel?.cprRelpName = self?.relationModel?.dicFieldName ?? ""
            }
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "姓名", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr.first
            baaseParentInfoModel?.baseParentInfoResul.usrFullName = newValue
        }))
        let phoneCellModel = HFPersonnelEditCellModel.init(type: .input, title: "手机号", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr.first
            baaseParentInfoModel?.baseParentInfoResul.usrPhone = newValue
        })
        phoneCellModel.maxLength = 11
        parentInfoDataArr.append(phoneCellModel)
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "国籍", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            if self?.nativePlaceModel != nil {
                let baaseParentInfoModel = self?.parentInfoArr.first
                baaseParentInfoModel?.baseParentInfoResul.piNationality = self?.nationalityModel?.dicFieldCode ?? ""
                baaseParentInfoModel?.baseParentInfoResul.piNationalityName = self?.nationalityModel?.dicFieldName ?? ""
            }
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "出生日期", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr.first
            baaseParentInfoModel?.baseParentInfoResul.usrBirthday = newValue
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .onlyShow, title: "年龄", value: "", placeholder: "未知", serverKey: ""))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "学历", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            if self?.educationModel != nil {
                let baaseParentInfoModel = self?.parentInfoArr.first
                baaseParentInfoModel?.baseParentInfoResul.piEducation = self?.educationModel?.dicFieldCode ?? ""
                baaseParentInfoModel?.baseParentInfoResul.eiEducationTitle = self?.educationModel?.dicFieldName ?? ""
            }
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "职业", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr.first
            baaseParentInfoModel?.baseParentInfoResul.piVocation = newValue
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "籍贯", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            if self?.nativePlaceModel != nil {
                let baaseParentInfoModel = self?.parentInfoArr.first
                baaseParentInfoModel?.baseParentInfoResul.piNativeProvince = self?.nativePlaceModel?.diName ?? ""
                baaseParentInfoModel?.baseParentInfoResul.piNativeProvinceCode = self?.nativePlaceModel?.diId ?? ""
            }
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "工作单位", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr.first
            baaseParentInfoModel?.baseParentInfoResul.piWorkPlace = newValue
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "户籍所在地", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            if self?.censusRegisterAddress.count != 0 {
                let baaseParentInfoModel = self?.parentInfoArr.first
                for (index,model) in self!.censusRegisterAddress.enumerated() {
                    switch index {
                    case 0:
                        baaseParentInfoModel?.baseParentInfoResul.piHrProvince = model.diName // 户籍-省
                        baaseParentInfoModel?.baseParentInfoResul.piHrProvinceCode = model.diId // 户籍-省业务ID
                    case 1:
                        baaseParentInfoModel?.baseParentInfoResul.piHrCity = model.diName // 户籍-市
                        baaseParentInfoModel?.baseParentInfoResul.piHrCityCode = model.diId // 户籍-市业务ID
                    case 2:
                        baaseParentInfoModel?.baseParentInfoResul.piHrCounty = model.diName  // 户籍-县
                        baaseParentInfoModel?.baseParentInfoResul.piHrCountyCode = model.diId // 户籍-县业务ID
                    default:
                        break
                    }
                }
            }
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "户籍详细地址", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr.first
            baaseParentInfoModel?.baseParentInfoResul.piHrAdd = newValue
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "现居详细地址", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr.first
            baaseParentInfoModel?.baseParentInfoResul.piNhomAdd = newValue
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "设为第一联系人", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr.first
            baaseParentInfoModel?.cprDef = Int(newValue) ?? 0
        }))
        
        // 基础信息
        baseInfoDataArr.append(HFPersonnelEditCellModel.init(type: .header, title: "头像", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["headImg"] = newValue as AnyObject
        }))
        baseInfoDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "姓名", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciName"] = newValue as AnyObject
        }))
        baseInfoDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "宝宝小名", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciNickname"] = newValue as AnyObject
        }))
        baseInfoDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "宝宝性别", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciSex"] = newValue as AnyObject
        }))
        baseInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "出生日期", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciBirth"] = newValue as AnyObject
        }))
        baseInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "宝宝国籍", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            if self?.nationalityModel != nil {
                self?.baseChildInfo["ciNationality"] = self?.nationalityModel?.dicFieldCode as AnyObject
                self?.baseChildInfo["ciNationalityName"] = self?.nationalityModel?.dicFieldName as AnyObject
            }
        }))
        baseInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "民族", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            if self?.nationModel != nil {
                self?.baseChildInfo["ciNaId"] = self?.nationModel?.naId as AnyObject
                self?.baseChildInfo["naName"] = self?.nationModel?.naName as AnyObject
            }
        }))
        baseInfoDataArr.append(HFPersonnelEditCellModel.init(type: .onlyShow, title: "证件类型", value: "居民身份证", placeholder: "请选择", serverKey: ""))
        let identityCardModel = HFPersonnelEditCellModel.init(type: .input, title: "有效证件号码", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciCardNo"] = newValue as AnyObject
            self?.ciCardNo = newValue
        })
        identityCardModel.maxLength = 18
        baseInfoDataArr.append(identityCardModel)
        baseInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "宝宝户籍", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            if self?.censusRegisterAddress.count != 0 {
                for (index,model) in self!.censusRegisterAddress.enumerated() {
                    switch index {
                    case 0:
                        self?.baseChildInfo["ciRegisteredProvince"] = model.diName as AnyObject // 户籍-省
                        self?.baseChildInfo["ciRegisteredProvinceCode"] = model.diId as AnyObject // 户籍-省业务ID
                    case 1:
                        self?.baseChildInfo["ciRegisteredCity"] = model.diName as AnyObject // 户籍-市
                        self?.baseChildInfo["ciRegisteredCityCode"] = model.diId as AnyObject // 户籍-市业务ID
                    case 2:
                        self?.baseChildInfo["ciRegisteredCounty"] = model.diName as AnyObject  // 户籍-县
                        self?.baseChildInfo["ciRegisteredCountyCode"] = model.diId as AnyObject // 户籍-县业务ID
                    default:
                        break
                    }
                }
            }
        }))
        
        // 幼儿园信息
//        dataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "幼儿园名称", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
//        }))
//        dataArr.append(HFPersonnelEditCellModel.init(type: .onlyShow, title: "幼儿园编号", value: "", placeholder: "未知", valueChangeBlock: { [weak self] (newValue) in
//        }))
//        dataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "年级", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
//        }))
//        dataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "班级", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
//        }))
//        dataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "所在地区", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
//        }))
//        dataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "详细地址", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
//        }))
        
        // 入园信息
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "身高（cm）", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciHeight"] = Double(newValue) as AnyObject
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "体重（kg）", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciWeight"] = Double(newValue) as AnyObject
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "入园前由谁照看", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            if self?.ciBeCareByModel != nil {
                self?.baseChildInfo["ciBeCareBy"] = self?.ciBeCareByModel?.dicFieldCode as AnyObject
                self?.baseChildInfo["ciBeCareByName"] = self?.ciBeCareByModel?.dicFieldName as AnyObject
            }
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "入园日期", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciAdmissionDate"] = newValue as AnyObject
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "宝宝性格", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciCharacter"] = newValue as AnyObject
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "兴趣爱好", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciInterest"] = newValue as AnyObject
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "之前是否上过幼儿园", value: "2", placeholder: "", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciSchooledStatus"] = newValue as AnyObject
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "喜欢吃的食物", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciFavoriteFood"] = newValue as AnyObject
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "不喜欢吃的食物", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciDislikeFood"] = newValue as AnyObject
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "是否自己大小便", value: "2", placeholder: "", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciSelfDefecation"] = newValue as AnyObject
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "是否自己穿衣服", value: "2", placeholder: "", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciSelfDress"] = newValue as AnyObject
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "是否自己吃饭", value: "2", placeholder: "", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciSelfEat"] = newValue as AnyObject
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "是否有兄弟姐妹", value: "2", placeholder: "", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciOnlyChild"] = newValue as AnyObject
            self?.ciOnlyChild = newValue == "1"
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "选择兄弟姐妹", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            if self?.childBrotherRelationModel != nil {
                self?.baseChildBrother["cbRelation"] = self?.childBrotherRelationModel?.dicFieldCode as AnyObject
                self?.baseChildBrother["cbRelationName"] = self?.childBrotherRelationModel?.dicFieldName as AnyObject
            }
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "兄弟姐妹姓名", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildBrother["cbName"] = newValue as AnyObject
        }))
        intoKindergartenDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "兄弟姐妹年龄", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildBrother["cbAge"] = Int(newValue) as AnyObject
        }))
        
        // 健康信息
        healthInfoDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "曾经是否患过疾病", value: "2", placeholder: "", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciHadIll"] = newValue as AnyObject
        }))
        healthInfoDataArr.append(HFPersonnelEditCellModel.init(type: .multInput, title: "", value: "", placeholder: "请输入患病名称", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciHadIllName"] = newValue as AnyObject
        }))
        healthInfoDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "是否接种全部疫苗", value: "2", placeholder: "", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciVaccinationStatus"] = newValue as AnyObject
        }))
        healthInfoDataArr.append(HFPersonnelEditCellModel.init(type: .multInput, title: "", value: "", placeholder: "请输入接种疫苗名称，如果有多重请用逗号隔开", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciVaccination"] = newValue as AnyObject
        }))
        healthInfoDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "是否有过敏史", value: "2", placeholder: "", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciHasAllergy"] = newValue as AnyObject
        }))
        healthInfoDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "是否戴眼镜", value: "2", placeholder: "", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciMyopiaStatus"] = newValue as AnyObject
        }))
        healthInfoDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "是否肥胖", value: "2", placeholder: "", valueChangeBlock: { [weak self] (newValue) in
            self?.baseChildInfo["ciFatStatus"] = newValue as AnyObject
        }))
    }
    
    // 添加其他亲属
    func addParent() -> Void {
        
        let baaseParentInfoModel = HFBaseParentInfoModel.init()
        
        let index = parentInfoArr.count
        
        parentInfoArr.append(baaseParentInfoModel)
        
        var parentInfoDataArr = [HFPersonnelEditCellModel]()
        
        // 家属信息
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "与宝宝关系", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            if self?.relationModel != nil {
                let baaseParentInfoModel = self?.parentInfoArr[index]
                baaseParentInfoModel?.cprRelp = self?.relationModel?.dicFieldCode ?? ""
                baaseParentInfoModel?.cprRelpName = self?.relationModel?.dicFieldName ?? ""
            }
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "姓名", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr[index]
            baaseParentInfoModel?.baseParentInfoResul.usrFullName = newValue
        }))
        let phoneCellModel = HFPersonnelEditCellModel.init(type: .input, title: "手机号", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr[index]
            baaseParentInfoModel?.baseParentInfoResul.usrPhone = newValue
        })
        phoneCellModel.maxLength = 11
        parentInfoDataArr.append(phoneCellModel)
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "国籍", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            if self?.nationalityModel != nil {
                let baaseParentInfoModel = self?.parentInfoArr[index]
                baaseParentInfoModel?.baseParentInfoResul.piNationality = self?.nationalityModel?.dicFieldCode ?? ""
                baaseParentInfoModel?.baseParentInfoResul.piNationalityName = self?.nationalityModel?.dicFieldName ?? ""
            }
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "出生日期", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr[index]
            baaseParentInfoModel?.baseParentInfoResul.usrBirthday = newValue
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .onlyShow, title: "年龄", value: "", placeholder: "未知", serverKey: ""))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "学历", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            if self?.educationModel != nil {
                let baaseParentInfoModel = self?.parentInfoArr[index]
                baaseParentInfoModel?.baseParentInfoResul.piEducation = self?.educationModel?.dicFieldCode ?? ""
                baaseParentInfoModel?.baseParentInfoResul.eiEducationTitle = self?.educationModel?.dicFieldName ?? ""
            }
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "职业", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr[index]
            baaseParentInfoModel?.baseParentInfoResul.piVocation = newValue
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "籍贯", value: "", placeholder: "请选择", valueChangeBlock: { [weak self] (newValue) in
            if self?.nativePlaceModel != nil {
                let baaseParentInfoModel = self?.parentInfoArr[index]
                baaseParentInfoModel?.baseParentInfoResul.piNativeProvince = self?.nativePlaceModel?.diName ?? ""
                baaseParentInfoModel?.baseParentInfoResul.piNativeProvinceCode = self?.nativePlaceModel?.diId ?? ""
            }
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "工作单位", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr[index]
            baaseParentInfoModel?.baseParentInfoResul.piWorkPlace = newValue
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .select, title: "户籍所在地", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            if self?.censusRegisterAddress.count != 0 {
                let baaseParentInfoModel = self?.parentInfoArr[index]
                for (index,model) in self!.censusRegisterAddress.enumerated() {
                    switch index {
                    case 0:
                        baaseParentInfoModel?.baseParentInfoResul.piHrProvince = model.diName // 户籍-省
                        baaseParentInfoModel?.baseParentInfoResul.piHrProvinceCode = model.diId // 户籍-省业务ID
                    case 1:
                        baaseParentInfoModel?.baseParentInfoResul.piHrCity = model.diName // 户籍-市
                        baaseParentInfoModel?.baseParentInfoResul.piHrCityCode = model.diId // 户籍-市业务ID
                    case 2:
                        baaseParentInfoModel?.baseParentInfoResul.piHrCounty = model.diName  // 户籍-县
                        baaseParentInfoModel?.baseParentInfoResul.piHrCountyCode = model.diId // 户籍-县业务ID
                    default:
                        break
                    }
                }
            }
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "户籍详细地址", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr[index]
            baaseParentInfoModel?.baseParentInfoResul.piHrAdd = newValue
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .input, title: "现居详细地址", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr[index]
            baaseParentInfoModel?.baseParentInfoResul.piNhomAdd = newValue
        }))
        parentInfoDataArr.append(HFPersonnelEditCellModel.init(type: .onlySelect, title: "设为第一联系人", value: "", placeholder: "请输入", valueChangeBlock: { [weak self] (newValue) in
            let baaseParentInfoModel = self?.parentInfoArr[index]
            baaseParentInfoModel?.cprDef = Int(newValue) ?? 0
        }))
        otherParentInfoDataArr.append(parentInfoDataArr)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 国籍
    var nationalityModel: HFDictionaryInfoModel?
    /// 民族
    var nationModel: HFDictionaryInfoModel?
    /// 户籍所在地
    var censusRegisterAddress: [HFRegionModel] = []
    /// 与宝宝关系
    var relationModel: HFDictionaryInfoModel?
    /// 家长学历
    var educationModel: HFDictionaryInfoModel?
    /// 家长籍贯
    var nativePlaceModel: HFRegionModel?
    /// 兄弟姐妹与宝宝关系
    var childBrotherRelationModel: HFDictionaryInfoModel?
    /// 入园前由谁照看
    var ciBeCareByModel: HFDictionaryInfoModel?
    
    /// 是否有兄弟姐妹
    var ciOnlyChild = false
    
    var editType: HFEditBabyInfoType = .baseInfo {
        didSet {
            switch editType {
            case .parentInfo:
                title = "家属信息"
            case .baseInfo:
                title = "基本信息"
            case .kindergarten:
                title = "幼儿园信息"
            case .intoKindergarten:
                title = "入园信息"
            case .healthInfo:
                title = "健康信息"
            default:
                break
            }
        }
    }
    
    var parameters: [String: AnyObject] = [:]
    private var baseChildInfo: [String: AnyObject] = [:] // 档案信息
    
    private var parentIndex = -1 // 当前编辑的家长下标
    private var baseParentInfo: [String: AnyObject] = [:] // 家长信息
    private var baseParentInfoResult: [String: AnyObject] = [:]
    private var baseParentUserResult: [String: AnyObject] = [:]
    
    private var baseChildBrother:[String: AnyObject] = [:] // 宝宝兄弟姐妹
    
    private var baseKgInfo:[String: AnyObject] = [:] // 幼儿园信息
    private var eduBaseClass:[String: AnyObject] = [:] // 宝宝班级信息
    private var eduBaseKgGrade:[String: AnyObject] = [:] // 年级信息
    
    /// 0：保存 1：提交
    var sumbitType = 0
    
    // 编辑、保存回调
    var responseDic: [String:AnyObject]?
    
    /// 编辑宝宝信息
    ///   - successClosure: 请求成功
    ///   - failClosure: 请求失败
    /// - Returns: 无返回值
    func editChildInfo(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        
        let model = HFPopupDataManager.shared.joinResultModel
        baseChildInfo["ciId"] = model?.ciId as AnyObject
        parameters["baseChildInfo"] = baseChildInfo as AnyObject
        baseKgInfo["kiId"] = model?.kiId as AnyObject
        parameters["type"] = sumbitType as AnyObject
        
        var baseParentInfoList: [[String:Any]] = []
        for model in parentInfoArr {
            baseParentInfoList.append(model.toJSON())
        }
        parameters["baseParentInfoList"] = baseParentInfoList as AnyObject
        
        if self.ciOnlyChild {
            // 兄弟姐妹
            parameters["baseChildBrotherList"] = [baseChildBrother] as AnyObject
        }
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.ChildEntryKiAPI, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            
            self.responseDic = dic as? [String : AnyObject]
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    var ciCardNo: String?
    
    /// 宝宝数据确认同步
    func sureInfoSynchronization(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        let model = HFPopupDataManager.shared.joinResultModel
        baseChildInfo["ciId"] = model?.ciId as AnyObject
        baseChildInfo["ciCardNo"] = self.ciCardNo as AnyObject
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.ChildInfoSynchronizationAPI, para: parameters, successed: { (response) in
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    
    /// 查看宝宝
    /// - Parameters:
    ///   - successClosure: 请求成功
    ///   - failClosure: 请求失败
    /// - Returns: 无返回值
    func getBabyDetail(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        
        var parameters = [String: AnyObject]()
        let model = HFPopupDataManager.shared.joinResultModel
        parameters["ciId"] = model?.ciId as AnyObject
        
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.LookChildAPI, para: parameters, successed: { (response) in
            
            let externalDic = [String:Any]()
            var dataDic = response["model"] as! [String : Any]
            if let baseChildInfo = dataDic["baseChildInfo"] as? [String:Any] {
                dataDic = dataDic.merging(baseChildInfo ) { (current, _) in current }
            }
            dataDic = externalDic.merging(dataDic ) { (_, new) in new }
            
            self.babyModel = HFBabyModel.init(JSON: dataDic)
            
            self.handleData()
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 处理家长信息
    /// - Returns: 无返回值
    func handleData() -> Void {
        if self.babyModel == nil {
            return
        }
        // 家属信息，且携带了家属数据模型
        for (index,model) in self.babyModel!.baseParentInfoList.enumerated() {
            var tempArr = [String]()
            tempArr.append(model.cprRelpName)
            tempArr.append(model.baseParentUserResult == nil ? "" : model.baseParentUserResult!.usrFullName)
            tempArr.append(model.baseParentUserResult == nil ? "" : model.baseParentUserResult!.usrPhone)
            tempArr.append(model.baseParentInfoResult == nil ? "" : model.baseParentInfoResult!.piNationality)
            tempArr.append(model.baseParentUserResult == nil ? "" : model.baseParentUserResult!.usrBirthday)
            tempArr.append(model.baseParentUserResult == nil ? "" : model.baseParentUserResult!.usrBirthday.isEmptyStr() ? "" : String.caculateAgeY(birthday: model.baseParentUserResult!.usrBirthday) + "岁")
            tempArr.append(model.baseParentInfoResult == nil ? "" : model.baseParentInfoResult!.eiEducationTitle)
            tempArr.append(model.baseParentInfoResult == nil ? "" : model.baseParentInfoResult!.piVocation)
            tempArr.append(model.baseParentInfoResult == nil ? "" : model.baseParentInfoResult!.piNativeProvince)
            tempArr.append(model.piWrkPlace)
            if model.baseParentInfoResult != nil {
                tempArr.append("\(model.baseParentInfoResult!.piHrProvince.isEmpty ? "" : model.baseParentInfoResult!.piHrProvince + "-")\(model.baseParentInfoResult!.piHrCity.isEmpty ? "" : model.baseParentInfoResult!.piHrProvince + "-")\(model.baseParentInfoResult!.piHrCounty.isEmpty ? "" : model.baseParentInfoResult!.piHrCounty)")
            }else{
                tempArr.append("")
            }
            tempArr.append(model.baseParentInfoResult == nil ? "" : model.baseParentInfoResult!.piHrAdd)
            tempArr.append(model.baseParentInfoResult == nil ? "" : model.baseParentInfoResult!.piNhomAdd)
            tempArr.append("\(model.cprDef)")
            if index == 0 {
                
                for (index,value) in parentInfoDataArr.enumerated() {
                    let model = value as HFPersonnelEditCellModel
                    model.value = tempArr[index]
                }
            }else{
                self.addParent()
                
                let arr = otherParentInfoDataArr[index - 1]
                
                for (index,value) in arr.enumerated() {
                    let model = value as HFPersonnelEditCellModel
                    model.value = tempArr[index]
                }
            }
            
            let parentDic = model.toJSON()
            parentInfoArr[index] = HFBaseParentInfoModel.init(JSON: parentDic) ?? HFBaseParentInfoModel.init()
        }
        
        
        // 编辑基础信息
        var baseInfoTempArr = [String]()
        baseInfoTempArr.append(babyModel!.headImg)
        baseInfoTempArr.append(babyModel!.ciName)
        baseInfoTempArr.append(babyModel!.ciNickname)
        baseInfoTempArr.append("\(babyModel!.ciSex)")
        baseInfoTempArr.append(babyModel!.ciBirth.substring(to: 10))
        baseInfoTempArr.append(babyModel!.ciNationality)
        baseInfoTempArr.append(babyModel!.naName)
        baseInfoTempArr.append("居民身份证")
        baseInfoTempArr.append(babyModel!.ciCardNo)
        baseInfoTempArr.append("")
        for (index,value) in baseInfoDataArr.enumerated() {
            let model = value as HFPersonnelEditCellModel
            model.value = baseInfoTempArr[index]
        }
        
        
        // 编辑入园信息
        var intoKindergartenTempArr = [String]()
        intoKindergartenTempArr.append("\(babyModel!.ciHeight)")
        intoKindergartenTempArr.append("\(babyModel!.ciWeight)")
        intoKindergartenTempArr.append(babyModel!.ciBeCareBy)
        intoKindergartenTempArr.append(babyModel!.ciAdmissionDate.substring(to: 10))
        intoKindergartenTempArr.append(babyModel!.ciCharacter)
        intoKindergartenTempArr.append(babyModel!.ciInterest)
        intoKindergartenTempArr.append("\(babyModel!.ciSchooledStatus)")
        intoKindergartenTempArr.append(babyModel!.ciFavoriteFood)
        intoKindergartenTempArr.append(babyModel!.ciDislikeFood)
        intoKindergartenTempArr.append("\(babyModel!.ciSelfDefecation)")
        intoKindergartenTempArr.append("\(babyModel!.ciSelfDress)")
        intoKindergartenTempArr.append("\(babyModel!.ciSelfEat)")
        intoKindergartenTempArr.append("\(babyModel!.ciOnlyChild)")
        if babyModel!.ciOnlyChild == 1 && babyModel!.baseChildBrotherList.count != 0 {
            // 有兄弟姐妹
            let model = babyModel!.baseChildBrotherList.first
            intoKindergartenTempArr.append(model!.cbRelationName)
            intoKindergartenTempArr.append(model!.cbName)
            intoKindergartenTempArr.append("\(model!.cbAge)岁")
            self.ciOnlyChild = true
        }
        for (index,value) in intoKindergartenDataArr.enumerated() {
            let model = value as HFPersonnelEditCellModel
            if index < intoKindergartenTempArr.count {
                model.value = intoKindergartenTempArr[index]
            }
        }
        
        
        // 编辑健康信息
        var healthInfoTempArr = [String]()
        healthInfoTempArr.append("\(babyModel!.ciHadIll)")
        healthInfoTempArr.append(babyModel!.ciHadIllName)
        healthInfoTempArr.append("\(babyModel!.ciVaccinationStatus)")
        healthInfoTempArr.append(babyModel!.ciVaccination)
        healthInfoTempArr.append("\(babyModel!.ciHasAllergy)")
        healthInfoTempArr.append("\(babyModel!.ciMyopiaStatus)")
        healthInfoTempArr.append("\(babyModel!.ciFatStatus)")
        
        for (index,value) in healthInfoDataArr.enumerated() {
            let model = value as HFPersonnelEditCellModel
            model.value = healthInfoTempArr[index]
        }
    }
}
