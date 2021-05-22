import SwiftUI

public struct CountButton: View {
    let type: Type
    let action: () -> Void

    public enum `Type` {
        case up
        case down

        public var imageName: String {
            switch self {
            case .up:
                return "plus"
            case .down:
                return "minus"
            }
        }
    }

    public init(type: Type, action: @escaping () -> Void) {
        self.type = type
        self.action = action
    }

    public var body: some View {
        Button(
            action: action,
            label: {
                Image(systemName: type.imageName)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundColor(.white)
                    .padding(.all, 8)
                    .frame(width: 24, height: 24)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
        )
    }
}

public struct SwiftUIView_Previews: PreviewProvider {
    public static var previews: some View {
        CountButton(
            type: .up,
            action: {}
        )
    }
}
