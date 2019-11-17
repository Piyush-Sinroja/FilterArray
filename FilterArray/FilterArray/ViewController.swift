//
//  ViewController.swift
//  FilterArray
//


import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource {

    @IBOutlet weak var txtFilter: UITextField!
    @IBOutlet weak var tblFilter: UITableView!
    
    var arrMain = [[String: String]]()
    var arrTemp = [[String: String]]()
    var strSearch : String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dic1 = ["name": "Ravi"]
        let dic2 = ["name": "Aavi"]
        let dic3 = ["name": "Navi"]
        
        arrMain.append(dic1)
        arrMain.append(dic2)
        arrMain.append(dic3)

        arrTemp = arrMain
        
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
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let objCountryListCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        let dic = arrMain[indexPath.row]
        objCountryListCell.textLabel?.text = dic["name"]
    
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
            updateTable(normalListArr: arrTemp, strkey: "name")
        }
        
        return true
    }

    //MARK:- Search Update
    func updateTable(normalListArr: [[String: String]], strkey: String) {
        var filteredListarr = [[String: String]]()
        
        filteredListarr = normalListArr
        
        let predicate: NSPredicate?
        
        if strkey.count > 0 {
            predicate = NSPredicate(format: "%K BEGINSWITH[cd]%@", strkey, "\(strSearch)")
        }
        else {
            predicate = NSPredicate(format: "self BEGINSWITH[cd] %@", "\(strSearch)")
        }
        
        guard let predicateValue = predicate else {
            return
        }
        
        filteredListarr = filteredListarr.filter(predicateValue.evaluate(with:))
        
        if strSearch.count == 0 {
            updateNEw(filteredarr: normalListArr)
        }
        else{
            updateNEw(filteredarr: filteredListarr)
        }
    }

   func updateNEw(filteredarr: [[String: String]]) {
    if filteredarr.count > 0 {
        arrMain = filteredarr
        tblFilter.reloadData()
    }
   }
}
