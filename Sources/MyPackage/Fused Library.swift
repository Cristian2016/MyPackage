//
//  Library.swift
//  BubblesSwiftUI
//
//  Created by Cristian Lapusan on 13.04.2022.
//

#if !os(macOS)
import UIKit
#endif
import SwiftUI

public struct UI {
    ///BubbleCell
    struct bCell {
        static let circleSpacingRatio = -CGFloat(0.11)
    }
}

public extension Array {
    func twoDArray(_ rows/* count */: Int) -> [[Element]] {
        var finalResult = [[Element]]()
        var subarray = [Element]()
        
        for (index, element) in enumerated() {
            subarray.append(element)
            
            if index%rows == rows - 1 {
                finalResult.append(subarray)
                subarray = [] //new cardboard
            }
            
            //append whatever leftover non-empty subarray
            if index == count - 1 && !subarray.isEmpty {
                finalResult.append(subarray)
            }
        }
        return finalResult
    }
}

public extension DispatchTime {
    ///0.8 sec
    static var confirmation:DispatchTime { DispatchTime.now() + 0.7 }
}

public extension UIScreen {
    static let deviceNotTallEnough = UIScreen.main.bounds.height <= 667
}

public extension Date {
    func sameDay(with date:Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        if calendar.component(.day, from: self) == calendar.component(.day, from: date) {
            return true
        }
        return false
    }
}

public enum Visibility:CaseIterable {
    case visible
    case invisible //hidden. still part of VH
}

@available(iOS 13.0, *)
public extension View {
    @ViewBuilder
    func visibility(_ visibility:Visibility) -> some View {
        switch visibility {
            case .visible: self
            case .invisible: self.hidden()
        }
    }
}

public extension Array {
    func shifted(by amount:Int) -> Array {
        
        if amount < 0 { fatalError("can't be negative. only zero or greater") }
        if amount == 0 { return self }
    
       let shiftedIndices = indices.map { index in
           (index + amount)%self.indices.count
        }
        
        var shiftedArray = [Element]()
        
        shiftedIndices.forEach { shiftedArray.append(self[$0]) }
        
        return shiftedArray
    }
}

@available(iOS 14.0, *)
public extension Text {
    func square(_ value:Int) -> some View {
        Text("\(Image(systemName: "\(value).square.fill"))")
    }
}

@available(iOS 13.0, *)
public extension Color {
    static let infoButton = Color("infoButton")
    static let selectionGray = Color("selectionGray")
    static let label = Color("label")
    static let detailViewBackground = Color("detailViewBackground")
    static let lightGray = Color("lightGray")
    static let calendar = Color("calendar")
    static let calendarOff = Color("calendarOff")
    static let background1 = Color("background1")
    static let ultraLightGray = Color("ultraLightGray")
    static let gesture = Color("gesture")
    
    
    static let alertScreenBackground = Color("alertScreenBackground")
    
    ///unlike Color.clear, Color.transparent allows gestures to be intercepted
    static let transparent = Color.white.opacity(0.001)
    
    
    static let colorNames = ["sourCherry":"Sour Cherry",
                             "mint" : "Mint",
                             "slateBlue" : "Slate Blue",
                             "silver" : "Silver",
                             "ultramarine" : "Ultramarine",
                             "lemon" : "Lemon",
                             "red" : "Red",
                             "sky" : "Sky",
                             "bubbleGum" : "Bubble Gum",
                             "green" : "Green",
                             "charcoal" : "Charcoal",
                             "magenta" : "Magenta",
                             "purple" : "Purple",
                             "orange" : "Orange",
                             "chocolate" : "Chocolate",
                             "aqua" : "Aqua",
                             "byzantium" : "Byzantium",
                             "rose" : "Rose",
                             "aubergine" : "Aubergine",
                             "cayenne" : "Cayenne",
                             "mocha" : "Mocha"
    ]
    
    static func userFriendlyBubbleColorName(for bubbleColorName:String?) -> String {
        guard
            let bubbleColorName = bubbleColorName,
            let colorName = colorNames[bubbleColorName]
        else { fatalError() }
        
        return colorName
    }
}

@available(iOS 13.0, *)
public extension Image {
    static let trash = Image(systemName: "trash")
    static let pauseSticker = Image("pauseSticker")
    static let spotlight = Image("spotlight")
    static let eyeSlash = Image(systemName: "eye.slash.fill")
    
    static let checkmark = Image(systemName: "checkmark")
    static let info = Image(systemName: "info.circle.fill")
    static let remove = Image(systemName: "xmark.circle.fill")
    static let delete = Image(systemName: "delete.left.fill")
    static let swipeLeft = Image(systemName: "arrow.backward.circle.fill")
    static let tapAndHold = Image(systemName: "smallcircle.filled.circle")
    static let tap = Image(systemName: "circle.fill")
    static let startDelay = Image(systemName: "clock.arrow.circlepath")
    static let save = Image(systemName: "square.and.arrow.down")
    static let calendar = Image(systemName: "calendar")
    
    static let digits = Image("digits")
}

public func delayExecution(_ delay:DispatchTime, code:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: delay, execute: code)
}

public extension NSNotification.Name {
    static let bubbleTimerSignal = NSNotification.Name("bubbleTimerSignal")
    
    ///each Bubble has a corresponding StartDelayBubble [SDB]
    ///and each SDB has a corresponding SDBTimer optional. not set by default
    static let sdbEnded = NSNotification.Name("sdbDelayreachedZero")
    
