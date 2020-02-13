import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.post("todos", use: todoController.create)
    app.delete("todos", ":todoID", use: todoController.delete)
    
    let userController = UserController()
    app.get("users", use: userController.index)
    app.post("users", use: userController.create)
    
    let teamController = TeamController()
    app.get("teams", use: teamController.index)
    app.post("teams", use: teamController.create)
    
    let serviceController = ServiceController()
    app.get("services", use: serviceController.index)
    app.post("services", use: serviceController.create)
    
    let categoryController = CategoryController()
    app.get("categories", use: categoryController.index)
    app.post("categories", use: categoryController.create)
}
