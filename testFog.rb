require_relative 'lib/LibRingBuffer'


r=RingBuffer.new(2)


r.push(1)
p r

r.push(2)
p r

r.push(3)
p r


r.push(4)
p r