# Write a simple function called homedir that accepts a single string argument.
# It should return the conventional Linux home directory based on a username
Puppet:Parser::Functions:newfunction(:homedir,
  :type => :rvalue
  :arity => 1,
  :doc => "THis will return a typical Linux Home direcotry of the username/'
) do |args|
user = args[0]
raise ArgumentError, "We are expecting a String" unless user.class ==String

case user
when 'root'
'/root'
else 
"/home/#{user}"
  end
end

