class kerberos {
   # use an augeas resource to manage the default_realm
   # determine the proper context with the augtool shell
   augeas { 'krb5.conf':
    context  => '/files/etc/krb5.conf/libdefaults',
    changes => ['set default_realm PUPPETLABS.VM',
                'set foo bar' ]
 }
}
