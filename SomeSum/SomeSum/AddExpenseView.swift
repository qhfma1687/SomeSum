import SwiftUI
import CoreData

struct AddExpenseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    @State private var category = ""
    @State private var amount = ""
    @State private var note = ""
    @State private var date = Date()

    // 미리보기용 기본 카테고리 (원하는 대로 수정)
    let categories = ["식비", "교통", "쇼핑", "엔터테인먼트", "기타"]

    var body: some View {
        Form {
            Section(header: Text("카테고리")) {
                Picker("카테고리", selection: $category) {
                    ForEach(categories, id: \.self) { cat in
                        Text(cat)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }

            Section(header: Text("금액")) {
                TextField("0.00", text: $amount)
                    .keyboardType(.decimalPad)
            }

            Section(header: Text("메모")) {
                TextField("메모를 입력하세요", text: $note)
            }

            Section(header: Text("날짜")) {
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
            }

            Button("저장") {
                saveExpense()
            }
            .disabled(!isInputValid)
        }
        .navigationTitle("지출 추가")
    }

    private var isInputValid: Bool {
        !category.isEmpty && Double(amount) != nil
    }

    private func saveExpense() {
        let newExpense = Expense(context: viewContext)
        newExpense.id = UUID()
        newExpense.category = category
        newExpense.amount = Double(amount) ?? 0
        newExpense.note = note
        newExpense.date = date

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()  // 저장 후 목록으로 복귀
        } catch {
            print("저장 오류: \(error.localizedDescription)")
        }
    }
}
