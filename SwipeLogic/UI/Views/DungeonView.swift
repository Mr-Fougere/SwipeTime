import SwiftUI

struct DungeonMapView: View{
    @ObservedObject var donjonMap: DungeonMap
    @State private var playerImg: Image

    init(donjonMap: DungeonMap) {
        self.donjonMap = donjonMap
        _playerImg = State(initialValue: DungeonMapView.playerImage(donjonMap)) // initialise l'image du joueur
    }
    
    var swipePad: SwipePad {
        let swipeRight:SwipeAction = SwipeAction(type: .other, image: "right", text: "right", action: { _ in donjonMap.movePlayerRight();
                                                    self.donjonMap.objectWillChange.send();
                                                    self.updatePlayerImage()})
        let swipeLeft:SwipeAction = SwipeAction(type: .other, image: "left", text: "left", action: { _ in donjonMap.movePlayerLeft();
                                                    self.donjonMap.objectWillChange.send();
                                                    self.updatePlayerImage()})
        let swipeUp:SwipeAction = SwipeAction(type: .other, image: "up", text: "up", action: { _ in donjonMap.movePlayerUp();
                                                    self.donjonMap.objectWillChange.send();
                                                    self.updatePlayerImage()})
        let swipeDown:SwipeAction = SwipeAction(type: .other, image: "down", text: "down", action: { _ in donjonMap.movePlayerDown();
                                                    self.donjonMap.objectWillChange.send();
                                                    self.updatePlayerImage()})
        return SwipePad(rightAction: swipeRight, leftAction: swipeLeft, upAction: swipeUp, downAction: swipeDown)
    }

    var body: some View {
        ZStack {
                    Image("fireKingdom 1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)

                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            ForEach((0..<10).reversed(), id: \.self) { y in
                                HStack(spacing: 0) {
                                    ForEach(0..<10, id: \.self) { x in
                                        let cell = donjonMap.getCell(at: Coordinate(x: x, y: y))!
                                        if donjonMap.path.contains(where: { $0.coordinate == cell.coordinate }) {
                                            ZStack {
                                                Image(cell.type.description)
                                                if cell.coordinate == donjonMap.hero.coordinate {
                                                    playerImg
                                                }
                                            }
                                        } else {
                                            ZStack {
                                                Image("nocell")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.top) // Adjust the top padding as needed

                        SwiperView(swipePad: swipePad)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                            .padding(.bottom, 40) // Adjust the bottom padding as needed
                    }
                }
                .onAppear {
                    updatePlayerImage()
                }
    }
    private static func playerImage(_ donjonMap: DungeonMap) -> Image {
        if let cell = donjonMap.getCell(at: donjonMap.hero.coordinate),
           donjonMap.path.contains(where: { $0.coordinate == cell.coordinate }) {
            return Image("joueur")
        } else {
            return Image("autreImage") // Remplacez ceci par le code de création d'image approprié pour d'autres cas
        }
    }
    
    private func updatePlayerImage() {
        self.playerImg = Self.playerImage(self.donjonMap)
    }
}
