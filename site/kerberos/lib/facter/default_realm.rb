# Write a fact that returns the value of running the command
# "/bin/awk '/default_realm/{print $NF}' /etc/krb5.conf"
Facter.add('role') do
  setcode "/bin/awk '/default_realm/{print $NF}' /etc/krb5.conf"
end
