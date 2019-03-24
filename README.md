# AsyncSerialQueue
A serial queue supporting async tasks. The next task starts only after the previous one completes.
## Usage
Example 

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
