
# Readmefy by pauly@clarkeology.com
# only matches ruby comments right now on their own line, though originally I wanted this to match php comments...
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

  def self.directory? foo
    return File.directory? foo
  end

  def self.ok? foo
    if foo =~ /^\./
      return false
    elsif File.symlink? foo
      return false
    elsif [ "README.md" ].include? foo.to_s
      puts 'excluding ' + foo # never gets here
      return false
    elsif "README.md" == foo.to_s
      puts 'excluding ' + foo + ' by ==' # never gets here either
      return false
    end
    return true
  end

  def self.binary? name
    if ! self.directory? name
      open name do |f|
        while ( b = f.read( 256) ) do
          return true if b[ "\0"]
        end
      end
    end
    false
  end

  def self.recurse dir = '.'
    comments = ''
    files = Dir.entries dir
    files.each do | f |
      subdirs = []
      if self.ok? f
        path = dir + '/' + f
        if self.directory? path
          subdirs.push path
        elsif ! self.binary? path
          comments += self.extract_comments path
        end
      end
      subdirs.each do | path |
        comments += self.recurse path
      end
    end
    comments
  end

  def self.extract_comments f
    p 'extract comments from ' + f
    matches = IO.read( f.to_s ).scan( /((^\s*#\s)+(.+))+/ )
    content = ""
    if ! matches.empty?
      content = "## " + f + "\n"
      p matches
      for i in 0...matches.length
        content << matches[i][2] + "\n"
      end
      content << "\n"
    end
    content || '' # return something
  end
end

