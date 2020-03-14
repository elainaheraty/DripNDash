//
//  DasherJobStatusController.swift
//  DripNDash
//
//  Created by Marty McCluskey on 3/6/20.
//  Copyright © 2020 Liam McCluskey. All rights reserved.
//


/*                              GENERAL_INFO
 
statusUpdateButtons =
 - STAGE_2 : On Way for Pickup
    - PUSH_NOTIFICATION : Outside for Pickup
 - STAGE_3 : Picked Up Laundry
 - STAGE_4 : Laundry in Washer
 - STAGE_5 : Finished Washing
 - STAGE_6 : Laundry in Dryer
 - STAGE_7 : Finished Drying
 - STAGE_8 : On Way for Drop Off
    - PUSH_NOTIFICATION: Outside for Drop Off
 - STAGE_9 : Dropped Off Laundry
 
 let stages: [Int: String] = [
 /*
 During Stage -> After Stage Complete
 */
     0: "Waiting for Dasher to Accept", 1: "Dasher Accepted Request",
     2: "Dasher on Way for Pickup", 3: "Picked up Laundry,
     4: "Laundry in Washer", 5: "Finished Washing",
     6: "Laundry in Dryer", 7: "Finished Drying",
     8: "Dasher On Way for Drop Off", 9: "Dropped off Laundry"
 ]

*/
import UIKit

class DasherJobStatusController: UIViewController {
    
    // MARK: - Properties
    
    var jobRequest: JobRequest!
    
    let jobInfoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = UIColor.init(red: 135/255, green: 206/255, blue: 235/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let jobInfoHeader: UILabel = {
        let label = UILabel()
        label.text = "Job Information"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobInfoDivider: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var infoLabelStackView: UIStackView!
    var customerNameLabel: UILabel!
    var customerDormLabel: UILabel!
    var customerDormRoomLabel: UILabel!
    
    let updateStatusView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = UIColor.init(red: 135/255, green: 206/255, blue: 235/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let updateStatusHeader: UILabel = {
        let label = UILabel()
        label.text = "Update Job Status"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let updateStatusDivider: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var buttonStackView: UIStackView!
    var stage2UpdateButton: UIButton!
    var stage3UpdateButton: UIButton!
    var stage4UpdateButton: UIButton!
    var stage5UpdateButton: UIButton!
    var stage6UpdateButton: UIButton!
    var stage7UpdateButton: UIButton!
    var stage8UpdateButton: UIButton!
    var stage9UpdateButton: UIButton!
    
    let stages: [Int: String] = [
        /*
        During Stage -> After Stage Complete
        */
        0: "Waiting for Dasher to Accept", 1: "Dasher Accepted Request",
        2: "On Way for Pickup", 3: "Picked up Laundry",
        4: "Laundry in Washer", 5: "Finished Washing",
        6: "Laundry in Dryer", 7: "Finished Drying",
        8: "On Way for Drop Off", 9: "Dropped off Laundry"
    ]


    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUpAutoLayout()
    }
    
    init(jobRequest: JobRequest) {
        self.jobRequest = jobRequest
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Config
    
    func configureUI(){
        configureNavigationBar()
        
        // Job Information Section
        customerNameLabel = configureJobInfoLabel(keyLabel: "Customer Name", valueLabel: "DEFAULT_NAME")
        customerDormLabel = configureJobInfoLabel(keyLabel: "Customer Dorm", valueLabel: jobRequest.dorm)
        customerDormRoomLabel = configureJobInfoLabel(keyLabel: "Customer Dorm Room", valueLabel: String(jobRequest.dormRoom))
        infoLabelStackView = configureStackView(arrangedSubViews: [
            customerNameLabel,
            customerDormLabel,
            customerDormRoomLabel
            ])
        /*
        jobInfoView.addSubview(customerNameLabel)
        jobInfoView.addSubview(customerDormLabel)
        jobInfoView.addSubview(customerDormRoomLabel)
 */
 
        
        jobInfoView.addSubview(jobInfoHeader)
        jobInfoView.addSubview(jobInfoDivider)
        jobInfoView.addSubview(infoLabelStackView)
        view.addSubview(jobInfoView)
        
        // Update Status Section
        stage2UpdateButton = configureStatusUpdateButton(titleLabel: stages[2]!)
        stage3UpdateButton = configureStatusUpdateButton(titleLabel: stages[3]!)
        stage4UpdateButton = configureStatusUpdateButton(titleLabel: stages[4]!)
        stage5UpdateButton = configureStatusUpdateButton(titleLabel: stages[5]!)
        stage6UpdateButton = configureStatusUpdateButton(titleLabel: stages[6]!)
        stage7UpdateButton = configureStatusUpdateButton(titleLabel: stages[7]!)
        stage8UpdateButton = configureStatusUpdateButton(titleLabel: stages[8]!)
        stage9UpdateButton = configureStatusUpdateButton(titleLabel: stages[9]!)
        buttonStackView = configureStackView(arrangedSubViews:[
            stage2UpdateButton,
            stage3UpdateButton,
            stage4UpdateButton,
            stage5UpdateButton,
            stage6UpdateButton,
            stage7UpdateButton,
            stage8UpdateButton,
            stage9UpdateButton
            ])
        
        updateStatusView.addSubview(updateStatusHeader)
        updateStatusView.addSubview(updateStatusDivider)
        updateStatusView.addSubview(buttonStackView)
        view.addSubview(updateStatusView)
        
        view.backgroundColor = .white
    }
    
    func setUpAutoLayout(){
        let borderConstant: CGFloat = 10
        
        // Job Information Section
        jobInfoView.topAnchor.constraint(equalTo: view.topAnchor, constant: borderConstant).isActive = true
        jobInfoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -borderConstant).isActive = true
        jobInfoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: borderConstant).isActive = true
        jobInfoView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        
        jobInfoHeader.topAnchor.constraint(equalTo: jobInfoView.topAnchor, constant: borderConstant/2).isActive = true
        jobInfoHeader.centerXAnchor.constraint(equalTo: jobInfoView.centerXAnchor).isActive = true
        
        jobInfoDivider.topAnchor.constraint(equalTo: jobInfoHeader.bottomAnchor, constant: borderConstant/2).isActive = true
        jobInfoDivider.rightAnchor.constraint(equalTo: jobInfoView.rightAnchor, constant: -borderConstant).isActive = true
        jobInfoDivider.leftAnchor.constraint(equalTo: jobInfoView.leftAnchor, constant: borderConstant).isActive = true
        jobInfoDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        infoLabelStackView.topAnchor.constraint(equalTo: jobInfoDivider.bottomAnchor, constant: borderConstant).isActive = true
        infoLabelStackView.rightAnchor.constraint(equalTo: jobInfoView.rightAnchor, constant: -borderConstant).isActive = true
        infoLabelStackView.leftAnchor.constraint(equalTo: jobInfoView.leftAnchor, constant: borderConstant).isActive = true
        infoLabelStackView.bottomAnchor.constraint(equalTo: jobInfoView.bottomAnchor, constant: -borderConstant).isActive = true
  
/*
        customerNameLabel.topAnchor.constraint(equalTo: jobInfoDivider.bottomAnchor, constant: borderConstant).isActive = true
        customerNameLabel.leftAnchor.constraint(equalTo: jobInfoView.leftAnchor, constant: borderConstant).isActive = true
        
        customerDormLabel.topAnchor.constraint(equalTo: customerNameLabel.bottomAnchor, constant: borderConstant).isActive = true
        customerDormLabel.leftAnchor.constraint(equalTo: jobInfoView.leftAnchor, constant: borderConstant).isActive = true
        
        customerDormRoomLabel.topAnchor.constraint(equalTo: customerDormLabel.bottomAnchor, constant: borderConstant).isActive = true
        customerDormRoomLabel.leftAnchor.constraint(equalTo: jobInfoView.leftAnchor, constant: borderConstant).isActive = true
*/
        

        // Update Status Section
        updateStatusView.topAnchor.constraint(equalTo: jobInfoView.bottomAnchor, constant: borderConstant).isActive = true
        updateStatusView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -borderConstant).isActive = true
        updateStatusView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: borderConstant).isActive = true
        updateStatusView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -borderConstant).isActive = true
        
