import SwiftUI
import CoreData

// PieSlice Shape: 각 섹터를 그리는 Shape
struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius: CGFloat = min(rect.width, rect.height) / 2
        let innerRadius: CGFloat = radius * 0.6

        var path = Path()
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle - Angle(degrees: 90),
                    endAngle: endAngle - Angle(degrees: 90),
                    clockwise: false)

        let adjustedEnd = endAngle - Angle(degrees: 90)
        let x2 = center.x + innerRadius * CGFloat(cos(adjustedEnd.radians))
        let y2 = center.y + innerRadius * CGFloat(sin(adjustedEnd.radians))
        path.addLine(to: CGPoint(x: x2, y: y2))

        path.addArc(center: center,
                    radius: innerRadius,
                    startAngle: adjustedEnd,
                    endAngle: startAngle - Angle(degrees: 90),
                    clockwise: true)
        path.closeSubpath()
        return path
    }
}

// DonutChartView: PieSlice들을 조합해서 도넛 차트 그리기
struct DonutChartView: View {
    let data: [(String, Double)]
    let colors: [Color] = [.blue, .orange, .green, .purple, .pink, .yellow, .red]

    private var total: Double {
        data.map { $0.1 }.reduce(0, +)
    }

    private var slices: [(start: Double, end: Double, color: Color)] {
        var result: [(Double, Double, Color)] = []
        var currentStart: Double = 0
        for (i, element) in data.enumerated() {
            let fraction = element.1 / total
            let end = currentStart + fraction
            result.append((currentStart, end, colors[i % colors.count]))
            currentStart = end
        }
        return result
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<slices.count, id: \.self) { i in
                    let slice = slices[i]
                    PieSlice(
                        startAngle: .degrees(slice.start * 360),
                        endAngle:   .degrees(slice.end   * 360)
                    )
                    .fill(slice.color)
                }
                VStack {
                    Text("총 지출")
                        .font(.caption)
                    Text("\(Int(total))원")
                        .font(.headline)
                        .bold()
                }
            }
            .frame(width: geo.size.width, height: geo.size.width)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Expense.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)]
    ) private var expenses: FetchedResults<Expense>

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 이번 달 필터링
                    let calendar = Calendar.current
                    let now = Date()
                    let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
                    let nextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
                    let monthExpenses = expenses.filter {
                        guard let d = $0.date else { return false }
                        return d >= startOfMonth && d < nextMonth
                    }

                    // 카테고리별 합계 계산
                    let categorySums = Dictionary(
                        grouping: monthExpenses,
                        by: { $0.category ?? "기타" }
                    ).mapValues { list in
                        list.reduce(0) { $0 + $1.amount }
                    }
                    let sortedData = categorySums.sorted { $0.key < $1.key }

                    // 도넛 차트
                    DonutChartView(data: sortedData)

                    // 카테고리별 리스트 + 상세 화면 네비게이션
                    ForEach(sortedData, id: \.0) { category, sum in
                        NavigationLink(destination:
                            CategoryDetailView(
                                category: category,
                                expenses: monthExpenses.filter { $0.category == category }
                            )
                        ) {
                            HStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 10, height: 10)
                                Text(category)
                                Spacer()
                                let percent = sum / categorySums.values.reduce(0, +) * 100
                                Text("\(Int(sum))원 (\(Int(percent))%)")
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("SomeSum")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddExpenseView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
