Puppet::Type.type(:mongoadmin).provide(:ruby) do

  def exists?
    output = `echo 'show users'|mongo -u #{self[:admin]} -p #{self[:password]} #{self[:host]}:#{self[:port]}/admin}`
    result = $?.success?
    return false unless result
    output =~ /"user" : "#{self[:admin]}",/
  end



end