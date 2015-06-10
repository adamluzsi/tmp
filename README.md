TMP
===

Ruby DSL for temporally files read/write in the object oriented way (system tmp).
Manage tmp files in the super easy way!

This dsl let you have simply way to commands and create variables on file system,
by default in the actual systems (cross platform) tmp folder.

Sometimes it can be useful for multi processing (forked processes),
but the main goal is not made for shared memory management!
The goal is to provide dsl for easy tmp files making on the filesystem in the object oriented way
(real objects and not simply strings)

By default i's always IO work and not memory,
everything you save with this will be IO command and not memory management
Every IO command handled by the systems File lock "mutex", 
so there will be no different data in different proc threads.

### Example

```ruby

    tmp = TMP.new
    
    # get current tmpdir
    tmp.tmpdir #> current tmp dir
    
    # get 'cat' value
    tmp['cat'] #> nil
    
    # set 'cat' value
    tmp['cat'] = {a:1}
    
    # get 'cat' value and compare to an object
    tmp['cat'] == {a:1} #> true
    
    # this will also handled with system io mutex 
    tmp.open('something','w+') do |f|
    
      p f.read
    
    end
    

```

### Config

you can config the folder path for custom tmp folder use case if you dont want to use the systems default tmp folder/

```ruby

    require 'tmp'
    tmp = TMP.new "/super/awesome/path/to/my/wished/folder"

```


### File mod cheat sheet

```ruby

    #
    # Mode |  Meaning
    # -----+--------------------------------------------------------
    # "r"  |  Read-only, starts at beginning of file  (default mode).
    # -----+--------------------------------------------------------
    # "r+" |  Read-write, starts at beginning of file.
    # -----+--------------------------------------------------------
    # "w"  |  Write-only, truncates existing file
    #      |  to zero length or creates a new file for writing.
    # -----+--------------------------------------------------------
    # "w+" |  Read-write, truncates existing file to zero length
    #      |  or creates a new file for reading and writing.
    #     -----+--------------------------------------------------------
    # "a"  |  Write-only, starts at end of file if file exists,
    #      |  otherwise creates a new file for writing.
    # -----+--------------------------------------------------------
    # "a+" |  Read-write, starts at end of file if file exists,
    #      |  otherwise creates a new file for reading and
    #      |  writing.
    # -----+--------------------------------------------------------
    #  "b" |  Binary file mode (may appear with
    #      |  any of the key letters listed above).
    #      |  Suppresses EOL <-> CRLF conversion on Windows. And
    #      |  sets external encoding to ASCII-8BIT unless explicitly
    #      |  specified.
    # -----+--------------------------------------------------------
    #  "t" |  Text file mode (may appear with
    #      |  any of the key letters listed above except "b").
    #

```

### TODO

* make ssl encryption or chmod persm change for the tmp files protection as options
* create destructor upon tmp object destruction
