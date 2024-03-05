import SwiftUI

struct ContentView: View {
    @State var shouldAnimate: Bool = false

    var body: some View {
        AnimatedButton()
    }
}

extension ContentView {
    @ViewBuilder
    private func AnimatedButton() -> some View {
        Button {
            withAnimation(AnimationFactory.bouncy()) {
                shouldAnimate.toggle()
            } completion: {
                withAnimation(AnimationFactory.linear()) {
                    shouldAnimate.toggle()
                }
            }
        } label: {
            ButtonContent()
        }
        .buttonStyle(ButtonAccentColorStyle())
    }

    @ViewBuilder
    private func ButtonContent() -> some View {
        HStack(spacing: -4) {
            Image(systemName: "play.fill")
                .scaleEffect(
                    shouldAnimate ? 1 : 0,
                    anchor: .trailing
                )
                .opacity(shouldAnimate ? 1 : 0)

            Image(systemName: "play.fill")

            Image(systemName: "play.fill")
                .scaleEffect(
                    shouldAnimate ? 0 : 1,
                    anchor: .leading
                )
                .opacity(shouldAnimate ? 0 : 1)
        }
        .font(.title)
        .offset(x: shouldAnimate ? 10 : -10)
    }
}

private class AnimationFactory {
    static func bouncy() -> Animation {
        .bouncy(duration: 0.4, extraBounce: 0.2)
    }

    static func linear() -> Animation {
        .linear(duration: 0.01)
    }
}

private struct ButtonAccentColorStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.accentColor)
    }
}


#Preview {
    ContentView()
}
