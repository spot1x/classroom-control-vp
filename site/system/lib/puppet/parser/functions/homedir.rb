# Write a simple function called homedir that accepts a single string argument.
# It should return the conventional Linux home directory based on a username
Puppet::Parser::Functions.newfunction(:homedir,
  :type => :rvalue,
  :arity => 1,
  :doc => 'Returns the conventional Linux home directory of a username.'
) do |args|
  user = args[0]
  raise ArgumentError, "Expects a string" unless user.class == String
  case user
  when 'root'
    '/root'
  else
    "/home/#{user}"
  end
end
