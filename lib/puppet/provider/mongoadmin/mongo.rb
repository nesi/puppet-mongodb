Puppet::Type.type(:mongoadmin).provide :mongo do

  def exists?
    output = `echo 'show users'|mongo -u #{@resource[:admin]} -p #{@resource[:password]} #{@resource[:host]}:#{@resource[:port]}/admin}`
    result = $?.success?
    return false unless result
    output =~ /"user" : "#{@resource[:admin]}",/
  end

  def create

  end

  def destroy

  end

end