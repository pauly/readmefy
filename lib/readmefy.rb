require 'readmefy/string'

# Readmefy
# @author pauly@clarkeology.com
#
# Usage: sudo gem install readmefy
# readmefy .

class Readmefy
  def self.go dir = '.'
    readme = File.new './README.md', 'w'
    readme.write self.recurse dir
    readme.write "Still a work in progress, README auto created by https://github.com/pauly/readmefy\n"
    true
  end
  def self.recurse dir = '.'
    comments = ''
    files = Dir.entries dir
    files.each do | f |
      if f.ok?
        path = dir + '/' + f
        if path.directory?
          comments += self.recurse path
        else
          comments += self.extract_comments path
        end
      end
    end
    comments
  end
  def self.extract_comments f
    matches = IO.read( f ).scan( /((^\s*#\s)+(.+?))+/ )
    if matches[1]
      content = "===" + f + "===\n"
      for i in 0...matches.length
        content << matches[i][2] + "\n"
      end
      content << "\n"
    end
    content || ''
  end
end

