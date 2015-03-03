PDFKit.configure do |config|

  config.wkhtmltopdf = '/usr/bin/wkhtmltopdf-amd64'
 
#  config.wkhtmltopdf = '/home/james/wkhtmltox/bin/wkhtmltopdf'
 
  config.default_options = {
    :page_size => 'Letter'#,
#    :print_media_type => true
  }
#  # Use only if your external hostname is unavailable on the server.
#  config.root_url = "http://localhost"
  config.verbose = true
end
