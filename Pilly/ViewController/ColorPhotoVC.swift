//
//  ColorPhotoVC.swift
//  Pilly
//
//  Created by Murtaza on 20/04/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit


protocol selectedColorDelegate:class  {
    func selectedColor(colorObj : Colours)
    func selectedImage(image: UIImage)
    func sendvalue(value:String)
}
struct Colours {
    var colorName : String
    var color : UIColor
}

class ColorPhotoVC: UIViewController , UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    var colorslected:Bool = false
    
    var nowColurObj:Colours?
    weak var delegate: selectedColorDelegate!
    
    @IBOutlet weak var mainImage: RoundImageView!
     var photodelegate:selectedColorDelegate?
    @IBOutlet weak var choosePhotolabel: UILabel!
    var lastSelection:Int = -1
     var imagePicker = UIImagePickerController()
    @IBOutlet weak var tableView : UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    

    var coloursArray = [Colours]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       mainImage.alpha = 0
         choosePhotolabel.alpha = 1
      imagePicker.delegate = self
        
        coloursArray.append(Colours.init(colorName: "red", color: UIColor.red))
        coloursArray.append(Colours.init(colorName: "blue", color: UIColor.blue))
        coloursArray.append(Colours.init(colorName: "Orange", color: UIColor.orange))
        coloursArray.append(Colours.init(colorName: "black", color: UIColor.black))
        coloursArray.append(Colours.init(colorName: "purple", color: UIColor.purple))
        coloursArray.append(Colours.init(colorName: "PINK", color: UIColor.PINK))
        coloursArray.append(Colours.init(colorName: "green", color: UIColor.green))
        coloursArray.append(Colours.init(colorName: "gray", color: UIColor.gray))
        coloursArray.append(Colours.init(colorName: "yellow", color: UIColor.yellow))
        coloursArray.append(Colours.init(colorName: "Dark", color: UIColor.darkText))
    }
    

    @IBAction func saveBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
     
        delegate?.sendvalue(value: "Helo Abc")
        if colorslected {
        delegate?.selectedColor(colorObj:self.nowColurObj!)
        }else{
        delegate?.selectedImage(image: mainImage.image!)
        }
        
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func ChooseBtn(_ sender: Any) {
        self.openMedia()
    }
    
  
    
}


func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "photo" {
        let dvc = segue.destination as! AddMedicationVC
        //dvc.seletedImg = mainima
    }
}




extension ColorPhotoVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coloursArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! colorCell
        cell.colorObj = self.coloursArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.coloursArray[indexPath.row])
        
        self.mainImage.alpha = 0
        self.choosePhotolabel.alpha = 1
        colorslected = true
        self.nowColurObj = self.coloursArray[indexPath.row]
         self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    //<--------------------------- Open Media ---------------------->
    
    func openMedia(){
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImage: UIImage!
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            
            picker.dismiss(animated: true, completion: nil)
        }
        mainImage.alpha = 1
        choosePhotolabel.alpha = 0
        mainImage.image = selectedImage
        colorslected = false
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
    }
    
    
}
