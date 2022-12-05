//
//  ScanVC.swift
//  FoodTrackVC
//
//  Created by Sproull Student on 12/2/22.
//

import UIKit
import AVFoundation

class ScanVC: UIViewController, UIImagePickerControllerDelegate, UITableViewDelegate, UINavigationControllerDelegate, UITableViewDataSource, AVCapturePhotoCaptureDelegate{
    
    //DATA STORING VARIABLES
    var currentImage: UIImage!
    var list:[Item] = []
    
    //var reponse: APIResult!
    
    //DATA SEARCHING CONTENT
    // API key = 3f675a8971ee60bd859a24c2e097db32
    func dataFetch(_ image: UIImage) {
        do {
            let link = "https://api-2445582032290.production.gw.apicast.io/v1/foodrecognition?user_key=a519fa5eb1b1a39d92d0e5f4f7400513"
            let url = URL(string: link)
            
            let croppedCGImage = (image.cgImage?.cropping(to: CGRect(x: 0, y: 0, width: 544, height: 544)))!
            
            let imageFinal = UIImage(cgImage: croppedCGImage)
            
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
            request.httpBody = imageFinal.jpegData(compressionQuality: 1.0)
            
            var theData: ImageAPIResult?
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
            
                if let error = error {
                    // Handle HTTP request error
                    print(error)
                } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    // Handle HTTP request response
                    print(responseString)
                                        
                    theData = try! JSONDecoder().decode(ImageAPIResult.self, from:data)
                    
                    if theData?.results.count ?? 0 > 0 {
                    if let res = theData?.results[0].items {
                        print(res)
                        self.list = res
                    }
                    }
                } else {
                    // Handle unexpected error
                    print("unexpected error")
                }
            }
            task.resume()
        }
        
        do {
            self.resultsTV.reloadData()
        }
        
    }
    
    @IBAction func search(_ sender: Any) {
        guard let searchImage = capturedView.image else {
            print("")
            return
        }
        currentImage = searchImage
        dataFetch(currentImage)
        resultsTV.reloadData()
    }
    
    
    // TABLEVIEW CONTENT
    @IBOutlet weak var resultsTV: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "searchcell")
        cell.textLabel!.text = list[indexPath.row].name + " (" + String(list[indexPath.row].nutrition.calories) + ")"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTV.register(UITableViewCell.self, forCellReuseIdentifier: "searchcell")
        resultsTV.dataSource = self
        resultsTV.delegate = self
    }
    

    
    //CAMERA CONTENT
    var capturing: AVCaptureSession!
    var videoLayer: AVCaptureVideoPreviewLayer!
    var capturedImage: AVCapturePhotoOutput!
    @IBOutlet weak var capturedView: UIImageView!
    @IBOutlet weak var cameraView: UIView!
    
    //take picture
    @IBAction func upload(_ sender: Any) {// actually a taking pictures function
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        capturedImage.capturePhoto(with: settings, delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        capturing = AVCaptureSession()
        capturing.sessionPreset = .high
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
            // needs add code for pop up messages
                print("Unable to access back camera!")
                return
        }
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            capturedImage = AVCapturePhotoOutput()
            if capturing.canAddInput(input) && capturing.canAddOutput(capturedImage) {
                capturing.addInput(input)
                capturing.addOutput(capturedImage)
                setupCapturingView()
            }
        }
        catch let error  {
            let message = UIAlertController(title: "Unable to access camera", message: "Allow Camera Access", preferredStyle: UIAlertController.Style.alert)
            message.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(message, animated: true, completion: nil)
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
    }
    
    func setupCapturingView() {
        videoLayer = AVCaptureVideoPreviewLayer(session: capturing)
        videoLayer.videoGravity = .resizeAspect
        videoLayer.connection?.videoOrientation = .portrait
        cameraView.layer.addSublayer(videoLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.capturing.startRunning()
            DispatchQueue.main.async {
                self.videoLayer.frame = self.cameraView.bounds
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let photoData = photo.fileDataRepresentation() else {
            return
        }
        guard let photoImage = UIImage(data: photoData) else {
            return
        }
        capturedView.image = photoImage
//        currentImage = photoImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.capturing.stopRunning()
    }
    
    //function to upload image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            let background_image = UIColor(patternImage: image)
            capturedView.backgroundColor = background_image
        }
        //print("\(info)")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func realUpload(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dfv = DetailedFoodView()
        dfv.foodName = self.list[indexPath.row].name
        dfv.calories = Int(self.list[indexPath.row].nutrition.calories)
        navigationController?.pushViewController(dfv, animated: true)
    }
    
}
