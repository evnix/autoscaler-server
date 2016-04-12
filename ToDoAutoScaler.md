**Project Name:** CloudAutoScaler


```
Dealine: 12 April 2016
Nishant - server shutdown interface (Agent) [pending]
Avinash - code deployment server [Done]
```

```
Dealine: 8 April 2016
Nishant - Send Agent Metrics to Server (Agent) [Done!!]
Avinash - instance creation server [Done]
```

```
Dealine: 1 April 2016
Nishant - Send Agent Metrics to Server(Agent) [Pending!!]
Avinash - Run basic deployment APIs [Done]
```

```
Dealine: 25 March 2016
Nishant - Send Agent Metrics to Server(Agent) [Pending!!]
Avinash - Build a supervisor [Done]
```

```
Dealine: 18 March 2016
Nishant - Send Agent Metrics to Server(Agent) [Pending]
Avinash - Gem for RPC/IPC between two ruby processes [Done]
```

```
Dealine: 11 March 2016
Nishant - Send Agent Metrics to Server(Agent) [Pending]
Avinash - Compare local hash to remote hash & pull new code [Done]
```

```
Dealine: 28 Feb 2016
Nishant - program to fetch metrics [Done] 
Avinash - Ping repo for new code [Done]
```

```
Deadline: 26 Feb 2016
Nishant - program to fetch metrics [Ongoing-Pending]
Avinash - Auto Clone from config file [Done]
````



## To DO List
### Server
- Repository configuration [Done: Avinash]
- Clone repo [Done: Avinash]
- Ping for new code from the repository [done:Avinash]
- Deploy/Destroy new instance thru API
- Run agent in the deployed instance
- daemon that will decide when to scale up and scal down

**Servers:**
1. Cloning New Repos [Done: Avinash]
2. Ping for new code [Done: Avinash]
3. Decision making daemon

### Agent
- Library to fetch metrics
- send those metrics back to the server
- execute commands such as safely shutdown the server


### Working of the Supervisor model.
Ruby by default doesn't support the supervisor model. But it is critical to implement this model
