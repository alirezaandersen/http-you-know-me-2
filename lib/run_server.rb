#!/usr/bin/env ruby
require './lib/web_server'

server = WebServer.new
server.loop_server
