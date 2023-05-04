//
//  ViewController.swift
//  HW_UIStepper
//
//  Created by 曹家瑋 on 2023/5/3.
//

import UIKit

class ViewController: UIViewController {
    
    // Page Control 陣列相關
    @IBOutlet weak var advertisementImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // 廣告陣列
    let advertisements = ["ad1", "ad2", "ad3", "ad4", "ad5"]
    var index = 0
    
    // 廣告頁面的切換function
    func informationChange() {
        advertisementImageView.image = UIImage(named: advertisements[index])
        pageControl.currentPage = index
    }
    
    // 價格
    @IBOutlet weak var xt5PriceLabel: UILabel!
    @IBOutlet weak var griiiPriceLabel: UILabel!
    @IBOutlet weak var a74PriceLabel: UILabel!
    @IBOutlet weak var z9PriceLabel: UILabel!
    @IBOutlet weak var tamron35150PriceLabel: UILabel!
    @IBOutlet weak var xf56PriceLabel: UILabel!
    @IBOutlet weak var sony50PPriceLabel: UILabel!
    @IBOutlet weak var rf35PriceLabel: UILabel!
    
    // 數量
    @IBOutlet weak var xt5QtyLabel: UILabel!
    @IBOutlet weak var griiiQtyLabel: UILabel!
    @IBOutlet weak var a74QtyLabel: UILabel!
    @IBOutlet weak var z9QtyLabel: UILabel!
    @IBOutlet weak var tamron3515QtyLabel: UILabel!
    @IBOutlet weak var xf56QtyLabel: UILabel!
    @IBOutlet weak var sony50QtyLabel: UILabel!
    @IBOutlet weak var rf35QtyLabel: UILabel!
    
    // UIStepper
    @IBOutlet weak var xt5Stepper: UIStepper!
    @IBOutlet weak var griiiStepper: UIStepper!
    @IBOutlet weak var a74Stepper: UIStepper!
    @IBOutlet weak var z9Stepper: UIStepper!
    @IBOutlet weak var tamron35150Stepper: UIStepper!
    @IBOutlet weak var xf56Stepper: UIStepper!
    @IBOutlet weak var sony50Stepper: UIStepper!
    @IBOutlet weak var rf35Stepper: UIStepper!
    
    // 商品ScrollView、總金額Label
    @IBOutlet weak var cameraScrollView: UIScrollView!
    @IBOutlet weak var lensScrollView: UIScrollView!
    @IBOutlet weak var totalLabel: UILabel!
    
    // 產品數量
    var itemXt5:Int = 0
    var itemGriii:Int = 0
    var itemA74:Int = 0
    var itemZ9:Int = 0
    var itemTamron35150:Int = 0
    var itemXf56:Int = 0
    var itemSony50 = 0
    var itemRf35 = 0

    override func viewDidLoad() {
        super.viewDidLoad()
                        
        // 價格字串設定
        xt5PriceLabel.text = "55200"
        griiiPriceLabel.text = "29900"
        a74PriceLabel.text = "63500"
        z9PriceLabel.text = "116900"
        tamron35150PriceLabel.text = "52000"
        xf56PriceLabel.text = "27500"
        sony50PPriceLabel.text = "41980"
        rf35PriceLabel.text = "14900"
        
        // ScrollVIew 預設狀態
        cameraScrollView.isHidden = false
        lensScrollView.isHidden = true
        
    }

    // 廣告頁面上下頁
    @IBAction func swipePreviousPage(_ sender: Any) {
        if index == 0 {
            index = advertisements.count - 1
        } else {
            index = index - 1
        }
        informationChange()
    }

    @IBAction func swipeNextPage(_ sender: Any) {
        if index == advertisements.count - 1 {
            index = 0
        } else {
            index = index + 1
        }
        informationChange()
    }

    @IBAction func pageControlDidChange(_ sender: UIPageControl) {
        index = pageControl.currentPage
        informationChange()
    }
    
    // Stepper運用
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        // Stepper 的 item增減
        itemXt5 = Int(xt5Stepper.value)
        itemGriii = Int(griiiStepper.value)
        itemA74 = Int(a74Stepper.value)
        itemZ9 = Int(z9Stepper.value)
        itemTamron35150 = Int(tamron35150Stepper.value)
        itemXf56 = Int(xf56Stepper.value)
        itemSony50 = Int(sony50Stepper.value)
        itemRf35 = Int(rf35Stepper.value)

        // 數量轉為字串 Qty顯示
        xt5QtyLabel.text = String(itemXt5)
        griiiQtyLabel.text = String(itemGriii)
        a74QtyLabel.text = String(itemA74)
        z9QtyLabel.text = String(itemZ9)
        tamron3515QtyLabel.text = String(itemTamron35150)
        xf56QtyLabel.text = String(itemXf56)
        sony50QtyLabel.text = String(itemSony50)
        rf35QtyLabel.text = String(itemRf35)
        
        // 計算
        calculateTotalPrice()
        
    }
    
    // 清空
    @IBAction func clearButton(_ sender: UIButton) {
        
        // Stepper清空
        xt5Stepper.value = 0
        griiiStepper.value = 0
        a74Stepper.value = 0
        z9Stepper.value = 0
        tamron35150Stepper.value = 0
        xf56Stepper.value = 0
        sony50Stepper.value = 0
        rf35Stepper.value = 0
        
        // 數量字串清空
        xt5QtyLabel.text = "0"
        griiiQtyLabel.text = "0"
        a74QtyLabel.text = "0"
        z9QtyLabel.text = "0"
        tamron3515QtyLabel.text = "0"
        xf56QtyLabel.text = "0"
        sony50QtyLabel.text = "0"
        rf35QtyLabel.text = "0"
 
        // 總金額清空
        totalLabel.text = "0"
        
    }
    
    // 設置按鈕對ScrollView的顯示狀態
    @IBAction func showCameraButton(_ sender: UIButton) {
        
        cameraScrollView.isHidden = false
        lensScrollView.isHidden = true
        
    }
    
    @IBAction func showLensButton(_ sender: UIButton) {
        
        cameraScrollView.isHidden = true
        lensScrollView.isHidden = false
    }
    
    // 計算func
    func calculateTotalPrice() {
        
        // 價格 字串轉數字
        let xt5Price = Int(xt5PriceLabel.text!)!
        let griiiPrice = Int(griiiPriceLabel.text!)!
        let a74Price = Int(a74PriceLabel.text!)!
        let z9Price = Int(z9PriceLabel.text!)!
        let tamron35150Price = Int(tamron35150PriceLabel.text!)!
        let xf56Price = Int(xf56PriceLabel.text!)!
        let sony50Price = Int(sony50PPriceLabel.text!)!
        let rf35Price = Int(rf35PriceLabel.text!)!
        // 數字計算
        let totalPrice = xt5Price * itemXt5 + griiiPrice * itemGriii + a74Price * itemA74 + z9Price * itemZ9 + tamron35150Price * itemTamron35150 + xf56Price * itemXf56 + sony50Price * itemSony50 + rf35Price * itemRf35

        // 將數字變成金錢格式
        let priceformatter = NumberFormatter()
        priceformatter.numberStyle = .currency
        priceformatter.maximumFractionDigits = 0
        let priceString = priceformatter.string(from: NSNumber(value: totalPrice))

        // 總金額字串
        totalLabel.text = "\(priceString!)"
        
    }
    
}
