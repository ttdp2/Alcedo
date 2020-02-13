# Alcedo Development

## Features
- Custom landing page
- Separated supporting teams
- Automatic services

## Models

### Service
```go
struct Service {
    "id": Int
    "name": String
    "teams": [Team]
}
```

### LandingCard
```go
struct LandingCard {
    "id": Int
    "title": String
    "services": [Service]
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
