import SwiftUI
import WatchKit

struct ContentView: View {
    @State private var count = 0
    @State private var selectedTasbeeh = 0
    // حفظ العداد حتى لو قفلت الساعة
    @AppStorage("savedCount") private var savedCount = 0 
    
    let tasbeehList = ["سبحان الله", "الحمد لله", "لا إله إلا الله", "الله أكبر", "أستغفر الله"]
    
    var body: some View {
        VStack(spacing: 8) {
            // 1. عجلة التسبيح (تعمل بالتاج الرقمي)
            Picker("", selection: $selectedTasbeeh) {
                ForEach(0..<tasbeehList.count, id: \.self) { index in
                    Text(tasbeehList[index])
                        .font(.headline)
                        .foregroundStyle(.green)
                        .tag(index)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 55) // حجم مناسب أعلى الشاشة
            
            // 2. زر العداد (تصميم آبل الزجاجي)
            Button(action: {
                count += 1
                savedCount = count
                // اهتزاز مع كل عدة
                WKInterfaceDevice.current().play(.click)
            }) {
                Text("\(count)")
                    .font(.system(size: 50, weight: .bold, design: .rounded)) // خط الأرقام الرسمي
                    .minimumScaleFactor(0.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.green.opacity(0.2)) // خلفية زجاجية شفافة
                    )
            }
            .buttonStyle(.plain)
            // ربط الزر بحركة ضم الإصبعين
            .handGestureShortcut(.primaryAction) 
            
            // 3. زر التصفير
            Button(action: {
                count = 0
                savedCount = 0
            }) {
                Text("تصفير")
                    .font(.footnote)
                    .foregroundStyle(.red)
            }
            .buttonStyle(.plain)
        }
        .onAppear {
            count = savedCount // استرجاع الرقم القديم عند الفتح
        }
    }
}
