class SwipePad {
    
    let rightAction: SwipeAction
    let leftAction: SwipeAction
    let topAction: SwipeAction
    let bottomAction: SwipeAction
    
    init(rightAction: SwipeAction, leftAction: SwipeAction, topAction: SwipeAction, bottomAction: SwipeAction) {
        self.rightAction = rightAction
        self.leftAction = leftAction
        self.topAction = topAction
        self.bottomAction = bottomAction
    }
    
}