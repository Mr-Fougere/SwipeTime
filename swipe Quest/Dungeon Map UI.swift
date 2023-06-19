import SwiftUI

struct DungeonMapView: View {
    @ObservedObject var donjonMap: DonjonMap
    @State private var playerImg: Image

    init(donjonMap: DonjonMap) {
        self.donjonMap = donjonMap
        _playerImg = State(initialValue: DungeonMapView.playerImage(donjonMap)) // initialise l'image du joueur
    }

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    ForEach(0..<10, id: \.self) { x in
                        VStack {
                            ForEach(0..<10, id: \.self) { y in
                                let cell = donjonMap.getCell(at: Coordinate(x: x, y: y))!
                                if donjonMap.path.contains(where: { $0.coordinate == cell.coordinate }) {
                                    ZStack {
                                        Image(cell.type.description).background(Color.red)
                                        if cell.coordinate == donjonMap.player.coordinate {
                                            playerImg
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        donjonMap.movePlayerUp()
                        self.donjonMap.objectWillChange.send()
                        self.updatePlayerImage()
                    }) {
                        Text("Up")
                    }
                    .padding(.bottom, 10)
                    Button(action: {
                        donjonMap.movePlayerLeft()
                        self.donjonMap.objectWillChange.send()
                        self.updatePlayerImage()
                    }) {
                        Text("Left")
                    }
                    .padding(.trailing, 10)
                    Button(action: {
                        donjonMap.movePlayerRight()
                        self.donjonMap.objectWillChange.send()
                        self.updatePlayerImage()
                    }) {
                        Text("Right")
                    }
                    .padding(.leading, 10)
                }
                .padding(.vertical, 10)
                Button(action: {
                    donjonMap.movePlayerDown()
                    self.donjonMap.objectWillChange.send()
                    self.updatePlayerImage()
                }) {
                    Text("Down")
                }
                .padding(.top, 10)
            }
        }
    }

    private static func playerImage(_ donjonMap: DonjonMap) -> Image {
        if let cell = donjonMap.getCell(at: donjonMap.player.coordinate),
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
