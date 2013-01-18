require 'socket'
require 'securerandom'
require 'timeout'

module McQuery
class Query
  
  def initialize(hostname, port)
        @hostname = hostname
        @port = port
  end    

  def doQuery
    s = TCPSocket.open(@hostname, @port)
    
    s.puts "\xFE\x01"
    repl = s.gets
    s.close
    if repl[0] == "\xFF"
      #Got kick continuing...
      # length = repl[1,2].unpack('n').first
      qstring = repl[3,repl.length].force_encoding("utf-16be").encode("utf-8")
      qarray = qstring.split("\0")
      qdict = {}
      qdict[:pversion] = qarray[1]
      qdict[:sversion] = qarray[2]
      qdict[:motd] = qarray[3]
      qdict[:players] = {:online => qarray[4], :max => qarray[5]}
      return qdict
    else
      #Got wierd packet!
      return nil
    end
  end
end
end