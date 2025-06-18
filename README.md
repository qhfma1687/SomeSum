# SomeSum

AI 기반 개인 소비 분석 앱

1871012 구봉서

---

## 1. 프로젝트 수행 목적

### 1.1 프로젝트 정의

**SomeSum**은 사용자가 지출을 기록하고, 카테고리별 소비를 시각화하여 파악할 수 있도록 돕는 개인 소비 분석 앱입니다.

### 1.2 프로젝트 배경

현대인들은 다양한 방식으로 돈을 소비하지만, 그 금액이 작을수록 자신이 어떤 항목에 얼마를 썼는지 파악하기 어렵습니다. 
기존의 가계부 앱은 수동 입력과 복잡한 UI로 인해 꾸준한 사용이 어렵다는 한계가 있습니다. 
이에 간결한 UI와 직관적인 시각화를 통해 사용자 친화적인 소비 분석 도구를 제공하고자 합니다.

### 1.3 프로젝트 목표

* 지출 내역 기록 및 저장 
* 카테고리별 소비 내역 시각화 
* 월별 총 지출 자동 계산
* 소비 카테고리별 상세 내역 확인

---

## 2. 프로젝트 개요

### 2.1 프로젝트 설명

* 사용자는 지출 항목을 입력할 수 있으며, 카테고리는 선택 또는 추가로 지정 가능
* 홈 화면에서 이번 달 총 지출, 카테고리별 지출 합계, 상세 내역 확인 가능
* 도넛 차트를 통해 각 카테고리의 지출 비율을 시각적으로 표현
* 특정 카테고리를 탭하면 해당 카테고리의 세부 지출 내역을 보여주는 화면으로 이동

### 2.2 프로젝트 구조

```
SomeSum
├── HomeView.swift          # 메인 홈 화면 (차트, 카테고리별 목록, 내역)
├── AddExpenseView.swift    # 지출 추가 화면
├── CategoryDetailView.swift# 카테고리별 상세 지출 화면
├── Expense.swift           # CoreData 모델
├── DonutChartView.swift    # 도넛 차트 커스텀 뷰
└── Persistence.swift       # CoreData Stack
```

### 2.3 결과물

#### 메인 화면
![main](https://github.com/user-attachments/assets/3afdc72d-3688-471f-b618-ba93961198bd)

* 이번 달 총 지출, 카테고리별 지출 요약
* 도넛 차트를 통한 지출 시각화

#### 지출 추가 화면
![input1](https://github.com/user-attachments/assets/c2e2d24b-01ac-4cb6-b9c9-8b295b48dae1)
![input2](https://github.com/user-attachments/assets/16220a4f-c816-46f2-8b36-e754e9cb749a)



* 금액, 카테고리, 메모를 입력하여 새로운 지출 추가

#### 카테고리 상세 화면
![view](https://github.com/user-attachments/assets/75317b56-0430-48f3-ba43-90fdf37928ca)

* 선택한 카테고리에 대한 지출 내역을 목록으로 확인

---

## 2.4 기대효과

* 소비 내역을 손쉽게 기록하고, 한눈에 파악 가능
* 시각적 데이터를 통해 소비 습관 개선 가능
* 자산 관리에 대한 사용자 인식 개선 및 계획적 소비 유도

---

## 2.5 관련 기술

| 구분              | 설명                                                       |
| --------------- | -------------------------------------------------------- |
| **SwiftUI**     | Apple의 최신 UI 프레임워크로 직관적인 화면 구성 가능                        |
| **CoreData**    | 지출 정보를 로컬에 저장하고 불러오기 위한 데이터베이스 프레임워크                     |
| **Charts (대체)** | Swift Charts 모듈을 사용하지 못하는 환경에서도 SwiftUI 기반의 커스텀 도넛 차트 구현 |
| **MVVM 구조**     | 뷰와 로직의 분리를 통해 유지보수성과 확장성 향상                              |

---

## 2.6 개발 도구

| 도구       | 설명                  |
| -------- | ------------------- |
| Xcode    | iOS 앱 개발 및 시뮬레이션 도구 |
| SwiftUI  | UI 구성               |
| CoreData | 로컬 데이터 저장           |
| GitHub   | 버전 관리 및 배포 도구       |

---

## 2.7 시연영상

https://youtu.be/nDMtjJMCeeg












~~7Yuw64GM7J2AIOuqqOyVhOu0pOyekCDti7DrgYzsnbTsp4Drp4wsIOyTuCDrlYzripQg7YOc7IKw7J20IOuQnOuLpA==~~


