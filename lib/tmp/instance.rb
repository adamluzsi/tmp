class TMP::Instance

  attr_reader :tmpdir

  def initialize(tmp_folder=nil)
    @tmpdir = tmp_folder || get_system_tmpdir
  end

  def []=(file_name, dump_object)
    open(file_name, 'w+') do |file|
      file.write(Marshal.dump(dump_object))
    end
  end

  def [](file_name)
    open(file_name, 'r') do |f|
      begin
        Marshal.load(f.read)
      rescue ArgumentError => ex
        ex.message.to_s.include?('marshal') ? nil : raise(ex)
      end
    end
  end

  def open(file_name, *args)

    file_path = path_for(file_name)

    File.open(file_path, *args) do |f|
      begin
        f.flock(File::LOCK_EX)
        yield(f)
      ensure
        f.flock(File::LOCK_UN)
      end
    end

  rescue Errno::ENOENT
    File.open(file_path, 'a') {}
    retry
  end

  def path_for(file_name)
    File.join(tmpdir, file_name)
  end

  protected

  def get_system_tmpdir

    require 'tmpdir'
    require 'securerandom'
    tmp_dir_to_use = File.join(Dir.tmpdir,SecureRandom.uuid.to_s)
    Dir.mkdir(tmp_dir_to_use) unless File.exist?(tmp_dir_to_use)

    return tmp_dir_to_use

  end

end