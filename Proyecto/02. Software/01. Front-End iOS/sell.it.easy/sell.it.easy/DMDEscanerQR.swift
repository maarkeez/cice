//
//  DMDEscanerQR.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 12/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit
import AVFoundation

protocol DMDEscanerQRDelegate {
    func getCodigosEscaneados(_ escanerQR: DMDEscanerQR, codigos : [String])
}

class DMDEscanerQR: UIViewController , AVCaptureMetadataOutputObjectsDelegate{
    
    
    
    // make sure to add this sound to your project
    
    var audioPlayer = AVAudioPlayer()
    
    
    
    
    
    
    //MARK: - Variables locales
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    let supportedCodeTypes = [AVMetadataObjectTypeUPCECode,
                              AVMetadataObjectTypeCode39Code,
                              AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeCode93Code,
                              AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypeEAN8Code,
                              AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeAztecCode,
                              AVMetadataObjectTypePDF417Code,
                              AVMetadataObjectTypeQRCode]
    
    var codigosBarrasEscaneados : [String] = []
    var habilitarEscaner = true
    
    //MARK: - Delegado
    var delegate : DMDEscanerQRDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myTextoEscaner: UILabel!
    
    
    //MARK: - LIFE VC
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Preparar el repoductor de sonido
        let sound = URL(fileURLWithPath: Bundle.main.path(forResource: "beep", ofType: "mp3")! )
        print(sound)
        do {
            
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: sound)
            audioPlayer.prepareToPlay()
        }catch {
            print(error)
        }
        //  audioPlayer.prepareToPlay()
        
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Move the message label and top bar to the front
            myTextoEscaner.text = "No QR code is detected"
            view.bringSubview(toFront: myTextoEscaner)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.getCodigosEscaneados(self, codigos: codigosBarrasEscaneados)
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        if(habilitarEscaner){
            habilitarEscaner = false
            audioPlayer.play()
            
            // Get the metadata object.
            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            
            if supportedCodeTypes.contains(metadataObj.type) {
                // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
                
                let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
                qrCodeFrameView?.frame = barCodeObject!.bounds
                
                if metadataObj.stringValue != nil {
                    let codigoEscaneado : String = metadataObj.stringValue
                    
                    myTextoEscaner.text = "Escaneado:" + codigoEscaneado
                    
                    codigosBarrasEscaneados.append(codigoEscaneado)
                    showAlertEscaneado(codigoEscaneado)
                }
            }
        }
    }
    
    func showAlertEscaneado(_ codigo : String){
        let alertVC = UIAlertController(title: "Código escaneado", message: codigo, preferredStyle: .alert)
        let aceptarAction = UIAlertAction(title: "Aceptar", style: .default) { Void in
            self.habilitarEscaner = true
        }
        let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel) { Void in
            let ultimoIndex = self.codigosBarrasEscaneados.count - 1
            self.codigosBarrasEscaneados.remove(at: ultimoIndex)
            
            self.habilitarEscaner = true
        }
        alertVC.addAction(aceptarAction)
        alertVC.addAction(cancelarAction)
        present(alertVC, animated: true, completion: nil)
    }
    
}
