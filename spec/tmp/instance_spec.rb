require_relative '../spec_helper'
describe TMP::Instance do

  let(:tmp_folder_path){'/tmp/folder/path'}
  subject{ self.described_class.new(tmp_folder_path)}

  before{ allow(Dir).to receive(:mkdir).and_return(true) }

  describe '#initialize' do

    context 'when tmp folder path not given' do

      subject{ self.described_class.new }
      it 'should initialize, and set the default tmp folder by the system' do

        require 'securerandom'
        require 'tmpdir'

        expect(SecureRandom).to receive(:uuid).and_return('uuid')
        expect(subject.instance_variable_get(:@tmpdir)).to eq File.join(Dir.tmpdir,'uuid')

      end

    end

    context 'when folder path passed to the initialization' do

      it 'should return the path that passed on initialization' do
        expect(subject.instance_variable_get(:@tmpdir)).to eq tmp_folder_path
      end

    end

  end

  describe '#tmpdir' do

    it 'should return the @tmpdir content' do
      expect( subject.tmpdir ).to eq subject.instance_variable_get(:@tmpdir)
    end

  end

  describe 'File Accessors' do

    let(:file_mock){double('file mock')}
    let(:sample_object){{name: 'test',content: 'Sample Object'}}

    describe '#[]=' do

      context 'when block not given' do

        it 'should marshal dump to a temp file by the given name' do

          expect( subject ).to receive(:open).with( sample_object[:name], 'w+' ).and_yield(file_mock)
          expect( file_mock ).to receive(:write).with(Marshal.dump(sample_object[:content]))
          expect( subject[sample_object[:name]]= sample_object[:content] ).to eq sample_object[:content]

        end

      end

    end

    describe '#[]' do

      context 'when valid marshal data in the file' do

        it 'should read a tmp file content by unserialize and returning object' do

          expect( subject ).to receive(:open).with(sample_object[:name],'r').and_yield(file_mock)
          expect( file_mock ).to receive(:read).and_return(Marshal.dump(sample_object[:content]))
          expect( subject[sample_object[:name]] ).to eq sample_object[:content]

        end

      end

      context 'when marshal data too short' do

        it 'should return a nil' do

          expect( subject ).to receive(:open).with(sample_object[:name],'r').and_yield(file_mock)
          expect( file_mock ).to receive(:read).and_return('')
          expect( subject[sample_object[:name]] ).to eq nil

        end

      end

    end

    describe '#open' do

      let(:file_open_mode){'r+'}

      before do
        allow(file_mock).to receive(:flock)
      end

      context 'when file exist' do
        it 'should send lock signal thought the os for the file for a given block' do

          expect(File).to receive(:open).with(File.join(tmp_folder_path,sample_object[:name]),file_open_mode).and_yield(file_mock)

          expect(file_mock).to receive(:flock).with(File::LOCK_EX)
          expect(file_mock).to receive(:flock).with(File::LOCK_UN)

          block_ran = false
          subject.open( sample_object[:name], file_open_mode ) do |f|
            expect(f).to eq file_mock
            block_ran = true
          end

          expect(block_ran).to be_truthy

        end
      end

      context 'when file not exist' do

        it 'should rescue ENOENT exception, create an empty file and retry' do

          expect(File).to receive(:open).with(File.join(tmp_folder_path,sample_object[:name]),file_open_mode).once.and_raise(Errno::ENOENT)
          expect(File).to receive(:open).with(File.join(tmp_folder_path,sample_object[:name]),'a')

          expect(File).to receive(:open).with(File.join(tmp_folder_path,sample_object[:name]),file_open_mode).and_yield(file_mock)

          expect(file_mock).to receive(:flock).with(File::LOCK_EX)
          expect(file_mock).to receive(:flock).with(File::LOCK_UN)

          block_ran = false
          subject.open( sample_object[:name], file_open_mode ) do |f|
            expect(f).to eq file_mock
            block_ran = true
          end

          expect(block_ran).to be_truthy

        end


      end

    end

    describe '#path_for' do

      it 'should return a full path for a given name that is located in the current tmp directory' do
        expect(subject.path_for(sample_object[:name])).to  eq File.join(tmp_folder_path,sample_object[:name])
      end

    end

  end

end