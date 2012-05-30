Puppet::Type.newtype(:mongoadmin)
  @doc = "Create a mongo administrator."

  ensurable

  newparam(:host) do
    desc      "The name of the database server hosting this database. (Accepts 'localhost', a FQDN, or IP address.)"
    defaultto "localhost"
    validate do |value|
      unless value =~ /^(localhost|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}|(\d{1,3}\.){3}\d{1,3})$/
        raise ArgumentError, "$s is not a valid hostname" % value
    end

    munge do |value|
      case value
      when :'127.0.0.1'
        :localhost
      else
        super
      end
    end
  end

  newparam(:port) do
    desc "The TCP port connecting to the database on the host (expects a 5 digit port)"
    defaultto '27017'
    validate do |value|
      unless value =~ /^\d{5}$/
        raise ArgumentError, "%s is not a valid TCP port" % value
      end
    end
  end

  newparm(:admin) do
    desc "The user who is the administrator of the databse. (Only word characters and underscores are accepted. Minimum length, 5 characters)"
    validate do |value|
      unless value =~ /^\w{5,}$/
        raise ArgumentError, "%s is not a valid user name" % value
      end
    end
  end

  newparm(:password) do
    desc "The administrator user's password (Only alphanumeric characters and underscores are accepted. Minimum length, 5 characters)"
    validate do |value|
      unless value =~ /^(\w|\d){5,}$/
        raise ArgumentError, "%s is not a password name" % value
      end
    end
  end

  def exists?
    output = `echo 'show users'|mongo -u #{self[:admin]} -p #{self[:password]} #{self[:host]}:#{self[:port]}/admin}`
    result = $?.success?
    return false unless result
    output =~ /"user" : "#{self[:admin]}",/
  end

end