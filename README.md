A graphical user interface to use the ToDone tasks standard.

Check more about the [ToDone standard](https://github.com/UriMtzF/todone-lib).

## Features
- Create tasks
- Set as done or undone
- Delete tasks

## Supported platforms
- Linux (Tested)
- Android (Tested on Android 10)
- Windows (Not tested, but should work)

### Linux support 
Linux support is good however you need to have installed `xdg-user-dirs` in order to make it work.

## FAQ
- **Why another ToDo app?**: It's a great way to learn Flutter and Dart also I always was interested in making my own implementation of a written standard of tasks as Todo.txt is kinda old and the supported apps are strange.
- **Why no Apple support?**: Technically you could run this app on Apple devices however I do not have access to a mac to compile it for Apple plattforms.
- **Why no web app?**: The way the dart library is writen always requires the usage of an IO library not available in web, also this app requires access to a file to constantly write info.
- **Is sync possible?**: Natively, no, but you can use some services like Syncthing to keep synchronization of the tasks.todo file.
- **The app is very basic, more features are planned?**: Yes, the ToDone standard allows to have dates on due, done and created tags, also tags for every task.
