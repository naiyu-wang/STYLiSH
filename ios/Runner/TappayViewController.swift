//
//  TappayViewController.swift
//  Runner
//
//  Created by NaiYu on 2023/4/25.
//

import UIKit
import TPDirect

class TappayViewController: UIViewController {

    private var tpdForm: TPDForm = TPDForm()
    private var tpdCard: TPDCard = TPDCard()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tpdForm = TPDForm.setup(withContainer: self.view)
        self.tpdCard = TPDCard.setup(self.tpdForm)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTPDFormUI()
        setUpTPDActions()
    }

    private func setUpTPDFormUI() {
        tpdForm.setErrorColor(UIColor.red)
        tpdForm.setOkColor(UIColor.green)
        tpdForm.setNormalColor(UIColor.black)

        tpdForm.setIsUsedCcv(true)
    }

    private func setUpTPDActions() {
        tpdForm.onFormUpdated { (status) in
            if (status.isCanGetPrime()) {
                // Can make payment.
                print("Can make payment.")
            } else {
                // Can't make payment.
                print("Can't make payment.")
            }
        }

        tpdCard.onSuccessCallback { (prime, cardInfo, cardIdentifier, dict) in

            print("Prime : \(prime!), cardInfo : \(cardInfo), cardIdentifier : \(cardIdentifier)")

        }.onFailureCallback { (status, message) in

            print("status : \(status) , Message : \(message)")

        }.getPrime()
    }

}
