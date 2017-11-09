define pam::entry (
  Stdlib::Absolutepath                        $etcpamd = $::pam::params::etcpamd,
  String                                      $service = undef,
  Enum['password','auth','account','session','@include'] $type = undef,
  Optional[String]                            $module = undef,
  String                                      $control = undef,
  Optional[Array[String]]                     $arguments = [],
  Integer                                     $order = 10,
) {

  if 'pam_' in $module {
    die("Do not include 'pam_' in module")
  }

  if '.so' in $module {
    die("Do not include '.so' in module")
  }

  $module_real = "pam_${module}.so"
  $arguments_real = $arguments.join(' ')

  concat::fragment { "${etcpamd}/${name}":
    target  => $service,
    content => "${type} ${control} ${module_real} ${arguments_real}\n",
    order   => $order,
  }
}
