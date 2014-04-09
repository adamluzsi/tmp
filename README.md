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

### Config

you can config the folder path for custom tmp folder use case if you dont want to use the systems default tmp folder/ your app space

```ruby
    require 'tmp'

    TMP::Config.folder_path File.expand_path(File.join(File.dirname(__FILE__),'tmp_folder'))

    # or you can use syntax sugar!
    tmp.hello = { hello: 'world'}
    # defined variable
    puts tmp.hello #> { hello: 'world'}
```

### Remove tmp objects

you can remove tmp objects by purge them

```ruby
    require 'tmp'

    tmp.hello = { hello: 'world'}

    # now it's set
    puts tmp.hello #> { hello: 'world'}

    TMP.purge!

    # now it's nil
    puts tmp.hello #> nil
```

### Instance use case

if you want use as an instance for example for your very own module, than you can do this

```ruby

    require 'tmp'

    # set the folder path at initialize
    tmp_instance= TMP::Instance.new( File.expand_path(File.join(File.dirname(__FILE__),'tmp_folder')) )

    tmp_instance.write :test, {hello: 'world'}

    puts tmp_instance.read :test
    puts TMP.read(:test)  #> must be nil

```

### TODO

* make ssl encryption for the tmp files opt able
* implement more awesome trick
* find contributors
