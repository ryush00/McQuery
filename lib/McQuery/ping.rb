require 'socket'

module McQuery
  class Ping
    attr_reader :protocol_version, :server_version, :motd, :players_online, :players_max
    def initialize(hostname, port)
      @hostname = hostname
      @port = port
      doPing
    end

    private
    def doPing
      s = TCPSocket.open(@hostname, @port)

      s.puts "\xFE\x01"
      repl = s.gets
      s.close
      qstring = repl[3,repl.length].force_encoding("utf-16be").encode("utf-8")
      qarray = qstring.split("\0")
      qdict = {}
      @protocol_version = qarray[1]
      @server_version = qarray[2]
      @motd = qarray[3]
      @players_online = qarray[4]
      @players_max = qarray[5]
    end
  end
end