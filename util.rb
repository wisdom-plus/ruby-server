require 'date'

module Util
  CONTENT_TYPES = {
    html: 'text/html',
    htm: 'text.html',
    txt: 'text/plain',
    css: 'text/css',
    csv: 'text/csv',
    json: 'application/json',
    png: 'image/png',
    jpg: 'image/jpeg',
    jpeg: 'image/jpeg',
    gif: 'image/gif'
  }.freeze

  class << self
    def utc_date_string
      DateTime.now.new_offset.strftime('%a, %d, %b, %Y, %H:%M:%S %Z GMT')
    end

    def ext(path)
      File.extname(path).gsub('.', '')
    end

    def content_type(ext)
      CONTENT_TYPES[ext] || 'application/octet-stream'
    end
  end
end
