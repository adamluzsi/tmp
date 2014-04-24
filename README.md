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


### Example

In the Examples i will use most likely the 'tmp' name, what is a syntax sugar
The real object(module) being called all the time is the TMP::DSL
The DSL will make easy the job on you but you can use the default methods alike:

* TMP.write( file_name, object )
* TMP.read( file_name ) #> object

```ruby

    require 'tmp'

    #> you can use the __TMP__ / __tmp__ alias as well
    tmp.hello = { hello: 'world'}

    # defined variable
    tmp.hello #> { hello: 'world'}

    # undefined variable
    tmp.sup #> nil

```

### Config

you can config the folder path for custom tmp folder use case if you dont want to use the systems default tmp folder/ your app space

```ruby

    require 'tmp'

    # set folder path if we dont want to use
    # the default system_tmp/our_project_folder_name/
    TMP.folder_path "/super/awesome/path/to/my/wished/folder"

    # to check what is the default folder path just use this
    TMP.default_folder_path #> return default path

    # to check the current path use this
    TMP.folder_path #> return the current path

```

### Get file path for the tmp object

```ruby

    require 'tmp'

    puts __TMP__.random #> nil or empty string because never used or just freshly initialized file
    puts __TMP__.random__path__ #> path to random named file,
                                # if not exist, make an empty one

```

### Remove tmp objects

you can remove tmp objects by purge them

```ruby

    require 'tmp'

    __tmp__.hello = { hello: 'world'}

    __tmp__.hello #> { hello: 'world'} -> hash obj

    TMP.purge!

    # now it's nil
    __tmp__.hello #> nil

```

### Instance use case for modules or separated tmp folders

if you want use as an instance for example for your very own module, than you can do this

```ruby

    require 'tmp'

    tmp_instance= TMP.new( File.expand_path(File.join(File.dirname(__FILE__),'tmp_folder')) )

    # use the same as the TMP::DSL aka tmp method

    # let's set a string for this one
    tmp_instance.test= "hello"

    # get the string what we just set now
    tmp_instance.test #> "hello"

    # you can get the tmp class instance obj like this:
    tmp_instance.tmp_class_instance_object #> return the tmp_instance

    # return the tmp folder path
    tmp_instance.tmp_class_instance_object.folder_path

    # Remember this instance use different folder thant the main TMP::DSL
    __tmp__.test.inspect  #> nil, because it was never used before
                      #> the tmp method is same like invoke the TMP::DSL module


```

### Blocks for file commands

using blocks is nothing like cupcake in Ruby, and just alike in this dsl


```ruby

    require 'tmp'

    # using blocks is simply as this
    __tmp__.some_file_name do |file|
      file.write Random.rand(100...1000)
    end

    # reopen the new file is also simple
    __tmp__.some_file_name do |file|

      while line = file.gets
        puts line
      end

      file.write Random.rand(100...1000)

    end

    # you can set the file mod if you like, by default it's based on file e
    __tmp__.some_file_name "w+" do |file|

      while line = file.gets
        puts line
      end
      # totaly nothing writed out to console because the "w+"

      file.write "hello world!"

    end

    puts __tmp__.some_file_name #> it's a string from the file we made

```

### Miscs

```ruby

    __tmp__.tmpdir          #> system temp folder

    __tmp__.project_folder  #> folder name where the project is
                            #> alias: project_name

    __tmp__.default_folder_path     #> path to the default tmp folder

    __tmp__.tmp_folder_path         #> path to the now used tmp folder
                                    #> it is resettable by passing a string to the method
                                    #> alias: folder_path

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
* implement more awesome trick
* find contributors
