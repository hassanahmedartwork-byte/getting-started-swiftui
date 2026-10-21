import SwiftUI
import WatchKit

struct ContentView: View {
    @State private var count = 0
    // حفظ العداد حتى لو تم إغلاق التطبيق
    @AppStorage("savedCount") private var savedCount = 0 
    
    var body: some View {
        VStack(spacing: 12) {
            // 1. شريط علوي بتصميم آبل
            HStack {
                Image(systemName: "circle.hexagongrid.fill")
                    .foregroundStyle(.green)
                Text("التسبيح")
                    .font(.headline)
                    .foregroundStyle(.green)
                Spacer()
            }
            .padding(.horizontal)
            
            // 2. الزر الرئيسي (تصميم زجاجي دائري يشبه تطبيقات اللياقة)
            Button(action: {
                increment()
            }) {
                VStack {
                    Text("\(count)")
                        // خط آبل الدائري للأرقام
                        .font(.system(size: 55, weight: .semibold, design: .rounded)) 
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    
                    Text("اضغط للعد")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.green.opacity(0.15))
                )
            }
            .buttonStyle(.plain) // إزالة تصميم الزر الافتراضي
            .handGestureShortcut(.primaryAction) // تفعيل حركة ضم الإصبعين
            
            // 3. زر إعادة الضبط بتصميم بسيط
            Button(action: {
                count = 0
                savedCount = 0
            }) {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                    Text("تصفير")
                }
                .font(.footnote)
                .foregroundStyle(.red)
            }
            .buttonStyle(.plain)
            .padding(.bottom, 4)
        }
        .onAppear {
            // استرجاع الرقم المحفوظ عند فتح التطبيق
            count = savedCount
        }
    }
    
    func increment() {
        count += 1
        savedCount = count
        // اهتزاز خفيف مع كل عدة
        WKInterfaceDevice.current().play(.click)
    }
}
