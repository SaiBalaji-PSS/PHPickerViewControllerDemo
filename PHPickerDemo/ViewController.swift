//
//  ViewController.swift
//  PHPickerDemo
//
//  Created by Sai Balaji on 13/08/23.
//

import UIKit
import PhotosUI
class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pickImage))
    }
    
    func configureImagePicker(){
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }

    @objc func pickImage(){
        configureImagePicker()
    }

}

extension ViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        if let itemprovider = results.first?.itemProvider{
          
            if itemprovider.canLoadObject(ofClass: UIImage.self){
               
                itemprovider.loadObject(ofClass: UIImage.self) { image , error  in
                    if let selectedImage = image as? UIImage{
                        DispatchQueue.main.async {
                            self.imageView.image = selectedImage
                        }
                    }
                }
            }
            
        }
    }
}
    
    


