# Still not clear if I should be monkey patching the string class like this
# but I want to be able to do filename.is_excluded? filename.directory? etc
# where filename is a string, not a file handle

class String
  def is_excluded?
    $excluded = [ 'README.md' ] # if the file/folder name meets a certian criteria we dont want, exclude it
    if self =~ /^\./
      return true
    elsif File.symlink? self
      return true
    elseif $excluded.include? self
      return true
    end
    return false
  end
  def directory?
    return File.directory? self
  end
  def ok?
    return ! self.is_excluded?
  end
end
