class pam::params {
  $etcpamd     = '/etc/pam.d'
  $sss_enabled = true
  case $facts['os']['family'] {
    'Debian': {
      $service_names = [
        'common-account_test',
        'common-auth_test',
        'common-password_test',
        'common-session_test',
        'common-session-noninteractive_test',
      ]

      $sss = {
        common-account_test => [
          {
            type    => 'account',
            module  => 'access',
            control => 'required',
            order   => 40,
          },
          {
            type    => 'account',
            module  => 'localuser',
            control => 'sufficient',
            order   => 50,
          },
          {
            type    => 'account',
            module  => 'sss',
            control => '[default=bad success=ok user_unknown=ignore]',
            order   => 60,
          }
        ]
      }

      $default = {
        common-account_test => [
          {
            type    => 'account',
            module  => 'unix',
            control => '[success=1 new_authtok_reqd=done default=ignore]',
            order   => 10,
          },
          {
            type    => 'account',
            module  => 'deny',
            control => 'requisite',
            order   => 20,
          },
          {
            type    => 'account',
            module  => 'permit',
            control => 'required',
            order   => 30,
          },

        ]
      }
      if $sss_enabled {
        $default.each |$k,$v| {
          notify { "$k": }
          notify { "$v": }
          concat($v,$sss[$k])
        }

      
        #$services = deep_merge($default, $sss)
      } else {
        $services = $default
      }
      
    }
    default: {
    }
  }
}
