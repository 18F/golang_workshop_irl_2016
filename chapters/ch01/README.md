# Chapter 01 - Quick Concepts

## GOPATH

$GOPATH is essentially your project workspace. The environment variable must be set. Once set, the Go Toolchain will know where to place everything.


### GOPATH Structure

Inside each GOPATH, there will can be `src`, `pkg`, and `bin` directories. For developing, you only need to worry about the `src` directory. In addition, all libraries imported that are not part of the standard library that are used will be in the `src` directory.

Where you start coding your project should reflect where you will be hosting it online.

### Where to place your code

Example: Your project is at `https://github.com/orgname/projectfoo.git` online. Go doesn't need to know the protocol or ending, so strip that down to `github.com/orgname/projectfoo`.

Take the same path and make your directory: `mkdir $GOPATH/src/github.com/orgname/projectfoo`.

Once you push your changes upstream, someone else can get them by simply running `go get github.com/orgname/projectfoo`
And then they can import your code via:
```go
import (
	"github.com/orgname/projectfoo"
)
```

## GOPATH visualization

Another visualization of your workspace by running `tree`
```
. # <- your $GOPATH
├── bin
│   ├── an-imported-binary-01
│   └── your-binary
├── pkg
│   └── darwin_amd64 # Let's not worry about this stuff yet.
└── src
    ├── github.com
    │   ├── 18F
    │   │   └── cool-library # <- "go get github.com/18F/cool-library"
    │   ├── gogo
    │   │   └── protobuf # <- "go get github.com/gogo/protobuf"
    └── golang.org
        └── x
            └── oauth2 # <- "go get golang.org/x/oauth2"
```

## Dependencies

`go get` is the way of retrieving dependencies. However, it will always get the **latest** and there's no way to specify a particular version officially. However, there are tools such as [Godeps](https://github.com/tools/godep) and [glide](https://github.com/Masterminds/glide) that can pin repos to versions or commits.


## Typical Go Program Structure Template

```go
package yourPackageName

import (
	// Your imports
)

// Code, code, code, code
```

## FAQs

- Should I only use 1 GOPATH for all projects or a separate GOPATH for each individual project?
  - Depends. However, typically you use a separate workspace / GOPATH per project. It prevents pollution of dependent libraries. For example if project A use library Foo @ v2.0, and project B uses library Foo @ v3.0, the non-vendored dependency library could not exist in both versions in the same GOPATH.
