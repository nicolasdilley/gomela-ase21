# Automated Verification of Go Programs via Bounded Model Checking

The artifact submission contains:

    - This Markdown document, and
    - a Docker image, and the Dockerfile used to build it.

The purpose of this document is to describe in details the steps required to assess the artifact associated to our paper.

The aim of this tutorial is that you are able to: 
  1. Install the docker image
  2. Understand how to use our tool so that you can verify your own Go programs.
  3. Reproduce the data of the benchmarks from Figure 9. 
  4. Reproduce the result of the evaluation from Table 1 and Table 2.
  5. Install Gomela on your own machine


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


### Verifying running example "Preload" from paper (Fig. 1)

The function ```Preload``` from the paper in Fig. 1 can be found in [examples/preload_simplifed.go](https://github.com/nicolasdilley/Gomela/blob/rewrite/examples/preload/preload_simplifed.go). 
This function contains a deadlock when ```0\<runtime.NumCPU()``` and ```0\<n\<|trees|−1```

To verify that the function indeed contains a deadlock, we need to first generate a model:

```./gomela fs examples/preload```

This creates a folder ```./result_current_date``` which contains the Promela model genarated in ```./results_current_data/preload/main++preload8.pml```. (make sure to replace "current_date" with the corresponding date at which the results folder was
created)

If we look inside the model by running 
```cat result_current_date/preload/main++preload8.pml```

we can see that at line 7, 8 and 9, ```variable var_n8```,
```preload_runtime_NumCPU__```, ```var_trees8``` which refers to variable n,
runtime.NumCPU() and trees respectively in the original program and needs to
be given a proper value because they are mandatory variables
(currently assigned to ```??```). 

These value can be assigned by Gomela when verifying the model by giving them
as arguments of the ```verify``` command in the order they appear in the
model. 


To verify, the model where n = 1, runtime.NumCPU = 2 and trees = 3, run:

```./gomela verify result_current_date/preload/main++preload8.pml 1 2 3```

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

which states that Gomela has found a model deadlock in the model.


``` ./gomela fs s author/project_name```


### Verifying a project from Github. 

To verify a github project: 
Ie. to verify [golang/go](https://github.com/golang/go/)

```./gomela fs s golang/go```

The result of the verification will be printed to the terminal as it running.
However, all the results of the verification can be found in  ```./results_current_date/verification.csv```
which reports all the results of the verification of each model extracted from the project.

There is one line per verification. 
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

## Step 2 Reproducing data from benchmark from research question 1 in the paper.

To apply Gomela on all benchmarks (which can be found in ```./benchmarks```)
in the paper simply run: 

``` ./gomela fs benchmarks ```

which will output all the results of the verification.

Those information can also be found in ```results_current_date/verification.csv```
which reports all the results of the verification of each benchmark.

The spreadsheet with all results from evaluating the benchmarks with Gomela, GCatch and Godel2  
can be found [here](https://github.com/nicolasdilley/gomela-ase21/blob/main/benchmarks/benchmark-results.csv).
A result of 1 means that the model did contain the specified bug, 0 if it was free of the bug and -1 if the tool
could find a result.

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


## Step 3 Reproducing data from verifying 99 Github projects from Research Question 2. (Table 1 and Table 2) 

The list of projects (along with their commit) can be found in ```./commits.csv```

To automate the verification of the 99 github projects, run:

```./gomela fs l commits.csv```

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
```./gomela full_stats result_current_date/log.csv commits.csv result_current_date/verification.csv```


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


## Tutorial

[FindAll](https://github.com/google/gops/blob/6fb0d860e5fa50629405d9e77e255cd32795967e/goprocess/gp.go#L29)
is a function that is found in an open source project called [gops](https://github.com/google/gops) 
which is a command line tool to diagnose Go
processes. The original code of this function can be found [here](https://github.com/google/gops/blob/6fb0d860e5fa50629405d9e77e255cd32795967e/goprocess/gp.go#L29).
This function contains a bug only when a specific criteria is met. When the
number of ```pss``` in the code is bigger than ```concurrencyProcesses```,
the send at line 42 will block when the capacity of the channel is reached
causing a model deadlock.

To verify this function, we will place the code from line 29 - 74 in a folder
called ```source``` and invoke ```./gomela ./source -v```. Gomela will automatically
generate the Promela model and verify it. The promela model generated can be
found [here](https://github.com/nicolasdilley/Gomela/blob/rewrite/examples/findAll.pml).
Gomela will generate a model for every function in the program that does not
take a channel as a parameter. In this case, there is only one function that
does not take at least one channel as a parameter and its ```FindAll```. So only
one model will be generated.

As opposed to ```concurrencyProcesses```, the value of ```pss``` (defined at
line 31) in the source code cannot be determined at compile time. As a result,
Gomela gives ```pss``` a default value of 5 to make the model executable. In
this particular example, the default value turns out to be less than
```concurrencyProcesses``` and, therefore, SPIN reports that the model generated
does not result in any model deadlocks. However, if we want to verify the model
with a different value for ```pss```, we can specify to Gomela to give a
different value to ```pss``` by passing a special flag. If we invoke Gomela,
with this command ```./gomela -v -pss=11```. The value of pss will now be 11 and
Gomela will reports that there is a model deadlock in the model.


## Detailed explanations of the model generated.

To understand how Gomela generates Promela models from Go code, here is
an explaination of the model generated by Gomela when invoking ```./gomela```
with the Go code from [FindAll](https://github.com/google/gops/blob/6fb0d860e5fa50629405d9e77e255cd32795967e/goprocess/gp.go#L29). The Promela code can be found [here](https://github.com/nicolasdilley/Gomela/blob/rewrite/examples/findAll.pml)

```// /Users/***/go/src/github.com/nicolasdilley/gomela/source/test/test.go
typedef Chandef {
  chan sync = [0] of {int};
  chan async_send = [0] of {int};
  chan async_rcv = [0] of {int};
  chan sending = [0] of {int};
  chan closing = [0] of {bool};
  chan is_closed = [0] of {bool};
  int size = 0;
  int num_msgs = 0;
}

typedef Wgdef {
  chan Add = [0] of {int};
  chan Wait = [0] of {int};
  int Counter = 0;}

}
```

The first line shows the location of the original Go program.The ```typedef Chandef```
is the definition of the channel representation's Gomela uses to model Go's buffered and unbuffered channel. The ```typedef wg``` defines the
structure that is used to model sync.WaitGroup in Promela.

This is followed by the definition of the ```init``` process which contains
the Promela translation of the body of the function ```FindAll```.

```
  Chandef found;
  bool state = false;
  int pss = 5;
  Wgdef wg;
  Chandef limitCh;
  int i;
````

The ```Chandef``` declaration ```found``` and ```limitCh``` are the Promela
channel that represent the Go channel found [here](https://github.com/google/gops/blob/6fb0d860e5fa50629405d9e77e255cd32795967e/goprocess/gp.go#L38) and [here](https://github.com/google/gops/blob/6fb0d860e5fa50629405d9e77e255cd32795967e/goprocess/gp.go#L39).

The ```Wgdef``` declaration ```wg``` is the Promela WaitGroup that model the
sync.WaitGroup initialiased [here](https://github.com/google/gops/blob/6fb0d860e5fa50629405d9e77e255cd32795967e/goprocess/gp.go#L36).

```state``` and ```i``` are place holder variables used to hold the value
received from a channel and to uses as the index of ```for``` loops respectively.


```
  if
  :: true ->
    goto stop_process
  :: true;
  fi;
```

After that, the call ```ps.Processes()``` is ignored because it does not take a
channel as a parameter. This means that it won't impact the communication of the
model unless the call itself is blocking. In that case it is ok because the
function will be verify seperatly if its definition is given.

```if``` statements in Go are translated as a non-deterministic choice between
the two branches. So in this case, from line 8 - 10 in the Go program, the
```if``` statement is translated into a non-deterministic choice between
returning and continuing with the rest of the function's body. the ```return```
statement is translated as a ```goto``` statement which points to the end of the
body of the function.

```
  run wgMonitor(wg);
  wg.Add!pss;
  run sync_monitor(found);

  if
  :: 10 > 0 ->
    limitCh.size = 10;
    run emptyChan(limitCh)
  :: else ->
    run sync_monitor(limitCh)
  fi;
```

After that, the model spawns a monitor for the WaitGroup to monitor and manage
the state of the sync.WaitGroup. The next line models the sync.Waitgroup.Add(x)
which add x to the counter of the WaitGroup by sending that value over the
channel Add. That value is then receive on line 104, added to the counter on
line 105 and a check is done on line 106 to verify that the counter is not
smaller that 0 using the ```assert``` statement in Promela.

To monitor the states of the channels in Promela, we use different monitors
which varies according to the number of messages that the channel contains, if
the channel is closed or not and if it is synchronous or not.

A ```sync_monitor``` is spawned to monitor the channel ```found```.
```sync_monitor``` is used to monitor synchronous channel.

This is followed by an ```if``` statement which spawns a monitor for an
asynchronous channel if the size of the channel ```limitCh``` is bigger than 0
or a synchronous channel if its not. Since the size of ```limitCh``` in the
source code is a constant, the actual value of the constant is given.
```emptyChan``` is used to monitor an empty asynchronous channel.

```
    for(i : 1.. pss) {
for10:
    if
    :: limitCh.async_send!0;
    :: limitCh.sync!0 ->
      limitCh.sending?0
    fi;
    run Anonymous0(found,limitCh,wg)
  };
```

Finally, the ```range``` statement which range over each element in ```pss```
and spawns an anonymous function after sending to limitCh. Since the number of
threads in a Promela model needs to be known at compile time, the value of
```pss``` needs to be known. Therefore, ```pss``` is a communication parameter.
To verify the model with a different value for ```pss```, change the value given
at line 23.

Send and receive statements are translated as a choice between sending or
receiving on an async channel and on a sync channel. This is because as stated
above the size of a channel affects which monitors will be assigned to it.
Sending or receiving on both channel allows to account for both options.

The rest of the models is translated similarly to what has been explained above.

