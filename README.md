# AsyncSerialQueue
A serial queue supporting async tasks. The next task starts only after the previous one completes.
## Usage
Example 

Using this component is very simple. You create a queue instance and then add tasks to it.

There are three methods:

- enqueue : adds the task to the queue but also aborts all pending operations. The currently executing task (if any) will continue until it is complete, after that the added task will proceed.
- execute : executes previously enqueued tasks according to their order. Finish callback is called when all tasks were performed.
- abort : cancels all tasks except the one that is executed.

For example:

```
    private let queue = AsyncSerialQueue()
    
    queue.enqueue { finish in
       self.doFirstTaskAsync {
           finish()
       }
    }
    
    queue.enqueue { finish in
       self.doSecondTaskAsync {
           finish()
       }
    }   
    
    queue.execute {
      // all tasks are done
    }    
```

## License

AsyncSerialQueue is published under the MIT License.

See [LICENSE](https://github.com/denis-sancov/AsyncSerialQueue/blob/master/LICENSE) for the full license.
