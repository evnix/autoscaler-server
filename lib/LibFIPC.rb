#push
#pop
#reset

# File Format:
# [next_data_ptr:64it] | [data_len:64bit][data] | [data_len:64bit][data]
# [00000000]

class FIPC



	def self.sendMsg(channel,msg)

		self.push(channel,msg)

	end

	def self.receiveMsg(channel)

		self.pop(channel)

	end

	def self.push(channel,msg)

		fileName = channel+".dat"

		if File::exists?(fileName)

			file = File.new( fileName, "ab+")
			file.flock(File::LOCK_EX)
			file << [msg.length].pack("Q!")
			file << msg
			file.close()

		 else

			file = File.new( fileName, "wb+")
			file.flock(File::LOCK_EX)
			ptr=8
			file << [ptr].pack("Q!")
			file << [msg.length].pack("Q!")
			file << msg
			file.close()


		end	

		return true


	end

	def self.pop(channel)

		fileName = channel+".dat"

		if File::exists?(fileName)

			file = File.new( fileName, "rb+")
			file.flock(File::LOCK_EX)
			ptrStr = file.read(8)

			ptr = ptrStr.unpack("Q!")[0]
			file.seek(ptr)

			dataLenStr = file.read(8)
			dataLen = dataLenStr.unpack("Q!")[0]

			data = file.read(dataLen)


			ptr = file.pos

			file.seek(0)

			file << [ptr].pack("Q!")


			if ptr == file.size
				file.close
				self.reset(channel)

			else
				file.close
			end

			return data



		 else

		 	return false
		 end

	end

	def self.reset(channel)

		fileName = channel+".dat"
	

		if File::exists?(fileName) and  File.writable?(fileName)  

			File.delete(fileName)
			return true

		else

			return false

		end
	end


end
