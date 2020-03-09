//
//  RefundController.swift
//  App
//
//  Created by Tian Tong on 3/9/20.
//

import Vapor

class RefundController {
    
    let welcome =
    """
        欢迎进入机票服务，以下业务可提供自助办理：

        1. 机票改签
        2. 机票退票
        3. 机票行程单寄送

        回复对应序列号即可办理，如需人工服务，请回复人工。
        """
    
    let bookedFlights = [
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "14:35", arrTime: "16:10", flightDate: "2020-03-11", flightNo: "MU5515"),
        Flight(depCity: "青岛流亭", arrCity: "上海虹桥", depTime: "14:50", arrTime: "16:40", flightDate: "2020-03-15", flightNo: "MU5520")
    ]
    let bookedMessgae = "经查询您有以上未出行航班，请选择需要改签的，或回复航班号"
    
    var availableFlights = [
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "14:35", arrTime: "16:10", flightDate: "2020-03-02", flightNo: "MU5515"),
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "18:00", arrTime: "19:35", flightDate: "2020-03-02", flightNo: "MU5517"),
        Flight(depCity: "上海虹桥", arrCity: "青岛流亭", depTime: "21:15", arrTime: "22:55", flightDate: "2020-03-02", flightNo: "MU5519")
    ]
    let availableMessage = "经查询有以上航班可供改签，请选择，或回复航班号"
    
    private var isOptionChecked = true
    private var isUserInfoChecked = true
    private var isBankCardChecked = false
    private var isRefundInfoChecked = false
    private var isNewFlightChecked = false
    private var isCompleted = false
    
    private var isManualModel = false
    
    func handleRefund(req: Request, ws: WebSocket) {
//        ws.send(welcome)
        let userInfo =
        """
        旅客信息：
        姓名：胡歌  票号：781-123456789
        航班号：MU5111   联系方式：13912345678
        起飞：上海虹桥   到达：北京首都
        """
        ws.send(userInfo)
        
        let chatHistory =
        """
        IVR意图：不正常航班退票
        IVR聊天记录：
        ---------------------------------------
        AI：您好，我是小东，有什么能帮您的？
        旅客：我的航班延误了，我要退票
        AI：已识别您为不正常航班退票，您还未绑定银行卡，我们会发送短信给你，你可以在在线客服完成绑卡并退票。
        """
  
        ws.send(chatHistory)
        ws.send("系统检测到您还未绑定银行卡，请输入您要接受退款的银行卡号")
        
        ws.onText { _, text in
            print("USER INPUT: \(text)")
            
            if self.isManualModel {
                if text == "Bot" {
                    self.isManualModel = false
                    self.reset()
                    ws.send(self.welcome)
                    return
                }
                
                guard let text = readLine() else {
                    return
                }
                
                ws.send(text)
            } else {
                if text == "人工" {
                    self.isManualModel = true
                    ws.send("很高兴为您服务，请问有什么可以帮助您的？")
                    return
                }
                
                self.process(text, webSocket: ws)
            }
        }
        
        ws.onBinary { _, byte in
            guard
                let data = byte.getData(at: 0, length: 10),
                let info = String(data: data, encoding: .utf8),
                info == "I AM QUIT."
                else {
                    return
            }
            
            self.reset()
        }
    }
    
    func reset() {
        isOptionChecked = true
        isUserInfoChecked = true
        isBankCardChecked = false
        isRefundInfoChecked = false
        bankCard = ""
    }
    
    private func process(_ text: String, webSocket ws: WebSocket) {
        
        guard !isCompleted else {
            isCompleted = false
            ws.send(welcome)
            return
        }
        
        guard checkOption(text) else {
            ws.send("请输入需要办理的业务序列号，或回复人工")
            return
        }
        
        guard checkBankCard(text) else {
            ws.send("系统检测到您还未绑定银行卡，请输入您要接受退款的银行卡号")
            return
        }
        
        guard checkRefundInfo(text) else {
            let refundInfo =
            """
            请确认您的退票信息：
            航班日期：2020年3月15日
            航班号：MU5111
            客票号：781-123456789
            出发城市：上海虹桥
            到达城市：北京首都
            退款金额：¥ 789.0
            银行卡号：\(bankCard)
            银行名称：招商银行
            """
            ws.send(refundInfo)
            return
        }
        
        ws.send("""
                已为您退票成功，退款信息如下：
                银行卡号：\(bankCard)
                退款金额：¥ 789.0
                期待您再次乘坐东方航空！
                """)

        isCompleted = true
        reset()
    }
    
    private func checkOption(_ text: String) -> Bool {
        if isOptionChecked {
            return true
        } else {
            guard let number = Int(text) else {
                return false
            }
            
            switch number {
            case 1, 2, 3, 4:
                isOptionChecked = true
            default:
                return false
            }
        }
        
        return true
    }
    
    private func checkUserInfo(_ text: String) -> Bool {
        if isUserInfoChecked {
            return true
        } else {
            if text == "确认" || text == "确定" || text == "是的" || text == "是" {
                isUserInfoChecked = true
                return true
            }
        }
        return false
    }
    
    var bankCard = ""
    private func checkBankCard(_ text: String) -> Bool {
        if isBankCardChecked {
            return true
        } else {
            if text.count == 16 {
                bankCard = text
                isBankCardChecked = true
                return true
            }
        }
        return false
    }
    
    private func checkRefundInfo(_ text: String) -> Bool {
        if isRefundInfoChecked {
            return true
        } else {
            if text == "确认" || text == "确定" || text == "是" || text == "是的"{
                isRefundInfoChecked = true
                return true
            }
        }
        return false
    }
    
}
