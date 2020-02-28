//
//  DateRow.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/27.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct DateRow: View {
    
    let tweet: DateTweet
    let isIncoming: Bool
    let isLast: Bool
    
    let store: TweetStore
    
    private var chatBubble: some View {
        RoundedRectangle(cornerRadius: 6)
            .foregroundColor(isIncoming ? .white : .accentColor)
            .shadow(color: .shadow, radius: 2, x: 0, y: 1)
    }
    
    private var date: some View {
        VStack {
            Image("calendar")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            Text(tweet.text)
        }
        .padding(10)
        .foregroundColor(isIncoming ? .body : .white)
        .modifier(BodyText())
        .background(chatBubble)
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            if isIncoming {
                if isLast {
                    RoleView(icon: tweet.role.icon)
                    chatBubbleTriange(width: 15, height: 14, isIncoming: true)
                } else {
                    Spacer().frame(width: 61)
                }
                
                date
                
                Spacer()
            } else {
                
                Spacer()
                
                date
                
                if isLast {
                    chatBubbleTriange(width: 15, height: 14, isIncoming: false)
                    RoleView(icon: tweet.role.icon)
                } else {
                    Spacer().frame(width: 61)
                }
            }
        }
        .onTapGesture(perform: tapEvent)
    }
    
    private func tapEvent() {
        pickDate { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: date)
            self.store.send(dateString)
        }
    }
    
    private func chatBubbleTriange(width: CGFloat, height: CGFloat, isIncoming: Bool) -> some View {
        Path { path in
            path.move(to: CGPoint(x: isIncoming ? 0 : width, y: height * 0.5))
            path.addLine(to: CGPoint(x: isIncoming ? width : 0, y: height))
            path.addLine(to: CGPoint(x: isIncoming ? width : 0, y: 0))
            path.closeSubpath()
        }
        .fill(isIncoming ? Color.white : Color.accentColor)
        .frame(width: width, height: height)
        .shadow(color: .shadow, radius: 2, x: 0, y: 1)
        .zIndex(10)
        .clipped()
        .padding(.trailing, isIncoming ? -1 : 10)
        .padding(.leading, isIncoming ? 10: -1)
        .padding(.bottom, 12)
    }
    
    private func pickDate(action: @escaping (Date) -> Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addDatePicker(mode: .date, date: Date(), action: action)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        showAlert(alert: alert)
    }
    
    private func showAlert(alert: UIAlertController) {
        if let controller = topMostViewController() {
            controller.present(alert, animated: true)
        }
    }
    
    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .compactMap {$0 as? UIWindowScene}
            .first?.windows.filter {$0.isKeyWindow}.first
    }
    
    private func topMostViewController() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
        }
        return topMostViewController(for: rootController)
    }
    
    private func topMostViewController(for controller: UIViewController) -> UIViewController {
        if let presentedController = controller.presentedViewController {
            return topMostViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return topMostViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return topMostViewController(for: topController)
        }
        return controller
    }
    
}

class DatePickerViewController: UIViewController {
    
    public typealias Action = (Date) -> Void
    
    private var selectedDate = Date()
    
    deinit {
        action?(selectedDate)
    }
    
    private var action: Action?
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.addTarget(self, action: #selector(handleDateChanged), for: .valueChanged)
        return picker
    }()
    
    init(mode: UIDatePicker.Mode, date: Date? = nil, minimumDate: Date? = nil, maxmumDate: Date? = nil, action: @escaping Action) {
        super.init(nibName: nil, bundle: nil)
        
        datePicker.datePickerMode = mode
        datePicker.date = date ?? Date()
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maxmumDate
        self.action = action
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = datePicker
    }
    
    @objc func handleDateChanged() {
        selectedDate = datePicker.date
    }
    
}

extension UIAlertController {
    
    func addDatePicker(mode: UIDatePicker.Mode, date: Date?, minimumDate: Date? = nil, maxmumDate: Date? = nil, action: @escaping DatePickerViewController.Action) {
        let datePicker = DatePickerViewController(mode: mode, date: date, minimumDate: minimumDate, maxmumDate: maxmumDate, action: action)
        set(content: datePicker, height: 217)
    }
    
    func set(content: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let contentVC = content else {
            return
        }
        
        setValue(contentVC, forKey: "contentViewController")
        
        if let height = height {
            contentVC.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
    
}
