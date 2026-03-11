# GlobalState 모듈

> Last verified: 2026-03-11

## 역할
앱 전역 상태 관리 계층. MVVM 아키텍처의 ViewModel에 해당한다. 모든 ViewModel은 `ObservableObject`를 상속하고 `@Published` 프로퍼티로 View에 반응형 업데이트를 제공한다.

**주의**: 파일명은 `*ViewModal.swift`이나 실제 class명은 `*ViewModel` — 파일명의 "Modal"은 오타, class명이 정본.

## 파일 목록 (7 files)

| 파일 | Class명 | 역할 | 호출하는 Service |
|------|---------|------|-----------------|
| `AppViewModel.swift` | `AppViewModel` | 앱 전역 상태: 로딩, 에러 메시지, AlertToast 알림 | 없음 (UI 상태만) |
| `AuthViewModal.swift` | `AuthViewModel` | 인증 상태 관리: 로그인, 프로필 로드, 사용자 아티클 | `AuthServices`, `ArticleServices` |
| `ArticleViewModal.swift` | `ArticleViewModel` | 아티클 CRUD: 목록 조회, 태그, 댓글, 북마크, 페이지네이션 | `ArticleServices`, `FavoritesServices`, `CommentsServices` |
| `FeedsArticleViewModal.swift` | `FeedArticleViewModel` | 개인 피드 아티클 목록 관리 | `ArticleServices` |
| `CommentsViewModal.swift` | `CommentsViewModel` | 댓글 CRUD: 조회, 작성, 삭제 | `CommentsServices` |
| `ProfileViewModal.swift` | `ProfileViewModel` | 프로필 조회, 팔로우/언팔로우 | `ProfileServices` |
| `NavigationStackViewModal.swift` | `FeedNavigationStackViewModal`, `TradingNavigationStackViewModal`, `ProfileNavigationStackViewModal` | 3개 탭의 NavigationStack 경로 상태 관리 | 없음 (NavigationPath만) |

## 패턴
- 모든 ViewModel은 `MyMediumApp.swift`에서 `@StateObject`로 생성, `.environmentObject()`로 주입
- View에서 `@EnvironmentObject var vm: XxxViewModel`으로 접근
- Service 호출은 closure 기반: `completion: @escaping (Result<T, NetworkError>) -> Void`
- 에러 발생 시 `AppViewModel.errorMessage`에 메시지 설정 → AlertToast로 표시
- **DI 패턴**: Service는 Protocol 기반 DI로 주입 (default parameter = production 구현체)

## Unit Tests (MyMediumTests/)
- **테스트 프레임워크**: XCTest, non-hosted test target (소스 직접 컴파일)
- **Mock 패턴**: `Mock{Service}` 클래스가 `{Service}Protocol`을 conform, `Result` 프로퍼티로 반환값 설정
- **Fixture**: `TestData.swift`에 RealWorld API spec 기반 테스트 데이터 (Article, User, Comment, Profile 등)
- **비동기 테스트**: `DispatchQueue.main.asyncAfter` + `XCTestExpectation` 패턴
- **테스트 수**: 24개 (AuthVM 4, ArticleVM 5, FeedArticleVM 3, CommentsVM 3, ProfileVM 3, AppVM 2, NavigationStackVM 4)
- **실행**: `xcodebuild test -project MyMedium.xcodeproj -scheme MyMedium -destination 'platform=iOS Simulator,...' -only-testing:MyMediumTests`
