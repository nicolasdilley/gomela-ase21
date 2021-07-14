### Installing Docker image

First, you need to install and start Docker. 
The information can be found [here](https://docs.docker.com/get-started/).

The Docker image is available as both as a compressed tar archive and also
online. Choose one of the two following methods. In both cases, the container
will load an interactive terminal session from which you can use the
program ```./gomela```. 
The image also serves a webserver that can be access via the address ```0.0.0.0:8000```.

#### Loading Docker from a tar archive
  1. Ensure you are in the root of this artifact. 
  You should see the compressed tar archive gomela-ase21.tar.

  2. To load the Docker container from this archive, run:

  ```docker load < gomela-ase21.tar```

  3. To enter the container with an interactive terminal session, run:

  ```docker run -it -p 8000:8000 gomela-ase21```

#### Loading Docker from online

  1. To download the image from the web, run:

  ```docker pull nicolasdilley/gomela-ase21```

  2. To enter the container with an interactive terminal session, run:

  ```docker run -it -p 8000:8000 nicolasdilley/gomela-ase21```

## Installing Gomela on your own machine

(This tutorial is primarly intended at Linux/MacOs users)

To use Gomela, there are two main requirement:

The first one is Go, which can downloaded [here](https://golang.org/dl/).
After running the installation, Go will be installed in your home folder.
The second requirement is SPIN. The manual for installation on various OS
can be found [here](http://spinroot.com/spin/Man/README.html#S2).

The third and final requirement is timeout, which is installed natively on linux.

To install timeout on MacOS, 
* ``` brew install coreutils ```


To install Gomela you need to run to run a few commands in the terminal by running :
* ```go get github.com/nicolasdilley/gomela && cd ~/go/src/github.com/nicolasdilley/gomela && go install```

  * This downloads the Gomela project
  * Fetchs all the dependencies and library that it needs to compile.

You then need to compile it by running:
* ```go build```

  * This command generates an executable called ```gomela```. Now, we are ready to run Gomela.



## Step 1 : Understanding and using Gomela

Gomela is a full-scale verification tool that verifies message passing
concurrency in Go programs. Gomela takes either the name of a Go's github
project or a list of Go files as input and generates Promela models. These
models are then fed to SPIN to verify that the models are free of deadlocks.
Gomela also offers the ability to the user to give bounds to the statically
unknown communication-related parameters in the models to improve the
accuracy of the verification. These parameters are the variables in the
program that affects the number of goroutines or the size of channels in the
Go program.


### Hello world example


To start of we are going to verify a simple concurrent hello world example.

The docker image also contains a webserver that is accessible via the address ```0.0.0.0:8000```. 
This will make it easy to upload and download file to the image. 


Here is the code:

```
package main

import "fmt"

func main() {
  ch := make(chan string) // creates a channel

  go print(ch, "hello") // spawns a goroutine that will send 'hello' on ch

  fmt.Println(<-ch) // prints what is received from ch

  go print(ch, "world ") // spawns a goroutine that will send 'world' on ch

  fmt.Println(<-ch) // prints what is received from ch
}

func print(ch chan string, toSend string) {
  ch <- toSend // send the value of toSend on ch
}
```

You can also use your own code. If you do, the only requirement to have Gomela
generate a model from your program is that your program must contain either
the declaration of at least one channel or Mutex or a WaitGroup. 

To verify this example or your own Go program, create a file called "hello.go"
and paste the code in it. For your convenience, ```nano``` and ```vim``` have
been installed. Place this file in a newly created folder ```./source``` by
running:
* ```mkdir source && mv hello.go source```.
  * The name of the folder (```source``` in this case) does not matter.

When this steps is done, to generate promela models from the Go source and to verify them using SPIN run :
* ```./gomela fs ./source ```

The output of the command line should be:
```
-------------------------------
Result for main_main.pml
Number of states :  29
Time to verify model :  0  ms
Send on close safety error : false.
Close safety error : false.
Negative counter safety error : false.
Double unlock error : false.
Model deadlock : false.
-------------------------------
```

This tells you that there is neither a safety or a model deadlock in the model.
false in the case means that Gomela did not find the corresponding bug in the model.

This also means that Gomela reports that there are no safety errors or model
deadlocks in the Go source file ```source/hello.go```.

If we tweak the code to introduce a deadlock by removing one or both of the
receives at line 10 and 14 and rerun the command ```./gomela fs ./source```.
The output of the command line should be :

```
-------------------------------
Result for main_main.pml
Number of states :  9
Time to verify model :  0  ms
Send on close safety error : false.
Close safety error : false.
Negative counter safety error : false.
Double unlock error : false.
Model deadlock : true.
-------------------------------
```

This tells you that a model deadlock was found in the model. The generated
model is named ```main_main.pml``` which comes from the concatenation of the
name of the package and the name of the function being modelled. The
extension of the file ```.pml``` is used to specify that it is a Promela
file. In the code above, we have specified that the name of the package was
```main``` and the name of the function is ```main``` hence ```main_main.pml```.