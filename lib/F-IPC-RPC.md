
Ruby doesn't have good support for message passing between processes. One option is to make use of client-server setup by using sockets which is too much for simple message passing and other would be to use a message passing server like ZeroMQ.


We decided to make FIPC to allow simpler form of IPC between 2 or more ruby processes.

FIPC(File based Interprocess communication) is used for asynchronous exchange of messages between processes. 
At the heart of FIPC are channels. channels are basically structured files. The file structure is as follows

![file format](https://github.com/evnix/autoscaler-server/blob/master/lib/diagrams/FIPC.jpeg?raw=true)

The base pointer points to the first data element. base pointer is updated as the messages are consumed.

**FIPC Example:**
```ruby
#Program 1
FIPC.sendMsg("channels/1","hello_1")
```

```ruby
#Progam 2
ret = FIPC.receiveMsg("channels/1")
p ret #output: "hello_1"
```

FRPC is built on FIPC.

# FRPC
FRPC stands for File based Remote Procedure Call.
FRPC enables one to call functions defined in one process by another process.

**Example code:**
```ruby
    #Program 1
    FRPC.exec("channel0","say_hello")
    FRPC.exec("channel0","say_my_name","Tom")
```

```ruby
    #program 2
    def say_hello()
        p "Hello"
    end
    
    def say_my_name(name)
        p "Your name is "+name
    end
    
    #You may exec the following in a loop
    FRPC.run(FIPC.receiveMsg("channel0"))
    FRPC.run(FIPC.receiveMsg("channel0"))
```

**Output (Program 2):**
```
"Hello"
"Your name is Tom"
```

