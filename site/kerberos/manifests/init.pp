class kerberos {
   # use an augeas resource to manage the default_realm
   # determine the proper context with the augtool shell
   augeas { 'update Kerberos default_realm':
     context => '/files/etc/krb5.conf/libdefaults',
     changes => [ 'default_realm EXAMPLE.COM',
                  'foo bar',
                  'baz quux' ],
   }
}
