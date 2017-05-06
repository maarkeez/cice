//
//  InformacionViewController.swift
//  DMD
//
//  Created by CICE on 16/12/16.
//  Copyright © 2016 David. All rights reserved.
//

import UIKit
//Para poder enviar correos electronicos
import MessageUI

class InformacionViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var myWebView: UIWebView!

    //MARK: - IBAction
    @IBAction func myVolverACTION(_ sender: AnyObject) {
        
        //Para que pueda volver a la página anterior
        dismiss(animated: true, completion: nil)
    }
    
    //Enviar email con el delegado nativo de iPHONE
    @IBAction func enviarMailACCION(_ sender: AnyObject) {
        //Creamos el objeto
        let mailComposeVC = configuracionMailVC()
        //Si se puede enviar, lo enviamos
        if MFMailComposeViewController.canSendMail(){
            present(mailComposeVC, animated: true, completion: nil)
            
        }else{
            //Si no se puede enviar, mostramos una alerta
            let alertVC = UIAlertController(title: "Estimado usuario", message: "No se ha logrado enviar e email", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertVC, animated: true, completion: nil)
            
        }
    }
    
    //MARK: - LIFEVC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recuperamos el HTML del proyecto
        if let htmlFile = Bundle.main.path(forResource: "Target", ofType:  "html"){
            //Si podemos recuperar el HTML que hemos creado:

            //Intentamos convertirlo en un fichero HTML
            let fileHtml = NSData(contentsOfFile: htmlFile)
            //Recuperamos la URL base para el fichero
            let baseURL = URL.init(fileURLWithPath: Bundle.main.bundlePath)
            self.myWebView.load(fileHtml! as Data, mimeType: "text/html", textEncodingName: "utf-8", baseURL: baseURL)

            
        }else{
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: - Utils
    func configuracionMailVC() -> MFMailComposeViewController{
        let mail = MFMailComposeViewController()
        mail.setToRecipients([""])
        mail.setSubject("Asunto")
        mail.setMessageBody("Cuerpo del email", isHTML: false)
        mail.mailComposeDelegate = self
        return mail
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare  (for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension InformacionViewController : MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
