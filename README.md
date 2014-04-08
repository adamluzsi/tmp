tmp
===

Ruby DSL for manage tmp files and make easy
tmp commands / variables to file system
Sometimes usefull for forked processes.

I'ts not made for shared memory management!
The main goal is to provide dsl for easy tmp files making on the filesystem


### Example

```ruby
    require 'tmp'

    TMP.write :test, {hello: 'world'}
    puts TMP.read(:test)

    # or you can use syntax sugar!
    tmp.hello = { hello: 'world'}

    # defined variable
    puts tmp.hello #> { hello: 'world'}

    # undefined variable
    puts tmp.sup #> nil
```