        updateStatusHeader.topAnchor.constraint(equalTo: updateStatusView.topAnchor, constant: borderConstant/2).isActive = true
        updateStatusHeader.centerXAnchor.constraint(equalTo: jobInfoView.centerXAnchor).isActive = true
        
        updateStatusDivider.topAnchor.constraint(equalTo: updateStatusHeader.bottomAnchor, constant: borderConstant/2).isActive = true
        updateStatusDivider.rightAnchor.constraint(equalTo: jobInfoView.rightAnchor, constant: -borderConstant).isActive = true
        updateStatusDivider.leftAnchor.constraint(equalTo: jobInfoView.leftAnchor, constant: borderConstant).isActive = true
        updateStatusDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true

        buttonStackView.topAnchor.constraint(equalTo: updateStatusDivider.bottomAnchor, constant: borderConstant).isActive = true
        buttonStackView.rightAnchor.constraint(equalTo: updateStatusView.rightAnchor, constant: -borderConstant).isActive = true
        buttonStackView.leftAnchor.constraint(equalTo: updateStatusView.leftAnchor, constant: borderConstant).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: updateStatusView.bottomAnchor, constant: -borderConstant).isActive = true
    }
    
    func configureStackView(arrangedSubViews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func configureStatusUpdateButton(titleLabel: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(titleLabel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        button.addTarget(self, action: #selector(stageUpdateAction), for: .touchUpInside)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        return button
    }
    
    func configureJobInfoLabel(keyLabel: String, valueLabel: String) -> UILabel {
        let label = UILabel()
        label.text = "\(keyLabel):  \(valueLabel)"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.backgroundColor = .clear
        //label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .default
        navigationItem.title = "Job Status"
    }
    
    // MARK: - Selectors
    
    @objc func stageUpdateAction() {
        jobRequest.currentStage += 1
        let jrf = JobRequestFirestore()
        jrf.updateOnWorkerUpdate(jobRequest: jobRequest)
    }
}