//
//  EditPageViewController.swift
//  ASiC3Quiz2
//
//  Created by steven.chou on 2017/4/7.
//  Copyright © 2017年 my app. All rights reserved.
//

import UIKit
import Photos

class EditPageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var defaultImageIcon: UIImageView!
    @IBOutlet weak var defaultText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaultView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setKeyboardObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        removeKeyboardObserver()
    }
    func setDefaultView() {

        let color1 = UIColor(red: 26/255, green: 34/255, blue: 38/255, alpha: 1)
        let color2 = UIColor(red: 67/255, green: 87/255, blue: 97/255, alpha: 1)

        let gradient = CAGradientLayer()
        gradient.frame = imageView.frame
        gradient.colors = [color1.cgColor, color2.cgColor]
        imageView.layer.insertSublayer(gradient, at: 0)

        let image = UIImage(named: "icon_photo")!.withRenderingMode(.alwaysTemplate)
        defaultImageIcon.image = image
        defaultImageIcon.tintColor = .white

        // Set action in imageView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.openPhotoLibrary))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)

    }

    // MARK: - Keyboard Observer
    func setKeyboardObserver() {

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(EditPageViewController.keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(EditPageViewController.keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)

    }

    func removeKeyboardObserver() {

        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillShow,
                                                  object: nil)

        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillHide,
                                                  object: nil)

    }

    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    // MARK: - Photo
    func openPhotoLibrary() {
        print("=== openPhotoLibrary ===")
        // check permission
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            // open library
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)

        } else {
            // need permission
            needPermission()
        }
    }

    func needPermission() {
        print("=== needPermission ===")
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (_) in
                self.openPhotoLibrary()
            })
        } else {
            // user do not give us permission
            let url = URL(string: UIApplicationOpenSettingsURLString)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func saveData() {

    }
}

extension EditPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        self.defaultText.isHidden = true
        self.defaultImageIcon.isHidden = true

        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }

        self.imageView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.imageView.image = image
//        self.imageView.contentMode = .scaleAspectFit

        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
