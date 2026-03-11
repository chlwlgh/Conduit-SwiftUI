# Networking 모듈

> Last verified: 2026-03-11

## 역할
REST API 통신 계층. 중앙 HTTP 클라이언트(`RestAPIClient`)와 5개 도메인별 Service/Endpoint 쌍으로 구성된다.

## 아키텍처
```
ViewModel
  → {Domain}Services.method()
    → RestAPIClient.request<T: Codable>(type:endPoint:method:parameters:completion:)
      → Alamofire.AF.request()
        → RealWorld API
```

## 파일 목록 (12 files)

### Core
| 파일 | 역할 |
|------|------|
| `RestAPIClient.swift` | 제네릭 HTTP 클라이언트. Alamofire 기반, Bearer 토큰 자동 주입(`@AppStorage`), `NetworkError` enum 정의 포함. **주의**: `costumeCompletion` 파라미터(custom 타이포), `"Done" as! T` 강제 캐스팅(204 응답) |
| `ApiError.swift` | 에러 핸들링. `ApiError` struct의 `handleError()` 메서드, `AppErrorRespons` 응답 모델 |

### AuthServers/
| 파일 | 역할 |
|------|------|
| `AuthApiEndpoint.swift` | 인증 API 엔드포인트 URL 빌더 (login, register, profile, editProfile) |
| `AuthServices.swift` | 인증 서비스: `userLogin()`, `createAccount()`, `getUser()`, `updateAccount()` |

### ArticleServers/
| 파일 | 역할 |
|------|------|
| `ArticleApiEndpoint.swift` | 아티클 API 엔드포인트 URL 빌더 |
| `ArticleServices.swift` | 아티클 서비스: `getTrendingArticle()`, `getSignalArticle()`, `getTags()`, `getFeedArticle()`, `uploadArticle()`, `updateArticle()`, `deleteArticle()` |

### CommentServers/
| 파일 | 역할 |
|------|------|
| `CommentsApiEndpoint.swift` | 댓글 API 엔드포인트 URL 빌더 |
| `CommentServers.swift` | 댓글 서비스: `getComments()`, `createComment()`, `deleteComment()` |

### FavoritesServers/
| 파일 | 역할 |
|------|------|
| `FavoritesApiEndPoint.swift` | 즐겨찾기 API 엔드포인트 URL 빌더 |
| `FavoritesServers.swift` | 즐겨찾기 서비스: `bookMarkArticle()`, `removeBookMarkArticle()` |

### ProfileServers/
| 파일 | 역할 |
|------|------|
| `ProfileApiEndpoint.swift` | 프로필 API 엔드포인트 URL 빌더 |
| `ProfileServers.swift` | 프로필 서비스: `getProfile()`, `followUser()`, `unfollowUser()` |

## 패턴
- 각 도메인은 `{Domain}ApiEndpoint` (enum 기반 URL 상수) + `{Domain}Services` (RestAPIClient 호출 함수) 쌍으로 구성
- Service 메서드 시그니처: `func method(parameters:, completion: @escaping (Result<T, NetworkError>) -> Void)`
- RestAPIClient가 HTTP 상태 코드별 분기 처리: 200/201(성공), 204(No Content), 401/403/404/422(클라이언트 에러)
- `NetworkError` enum은 `RestAPIClient.swift` 하단(line ~134)에 정의
