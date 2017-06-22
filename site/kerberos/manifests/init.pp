class kerberos {
   # use an augeas resource to manage the default_realm
   # determine the proper context with the augtool shell

   augeas { 'change default_realm in krb.conf using augeaus':
     context => '/files/etc/krb.conf/libdefaults',
     changes => [ 'set default_realm EXAMPLE.COM',
                  'set foo bar',
                  'set 3rd line',
                ],
   }

}
