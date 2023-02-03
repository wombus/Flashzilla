import SwiftUI

struct CardView: View {
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    let card: Card
    
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius: 10)
            
            VStack {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
                }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture (
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}