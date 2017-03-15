//
//  ViewController.swift
//  FilterArray
//


import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource {

    @IBOutlet weak var txtFilter: UITextField!
    @IBOutlet weak var tblFilter: UITableView!
    
    var arrMain: NSMutableArray = NSMutableArray()
    var arrTemp: NSArray = NSArray()
    var strSearch : String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dic1: NSDictionary = ["name": "Ravi"]
        let dic2: NSDictionary = ["name": "Aavi"]
        let dic3: NSDictionary = ["name": "Navi"]
        
        arrMain.add(dic1)
        arrMain.add(dic2)
        arrMain.add(dic3)

        arrTemp = arrMain.mutableCopy() as! NSArray
        
        let label = UILabel(frame: CGRect(x :0,y :0,width :10,height: 10))
        label.text = ""
        txtFilter.leftViewMode = .always
        txtFilter.leftView = label

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- UITableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMain.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let objCountryListCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        let dic: NSDictionary = arrMain[indexPath.row] as! NSDictionary
        objCountryListCell.textLabel?.text = dic.object(forKey: "name") as! String?
    
        return objCountryListCell
    }
    
    
    //MARK:- UITextField Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString = (textField.text! as NSString)
            .replacingCharacters(in: range, with: string)
        
        strSearch = currentString
        
        if textField == txtFilter {
            updateTable(NormalListArr: arrTemp as! NSMutableArray, strkey: "name")
        }
        
        return true
    }

    //MARK:- Search Update
    func updateTable(NormalListArr: NSArray, strkey: String) {
        var filteredListarr: NSMutableArray?
        filteredListarr = nil
        
        filteredListarr = NSMutableArray.init(array: NormalListArr)
        
        let predicate: NSPredicate?
        
        if strkey.characters.count > 0 {
            predicate = NSPredicate(format: "%K BEGINSWITH[cd]%@", strkey, "\(strSearch)")
        }
        else {
            predicate = NSPredicate(format: "self BEGINSWITH[cd] %@", "\(strSearch)")
        }
        
        filteredListarr?.filter(using: predicate!)
        
        if strSearch.characters.count == 0 {
            updateNEw(filteredarr: NormalListArr)
        }
        else{
            updateNEw(filteredarr: filteredListarr!)
        }
    }

   func updateNEw(filteredarr: NSArray) {
    if filteredarr.count > 0 {
        arrMain = filteredarr.mutableCopy() as! NSMutableArray
        tblFilter.reloadData()
    }
   }
}
