# Alcedo Development

## Features
- Custom landing page
- Separated supporting teams
- Automatic services

## Models

### Category
```go
struct Category {
    "id": Int
    "title": String
    "services": [Service]
}
```

### Service
```go
struct Service {
    "id": Int
    "name": String
    "teams": [Team]
}
```

### Team
```go
struct Team {
    "id": Int
    "name": String
    "members": [User]
}
```

### User
```go
struct User {
    "id": Int
    "name": String
    "email": String
}
```
