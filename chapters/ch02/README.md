# Chapter 02 - Hello World


## Goal

Create a simple executable that says Hello World"


## Let's Start

Refer to the template in chapter 01 for the code and fill in and can compare with the completed code at the end.

### Package Name
There's a special package name that indicates this is the entry point to a runnable program vs a library. It's called `main`. Let's use that.

### Imports
We need to print out some text. `"fmt"` handles I/O and can be used to write to screen, file, or any destination\*. If you want to look at all the standard libraries check out this [link](https://golang.org/pkg/)

```go
import "fmt"
```

### Code

#### Functions

##### SayHello()
Let's create a function that returns a string (which will be "Hello World").

```go
func sayHello() string {
	return "Hello World"
}
```

*Note: For those coming from other languages, the return value(s), is at the end of the function declaration*

##### main()
Whenever we use the package name `main`, Go is expecting you to have a `main` function which will be the entrypoint. Let's setup our web server and have it return the string from our `sayHello` function.

```go
func main() {
	fmt.Println(sayHello())
}

```

### Execution from root of repository

`$ go run ch02.go`


### Full Code
```go
package main

import "fmt"

func sayHello() string {
	return "Hello World"
}

func main() {
	fmt.Println(sayHello())
}
```
