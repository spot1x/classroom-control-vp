# Write a fact that returns the value of running the command
# "/bin/awk '/default_realm/{print $NF}' /etc/krb5.conf"
Facter.add('default_realm') do
  setrole "/bin/awk '/default_realm/{print $NF}' /etc/krb5.conf"
end