    static let appLaunched = NSNotification.Name("appLaunched")
    static let bubbleRank =  NSNotification.Name("bubbleIDNotification")
    static let topCellTapped = NSNotification.Name("topCellTapped")
    
    static let deleteBubbleRequest = NSNotification.Name("deleteBubbleRequest")
    static let resetBubbleRequest = NSNotification.Name("resetBubbleRequest")
    static let selectedTab = NSNotification.Name("selectedTab")
    
    static let textLimitExceeded = NSNotification.Name("textLimitExceeded")
}

public extension Float {
    ///ex: decimalPlaces 2: 1.89099 -> "1.89"
    func shortString(by decimalPlaces:Int) -> String {
        String(format: "%.\(decimalPlaces)f", self)
    }
}

public extension Double {
    ///ex: decimalPlaces 2: 1.89099 -> "1.89"
    func shortString(by decimalPlaces:Int) -> String {
        String(format: "%.\(decimalPlaces)f", self)
    }
}

public struct Ratio {
    //BubbleCell
    ///screen width to bubble width |<-|<------->|->|
    static let screenToBubbleWidth = CGFloat(0.924)
    static var bubbleToFontSize:CGFloat = { (screenToBubbleWidth / 3) * 0.55 }()
    static var bubbleComponentSpacerLength:CGFloat = { CGFloat(UIScreen.size.width * 0.309) }()
    
    //
}

public extension UIScreen {
    static let size = UIScreen.main.bounds.size
}

public extension NumberFormatter {
    //truncates Float and returns a string
    static func bubblesStyle(_ float:Float, fractionDigits:Int = 0) -> String {
        let formatter = NumberFormatter()
        formatter.locale = .current
        //formatter.numberStyle = .ordinal //5th, 1st etc
        formatter.maximumFractionDigits = fractionDigits
        
        guard let string = formatter.string(from: NSNumber(value: float))
        else { fatalError() }
        return string
    }
}

public extension String {
    static let smallestEmojiValue = 127744
    static let emptySpaceValue = 32
    
    
    ///if user enters "Gym ", it will be corrected to "Gym"
    mutating func trimWhiteSpaceAtTheEnd() {
        while last == " " { removeLast() }
    }
    mutating func trimWhiteSpaceAtTheBeginning() {
        while first == " " { removeFirst() }
    }
    
    mutating func removeWhiteSpaceAtBothEnds() {
        trimWhiteSpaceAtTheBeginning()
        trimWhiteSpaceAtTheEnd()
    }
    
    ///empty string: ""
    static let empty = ""
    
    static let space = " "
    
    var containsEmoji:Bool {
        var result = false
        
    loop: for scalar in unicodeScalars {
        if scalar.properties.isEmoji {
            result = true
            break loop
        }
    }
        return result
    }
    
    //ex: "      "
    var isAllEmptySpace:Bool {
        var copy = self
        while copy.first == " " { copy.removeFirst() }
        return copy.isEmpty
    }
}

public extension UserDefaults {
    struct Key {
        ///bubble rank
        public static let  /* bubble */ rank =  /* bubble */ "rank"
        
        public static let localNotificationsAuthorizationRequestedAlready = "localNotificationsAuthorizationRequestedAlready"
        public static let calendarAccessGranted = "calendarAccessGranted"
        public static let defaultCalendarID = "defaultCalendarIdentifier"
        
        public static let notificationReceivalMoment = "notificationReceivalMoment"
        public static let infoBannerNotShownAlready = "infoBannerNotShownAlready"
        
        public static let widgetEnabledTimeBubble = "widgetEnabledTimeBubble"
        public static let shouldExplainingTextBeVisible = "shouldExplainingTextBeVisible"
        
        public static let firstAppLaunchEver = "firstAppLaunchEver"
    }
    
    static let shared = UserDefaults(suiteName: "group.com.Timers.container")!
}

public struct UserFeedback {
    public enum Kind {
        case haptic
        case sound
        case visual
    }
    
    public static func singleHaptic(_ style:UIImpactFeedbackGenerator.FeedbackStyle) {
        let haptic = UIImpactFeedbackGenerator(style: style)
        haptic.prepare()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            haptic.impactOccurred()
        }
    }
    
    public static func doubleHaptic(_ style:UIImpactFeedbackGenerator.FeedbackStyle) {
        UserFeedback.singleHaptic(style)
        
        let second = UIImpactFeedbackGenerator(style: .heavy)
        second.prepare()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            second.impactOccurred()
        }
    }
}

public extension NumberFormatter {
    static let bubbleStyle:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "us_US")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.maximumIntegerDigits = 0
        return formatter
    }()
}

public extension Float {
    var hundredthsFromCurrentClock:String {
        var string = NumberFormatter.bubbleStyle.string(from: NSNumber(value: self))!
        string.removeFirst()
        return string
    }
}

public extension DateComponentsFormatter {
    static let bubbleStyle:DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
//        formatter.collapsesLargestUnit = true
        return formatter
    }()
}

public extension DateFormatter {
    ///Time Bubbles date style: Tue, 15 Feb. 22
    static let date: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "us_US")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "E, d MMM. yy"
        
        return dateFormatter
    }()
    
    static let shortDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "us_US")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "E d"
        
        return dateFormatter
    }()
    
    ///Time Bubbles time style: 17:39:25
    static let time: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeStyle = .medium
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        
        return dateFormatter
    }()
}

@available(iOS 13.0, *)
public extension Animation {
    static let secondsTapped = Animation.spring(response: 0.3, dampingFraction: 0.4)
    static let secondsLongPressed = Animation.spring(response: 0.2, dampingFraction: 0.6)
}
