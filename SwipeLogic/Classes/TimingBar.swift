
import Combine
import Foundation

enum TimingResult:String {
    case perfect
    case great
    case good
    case miss
    case none
}


class TimingBar {
    let perfectTiming: Int
    let greatTiming: Int
    let goodTiming: Int
    @Published var combo: Int
    @Published var lastTiming: TimingResult
    @Published var actions: [Action]
    
    
    init(perfectTiming: Int, greatTiming: Int, goodTiming: Int, combo: Int) {
        self.perfectTiming = perfectTiming
        self.greatTiming = greatTiming
        self.goodTiming = goodTiming
        self.combo = combo
        self.actions = []
        self.lastTiming = .none
    }
    
    func removeResolvedActions(){
        let actionsToRemove = actions.filter { $0.inProcess }
        if actionsToRemove.count > 0 {
            self.lastTiming = actions.first!.result
            self.actions.removeAll { $0.inProcess }
        }
    }
    
    func getTimingResult(time: Int) -> TimingResult {
        if time <= self.perfectTiming {
            return .perfect
        } else if time <= self.greatTiming {
            return .great
        } else if time <= self.goodTiming {
            return .good
        } else {
            return .miss
        }
    }
}

class Action: ObservableObject, Hashable {
    @Published var timing: Int
    @Published var swipeEffect: SwipeEffect?
    @Published var result: TimingResult
    var isUser: Bool
    var bindingKey: String
    var inProcess : Bool
    
    init(timing: Int, swipeEffect: SwipeEffect?, owner: Character, bindingKey: String) {
        self.timing = timing
        self.swipeEffect = swipeEffect
        self.isUser = type(of: owner) == type(of: Basics().basicHero())
        self.bindingKey = bindingKey
        self.result = .none
        self.inProcess = false
        startTimer()
    }
    
    static func == (lhs: Action, rhs: Action) -> Bool {
        return lhs.timing == rhs.timing && lhs.swipeEffect == rhs.swipeEffect && lhs.bindingKey == rhs.bindingKey
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    private var timer: Timer?
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            if self.inProcess { timer.invalidate()}
            if self.isUser && self.result != .none{
                timer.invalidate()
            }
            self.timing -= 1
            
            if self.timing <= 0 {
                timer.invalidate()
                if !self.isUser {
                    DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
                                    guard let self = self else { return }
                                    EffectApplier(action: self).perform()
                                }
                }
                
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
