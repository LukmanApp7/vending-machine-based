//
//  ViewController.swift
//  VendingMachine
//
//  Created by Abu Lathiif on 15/09/23.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var item1: UIButton!
    @IBOutlet weak var item2: UIButton!
    @IBOutlet weak var item3: UIButton!
    @IBOutlet weak var item4: UIButton!
    @IBOutlet weak var item5: UIButton!
    @IBOutlet weak var stokItem1: UITextField!
    @IBOutlet weak var stokItem2: UITextField!
    @IBOutlet weak var stokItem3: UITextField!
    @IBOutlet weak var stokItem4: UITextField!
    @IBOutlet weak var stokItem5: UITextField!
    @IBOutlet weak var buttonBeli: UIButton!
    @IBOutlet weak var textfieldBayar: UITextField!
    @IBOutlet weak var textfieldKembali: UITextField!
    var itemStock = 5
    var flagButton = 0
    var itemPrice = 0
    var paidAmount = 0
    var leftAmount = 0
    var changeAmount = 0
    var isLeftAmount = false
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        //setup currency
        formatter.locale = Locale(identifier: "id_ID")
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textfieldBayar.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        setupView()
    }

    @IBAction func itemSelect(_ sender: Any) {
        if (!isLeftAmount) {
            textfieldBayar.text = ""
            textfieldKembali.text = "0"
            let itemButton = sender as! UIButton
            clearButtons()
            if (flagButton != itemButton.tag) {
                flagButton = itemButton.tag
                switch itemButton.tag {
                case 1:
                    if (stokItem1.text != "0") {
                        item1.layer.backgroundColor = CGColor(red: 0/255, green: 117/255, blue: 227/255, alpha: 1)
                        item1.setTitleColor(UIColor.white, for: .normal)
                        itemPrice = 6000
                    } else {
                        flagButton = 0
                        showAlert(message: "Biskuit habis")
                    }
                case 2:
                    if (stokItem2.text != "0") {
                        item2.layer.backgroundColor = CGColor(red: 0/255, green: 117/255, blue: 227/255, alpha: 1)
                        item2.setTitleColor(UIColor.white, for: .normal)
                        itemPrice = 8000
                    } else {
                        flagButton = 0
                        showAlert(message: "Chips habis")
                    }
                case 3:
                    if (stokItem3.text != "0") {
                        item3.layer.backgroundColor = CGColor(red: 0/255, green: 117/255, blue: 227/255, alpha: 1)
                        item3.setTitleColor(UIColor.white, for: .normal)
                        itemPrice = 10000
                    } else {
                        flagButton = 0
                        showAlert(message: "Oreo habis")
                    }
                case 4:
                    if (stokItem4.text != "0") {
                        item4.layer.backgroundColor = CGColor(red: 0/255, green: 117/255, blue: 227/255, alpha: 1)
                        item4.setTitleColor(UIColor.white, for: .normal)
                        itemPrice = 12000
                    } else {
                        flagButton = 0
                        showAlert(message: "Tango habis")
                    }
                case 5:
                    if (stokItem5.text != "0") {
                        item5.layer.backgroundColor = CGColor(red: 0/255, green: 117/255, blue: 227/255, alpha: 1)
                        item5.setTitleColor(UIColor.white, for: .normal)
                        itemPrice = 15000
                    } else {
                        flagButton = 0
                        showAlert(message: "Cokelat habis")
                    }
                default:
                    clearButtons()
                }
            } else {
                flagButton = 0
                itemPrice = 0
            }
        } else {
            showAlert(message: "Selesaikan pembelian sebelumnya")
        }
    }
    
    @IBAction func itemReset(_ sender: Any) {
        let itemButton = sender as! UIButton
        switch itemButton.tag {
        case 1:
            stokItem1.text = String(itemStock)
        case 2:
            stokItem2.text = String(itemStock)
        case 3:
            stokItem3.text = String(itemStock)
        case 4:
            stokItem4.text = String(itemStock)
        case 5:
            stokItem5.text = String(itemStock)
        default:
            setupView()
        }
    }
    
    @IBAction func itemPurchase(_ sender: Any) {
        if (textfieldBayar.text == "") {
            paidAmount = 0
        } else {
            let getNumber = textfieldBayar.text?.filter("1234567890".contains)
            paidAmount = Int(getNumber ?? "0") ?? 0
        }
        if (itemPrice == 0) {
            showAlert(message: "Anda belum memilih menu")
        } else if (paidAmount == 0) {
            showAlert(message: "Anda belum memasukan uang")
        } else {
            if (paidAmount != 2000 && paidAmount != 5000 && paidAmount != 10000 && paidAmount != 20000 && paidAmount != 50000) {
                showAlert(message: "Silahkan masukan uang pecahan 2.000, 5.000, 10.000, 20,000, 50.000")
            } else {
                if (isLeftAmount) {
                    if (paidAmount < leftAmount) {
                        leftAmount -= paidAmount
                        showAlert(message: "Uang anda kurang \(leftAmount), silahkan tambahkan uang lalu tekan tombol \"Beli\" lagi.")
                    } else {
                        isLeftAmount = false
                        changeAmount = paidAmount - leftAmount
                        purchaseSuccess()
                    }
                } else if (paidAmount < itemPrice) {
                    isLeftAmount = true
                    leftAmount = itemPrice - paidAmount
                    showAlert(message: "Uang anda kurang \(leftAmount), silahkan tambahkan uang lalu tekan tombol \"Beli\" lagi.")
                } else {
                    changeAmount = paidAmount - itemPrice
                    purchaseSuccess()
                }
            }
        }
    }
    
    func purchaseSuccess() {
        textfieldBayar.resignFirstResponder()
        var paidItem = ""
        switch flagButton {
        case 1:
            paidItem = "Biskuit"
            let count = Int(stokItem1.text!)! - 1
            stokItem1.text = String(count)
        case 2:
            paidItem = "Chips"
            let count = Int(stokItem2.text!)! - 1
            stokItem2.text = String(count)
        case 3:
            paidItem = "Oreo"
            let count = Int(stokItem3.text!)! - 1
            stokItem3.text = String(count)
        case 4:
            paidItem = "Tango"
            let count = Int(stokItem4.text!)! - 1
            stokItem4.text = String(count)
        case 5:
            paidItem = "Cokelat"
            let count = Int(stokItem5.text!)! - 1
            stokItem5.text = String(count)
        default:
            showAlert(message: "Pembelian berhasil")
        }
        
        if let formattedPaidAmount = formatter.string(from: paidAmount as NSNumber) {
            textfieldBayar.text = formattedPaidAmount
        }
        if let formattedChange = formatter.string(from: changeAmount as NSNumber) {
            textfieldKembali.text = formattedChange
        }
        
        flagButton = 0
        itemPrice = 0
        showAlert(message: "Pembelian \(paidItem) berhasil")
        clearButtons()
    }
    
    func setupView() {
        item1.setTitle("Biskuit \t\t\t\t  6.000", for: .normal)
        item2.setTitle("Chips \t\t\t\t  8.000", for: .normal)
        item3.setTitle("Oreo \t\t\t\t10.000", for: .normal)
        item4.setTitle("Tango \t\t\t\t12.000", for: .normal)
        item5.setTitle("Cokelat \t\t\t\t15.000", for: .normal)
        item1.layer.cornerRadius = 10
        item2.layer.cornerRadius = 10
        item3.layer.cornerRadius = 10
        item4.layer.cornerRadius = 10
        item5.layer.cornerRadius = 10
        buttonBeli.layer.cornerRadius = 8
        stokItem1.text = String(itemStock)
        stokItem2.text = String(itemStock)
        stokItem3.text = String(itemStock)
        stokItem4.text = String(itemStock)
        stokItem5.text = String(itemStock)
        textfieldBayar.delegate = self
    }
    
    func clearButtons() {
        item1.layer.backgroundColor = CGColor(red: 213/255, green: 235/255, blue: 255/255, alpha: 1)
        item2.layer.backgroundColor = CGColor(red: 213/255, green: 235/255, blue: 255/255, alpha: 1)
        item3.layer.backgroundColor = CGColor(red: 213/255, green: 235/255, blue: 255/255, alpha: 1)
        item4.layer.backgroundColor = CGColor(red: 213/255, green: 235/255, blue: 255/255, alpha: 1)
        item5.layer.backgroundColor = CGColor(red: 213/255, green: 235/255, blue: 255/255, alpha: 1)
        item1.setTitleColor(UIColor(red: 0/255, green: 117/255, blue: 227/255, alpha: 1), for: .normal)
        item2.setTitleColor(UIColor(red: 0/255, green: 117/255, blue: 227/255, alpha: 1), for: .normal)
        item3.setTitleColor(UIColor(red: 0/255, green: 117/255, blue: 227/255, alpha: 1), for: .normal)
        item4.setTitleColor(UIColor(red: 0/255, green: 117/255, blue: 227/255, alpha: 1), for: .normal)
        item5.setTitleColor(UIColor(red: 0/255, green: 117/255, blue: 227/255, alpha: 1), for: .normal)
    }
    
    func showAlert(message: String) {
        let setAlert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        setAlert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(setAlert, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        print(textField.text as Any)
        let getNumber = textField.text?.filter("1234567890".contains)
        let getText = Int(getNumber ?? "0") ?? 0
        print(getText)
        textField.text = formatter.string(from: getText as NSNumber)
    }
    
}

