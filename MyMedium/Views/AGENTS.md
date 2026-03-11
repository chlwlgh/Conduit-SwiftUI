# Views 모듈

> Last verified: 2026-03-11

## 역할
여러 화면에서 재사용되는 SwiftUI 컴포넌트 모음. 앱 전체의 일관된 UI를 제공한다.

## 파일 목록 (11 files)

### 공통 컴포넌트
| 파일 | 역할 |
|------|------|
| `AppButton.swift` | 커스텀 버튼. 텍스트, 아이콘, disabled 상태, 배경색 지원 |
| `AppInputBox.swift` | 커스텀 텍스트 입력 필드 |
| `AppNetworkImage.swift` | 네트워크 이미지 로딩. 플레이스홀더 포함 |
| `ChipView.swift` | 태그/칩 UI 컴포넌트 (태그 필터링에 사용) |
| `LoadingListing.swift` | 로딩 상태 리스트 (Shimmer 라이브러리 사용) |
| `LoginPlacHolder.swift` | 로그인 필요 시 표시하는 플레이스홀더 UI |
| `ProfileView.swift` | 프로필 정보 표시 컴포넌트 (아바타, 이름, 바이오) |

### ArticleViews/
| 파일 | 역할 |
|------|------|
| `ArticleRow.swift` | 아티클 리스트 행. 제목, 작성자, 날짜, 좋아요 수 표시 |
| `ArticleBodyView.swift` | 아티클 본문 렌더링. HTML 컨텐츠 처리 (SwiftSoup 사용) |
| `AboutAuthorView.swift` | 작성자 정보 카드. 프로필 이미지, 이름, 팔로우 버튼 |
| `CommentsView.swift` | 댓글 목록 표시 + 댓글 입력 UI |

## 사용 패턴
- 모든 컴포넌트는 SwiftUI `View` struct
- `@EnvironmentObject`로 ViewModel에 접근하여 데이터 표시 및 액션 처리
- `App` 접두어 컴포넌트: 앱 전체에서 일관된 스타일링을 제공하는 기본 UI 요소
- `ArticleViews/`: 아티클 관련 화면(FeedScreen, TrandingArticleScreen, ArticleDetailViewScreen)에서 공유
