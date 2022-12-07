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
  BASE_DIR = 'src'.freeze
  ABSOLUTE_BASE_DIR = File.expand_path(BASE_DIR, __dir__)

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

    def valid_path?(path)
      absolute_file_path = File.expand_path(File.join(ABSOLUTE_BASE_DIR), path)
      absolute_file_path.start_with?(ABSOLUTE_BASE_DIR)
    end
  end
end
