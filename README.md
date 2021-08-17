# Automated Verification of Go Programs via Bounded Model Checking
[https://doi.org/10.5281/zenodo.5101557](![DOI link](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.5101557%20-blue))

The artifact submission contains:

    - This Markdown document,
    - a Docker image, 
	- and the Dockerfile used to build it.

The purpose of this document is to describe in details the steps required to assess the artifact associated to our paper.

With this tutorial you shouble be able to: 
  1. Load the docker image
  2. Understand how to use Gomela so that you can verify your own Go programs.
  3. Reproduce the data of the benchmarks from Figure 9 (RQ1). 
  4. Reproduce the result of the evaluation from Table 1 and Table 2 (RQ2).
  5. Install Gomela on your own machine



### Installing Docker image

First, you need to install and start Docker. See [the official Docker tutorial](https://docs.docker.com/get-started/) for more information.

The Docker image is available as both as a compressed tar archive and also
online. Choose one of the two following methods. In both cases, the container
will load an interactive terminal session from which you can use the
program ```./gomela```. 

The image also runs a webserver that can be access via the address ```0.0.0.0:8000```, this is helpful to retrieve files produced by ```gomela``` within the container.

#### Loading Docker image 

  1. To download the image from the web, run:

  ```docker pull nicolasdilley/gomela-ase21```

  2. To enter the container with an interactive terminal session, run:

  ```docker run -it -p 8000:8000 nicolasdilley/gomela-ase21```

## Step 1 : Understanding and using Gomela

Gomela is a verification tool that verifies the concurrent aspect
of Go programs. Gomela takes either the name of a GitHub
project or a list of Go files as input and generates Promela models. These
models are then fed to SPIN to verify that the models are free of errors such as deadlocks etc.
Gomela lets users give values to the statically
unknown concurrency parameters in the models to improve the
accuracy of the verification. These parameters are the variables in the
program that affects the number of goroutines or the size of channels in the
Go program.


### Hello World example


We are going to verify a simple concurrent Hello World program.

Reminder: The docker image also contains a webserver that is accessible via the address
```0.0.0.0:8000``` in your browser. This will make it easy to download file
from the container on your own computer.


Here is the code of the example:

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

You can also use your own code if you prefer. If you do, the only requirement
is that your program must contain either the declaration of at least one
channel or Mutex or a WaitGroup in order to for Gomela to generate a model. 

To verify this example or your own Go program, create a file called "hello.go"
and paste the code in it. For your convenience, ```nano``` and ```vim``` have
been installed. Place this file in a newly created folder ```./source``` by
running:
* ```mkdir source && mv hello.go source```.
  * The name of the folder (```source``` in this case) does not matter.

When this steps is done, to generate promela models from the Go source and to verify them using SPIN run:
* ```./gomela fs ./source ```

The output of the command line should be:
```
-------------------------------
Result for source:main++main5.pml
Number of states :  163
Time to verify model :  1817  ms
Send on close safety error : false.
Close safety error : false.
Negative counter safety error : false.
Double unlock error : false.
Model deadlock : false.
-------------------------------
```

This tells you that there is neither a safety nor a model deadlock in the model, i.e.,
false means that Gomela did not find such a bug in the model.

In this case Gomela reports that there are no safety errors or model
deadlocks in the Go source file ```source/hello.go```.

If we tweak the code to introduce a deadlock by removing one or both of the
receives at line 10 and 14 and rerun the command ```./gomela fs ./source```.
The output of the command line should be :

```
-------------------------------
Result for source:main++main5.pml
Number of states :  25
Time to verify model :  1644  ms
Send on close safety error : false.
Close safety error : false.
Negative counter safety error : false.
Double unlock error : false.
Model deadlock : true.
-------------------------------
```

This tells you that a model deadlock was found in the model. The generated
model is named ```main++main5.pml``` which comes from the concatenation of
the name of the package, the name of the function being modelled and the line
number at which the function is declared. 

The extension of the file ```.pml``` is used to specify that it is a Promela
file. In the code above, we have specified that the name of the package was
```main``` and the name of the function is ```main``` declared at line 5
hence ```main++main5.pml```.


### Verifying the paper's running example (Function preload() in Fig. 1)

The function ```preload``` from the paper in Fig. 1 can be found in [examples/preload_simplifed.go](https://github.com/nicolasdilley/Gomela/blob/rewrite/examples/preload/preload_simplifed.go). 
This function contains a deadlock when ```0 < runtime.NumCPU()``` and ```0 < n <|trees|−1```

To verify this program, we need Gomela to generate a model:

```./gomela fs examples/preload  # runtime : ~46s```s

This creates a folder ```./result_<current_date>``` which contains the Promela model genarated in ```./results_<current_date>/preload/main++preload8.pml```. (Make sure to replace <current_date> with the corresponding date at which the results folder was created)

If we look inside the model by running 
```cat result_<current_date>/preload/main++preload8.pml```

we can see that at line 7, 8 and 9, ```variable var_n8```,
```preload_runtime_NumCPU__```, ```var_trees8``` which refers to variable n,
runtime.NumCPU() and trees respectively in the original program and needs to
be given a proper value because they are mandatory variables
(currently assigned to ```??```). 

These value can be assigned by Gomela when verifying the model by giving them
as arguments of the ```verify``` command in the order they appear in the
model. 


To verify, the model where n = 1, runtime.NumCPU = 2 and trees = 3, run:

```./gomela verify result_<current_date>/preload/main++preload8.pml 1 2 3 # runtime : ~2s ```

The output should be similar to 
```
-------------------------------
Result for result2021-07-13--16:06:46/preload/main++preload8.pml
Number of states :  117
Time to verify model :  4537  ms
Send on close safety error : false.
Close safety error : false.
Negative counter safety error : false.
Double unlock error : false.
Model deadlock : true.
-------------------------------

```

which states that Gomela has found a model deadlock in the model for these values.


``` ./gomela fs s author/project_name```


### Verifying a Go project from Github

To verify a github project, e.g., to verify [golang/go](https://github.com/golang/go/), run

```./gomela fs s golang/go ```

The result of the verification will be printed to the terminal as it is running.
Aditionally all the results of the verification can be found in  ```./results_<current_date>/verification.csv```
which reports all the results of the verification of each model extracted from the project.

There is one line per verification (i.e., valued model). 
A line is composed of: 
  - Column 1: The name of the model
  - Column 2: Whether the verification contained any valued optional parameter (1 if it did, 0 otherwise)
  - Column 3: The number of states in the model 
  - Column 4: The time taken to verify the model
  - Column 5: If a send on close error was found
  - Column 6: If a close safety error was found
  - Column 7: If a negative counter error was found
  - Column 8: If a double lock safety error was found
  - Column 9: If a model deadlock was found
  - Column 10: If there was any error, it would appear here
  - Column 11: The number of communication parameter in the model
  - Column 12: The number of optional parameter in the model
  - Column 13: The name of the communication parameter and their assigned values
  - Column 14: The github link of the original program if it was on github

## Step 2 Reproducing Experimental Results for RQ1

To apply Gomela on all benchmark examples (which can be found in ```./benchmarks```)
in the paper simply run: 

``` ./gomela fs benchmarks # runtime: ~2m```

which will output all the results of the verification.

Those information can also be found in ```results_<current_date>/verification.csv```
which reports all the results of the verification of each benchmark.

The spreadsheet with all results from evaluating the benchmarks with Gomela, GCatch and Godel2
can be found [here](https://github.com/nicolasdilley/gomela-ase21/blob/main/benchmarks/benchmark-results.csv).
In this table, 1 means that the model did contain the specified bug, 0 means that it was free of the bug and -1 means that the tool could not find a result (e.g., crash).

The information in the spreadsheet are displayed as follow:
  - Column 1: Name of the go file 
  - Column 2: Time taken by Gomela to verify the program
  - Column 3: Whether a send on a closed channel safety error was found by Gomela 
  - Column 4: Whether a close on a closed channel safety error was found by Gomela
  - Column 5: Whether a Waitgroup safety error was found by Gomela
  - Column 6: Whether a Mutex safety error was found by Gomela
  - Column 7: Whether a model deadlock was found by Gomela
  - Column 8: Time taken by GCatch to verify the program 
  - Column 9: Whether a missing unlock safety error was found by GCatch 
  - Column 10: Whether a double lock error was found by GCatch
  - Column 11: Whether a BMOC error was found by GCatch
  - Column 12: Time taken by Godel2 to verify the program 
  - Column 13: Whether the model generated by Godel2 was finite control 
  - Column 14: Whether the model generated by Godel2 had a terminal state 
  - Column 15: Whether the model generated by Godel2 had no cycle
  - Column 16: Whether a model deadlock was found in the model by Godel2
  - Column 17: Whether a partial deadlock was found in the model by Godel2
  - Column 18: Whether a channel safety error was found in the model by Godel2
  - Column 19: Whether a the model generated by Godel2 is free from any data race 
  - Column 20: Whether all messages sent in the model generated by Godel2 are received.
  - Column 21: The result of running Godel2 on the program. (found = did Godel2 found the bug, crashed= Godel2 crashed, missed= false alarm raised by Godel2)


## Step 3 Reproducing Experimental Results for RQ2 (Tables 1 and 2)

The list of projects (along with their commit) can be found in ```./commits.csv```

To fully model and verify all 99 Github projects, the required time is more
than 15hours. Therefore, for your convenience, the image already contains the
models and the results of the verification in ```RQ2-results```. 

to get these run:
```./gomela full_stats RQ2_results/log.csv commits.csv RQ2_results/verification.csv```


However, to automate the verification of the 99 GitHub projects, run:

```./gomela fs l commits.csv # runtime modelling depends on internet connection to download Github projects, ~10h for verification```

This will go through each project in ```./commits.csv```, git clone each
projects, generate all the Promela models and verify them. (This can take up
to more than 10 hours to verify + the time taken to download all Github projects.)

Gomela can also parse the results of the verification to extract: 
  - The five-number summary for the number of models generated per project 
  - The five-number summary for the number of models generated per package 
  - The five-number summary for the number of communication parameters per model
  - The five-number summary of the time taken to verify each project, model and valuation

It can also calculate the five-number summary for the results of all verification or only
for valuation that resulted in a strictly positive score:
  - The five-number summary for the model deadlock found
  - The five-number summary for the channel safety errors found
  - The five-number summary for the waitgroup safety errors found
  - The five-number summary for the mutex safety errors found

To get these run: 
```./gomela full_stats result_<current_date>/log.csv commits.csv result_<current_date>/verification.csv```

## Installing Gomela on your own machine

This tutorial is primarly intended at MacOs users. Linux users should
be able to follow similar steps (see also the Dockerfile).

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

