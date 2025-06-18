import SwiftUI
import CoreData

struct CategoryDetailView: View {
    let category: String
    let expenses: [Expense]

    private static let dateFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateStyle = .medium
        fmt.timeStyle = .short
        return fmt
    }()

    var body: some View {
        List {
            ForEach(expenses) { expense in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("\(expense.amount, specifier: "%.2f")원")
                            .font(.headline)
                        Spacer()
                        if let date = expense.date {
                            Text(Self.dateFormatter.string(from: date))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    if let note = expense.note, !note.isEmpty {
                        Text(note)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("\(category) 상세")
    }
}
