# Write a simple function called homedir that accepts a single string argument.
# It should return the conventional Linux home directory based on a username

Puppet::Parser::Functions.newfunction(:homedir, :arity => 1) do |args|
  raise ArgumentError, 'Expects a string' unless args.first.is_a? String
  user = args.first

  case user
  when 'root'
    return '/root'
  else
    return "/home/#{user}"
  end
end
