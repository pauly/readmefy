require 'readmefy/string'

# Readmefy
#
# Usage: sudo gem install readmefy
# readmefy .

class Readmefy
  def self.recurse dir = nil, mode = 'w'
    dir ||= '.'
    comments = ''
    files = Dir.entries dir
    File.open( './README.md', mode ) { | readme |
      files.each do | f |
        if f.ok?
          path = dir + '/' + f
          if path.directory?
            self.recurse path, 'a'
          else
            comments += self.extract_comments path
          end
        end
      end
      readme.write comments
      if mode == 'w'
        readme.write "\n\nStill a work in progress, README auto created by https://github.com/pauly/readmefy\n"
      end
    }
    files # return
  end
  def self.extract_comments f
    content = "===" + f + "===\n"
    # content << IO.read( f ).match( /(^\s*(#|\*).*\n)+/ )
    content || ''
  end
end

